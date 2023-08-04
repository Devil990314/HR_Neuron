#include <math.h>
#include "mex.h"
#include "stdio.h"
#include "stdlib.h"


// �����������
#define X prhs[0]
#define MAXLAGS prhs[1]
#define PARTITIONS prhs[2]

// �����������
#define R plhs[0]

// ���� C ���㺯�� (�ú��������ܺͱ��ļ�������)
void amutual_run();
double max_vector();
double min_vector();
double sum_vector();
int findsn();
void print_array();

//--------------------------------------------------------

void 
mexFunction (int nlhs, mxArray *plhs[],			// ��������������������������
			 int nrhs, const mxArray *prhs[])	// ��������������������������
{
    double *px,*pr;
    int maxLags, partitions, len;
    
  
    //-----------------------------------------------    

    // ȡ���������
    px = mxGetPr(X);                            // ʱ������
    len = mxGetM(X);                            // ���г���
	maxLags = (int) mxGetScalar(MAXLAGS);       // ���ʱ��
	partitions = (int) mxGetScalar(PARTITIONS); // ���������
	
	// mexPrintf("\nlen = %d, maxLags = %d, partitions = %d\n",len,maxLags,partitions); 
	
    // Ϊ������������ڴ�ռ�
	R = mxCreateDoubleMatrix(maxLags+1,1,mxREAL); 

	// ȡ���������ָ��
	pr = mxGetPr(R);

    // ���� C ���㺯�� (�ú��������ܺͱ��ļ�������)
    amutual_run(pr,px,len,maxLags,partitions);
	return;
}

//--------------------------------------------------------
// ���� C ���㺯��

void amutual_run(double *pr,        // ����Ϣ
                 double *px,        // ʱ������
                 int len,           // ���г���
                 int maxLags,       // ���ʱ��
                 int partitions)    // ���������
{
    double max_x,min_x,width,*pPoint_end,*pP1,*pP2,sum_p1,sum_p2,tmp,a,b;
    int i,j,n,sn,tau;
    
    max_x = max_vector(px,len);
    min_x = min_vector(px,len);
    width = (max_x-min_x)/partitions;   // ������
    
    // mexPrintf("\nmax_x = %f, min_x = %f, witdh = %f\n",max_x,min_x,width); 

    pPoint_end = (double*) mxCalloc(partitions,sizeof(double));
    for (i=0;i<partitions;i++)
    {
        pPoint_end[i] = min_x + (i+1)*width;        // ÿһ�����յ�
    }

    pP1 = (double*) mxCalloc(partitions,sizeof(double));
    for (i=0;i<len;i++)
    {
        sn = findsn(px[i],pPoint_end,partitions);   // �ر�ע��:���������(��0��ʼ)
        pP1[sn] = pP1[sn]+1;
    }
    sum_p1 = sum_vector(pP1,partitions);
    for (i=0;i<partitions;i++)
    {
        pP1[i] = pP1[i]/sum_p1;                     // �����ܺ�,ת�ɸ����ܶ�
    }

    // print_array(pP1,partitions,1);

    for (tau=0;tau<=maxLags;tau++)
    {
        pP2 = (double*) mxCalloc(partitions*partitions,sizeof(double));
        for (n=0;n<len-tau;n++)
        {
            i = findsn(px[n],pPoint_end,partitions);
            j = findsn(px[n+tau],pPoint_end,partitions);
            pP2[j*partitions+i] = pP2[j*partitions+i] + 1;
        }
        sum_p2 = sum_vector(pP2,partitions*partitions);
        for (i=0;i<partitions*partitions;i++)
        {
            pP2[i] = pP2[i]/sum_p2;                     // �����ܺ�,ת�ɸ����ܶ�
        }
        // print_array(pP2,partitions,partitions);
        
        tmp = 0;
        for (i=0;i<partitions;i++)
        {    for (j=0;j<partitions;j++)
            {
                a = pP2[j*partitions+i];
                b = pP1[i]*pP1[j];
                if (a>0 && b!=0)
                {
                    tmp = tmp + a*(log(a/b)/log(2));    // ��2Ϊ�׵Ķ���
                }
            }
        }
        pr[tau] = tmp;        
        mxFree(pP2);
    }
    mxFree(pP1);
    mxFree(pPoint_end);    
}

//--------------------------------------------------------
// �����������ֵ

double max_vector(double vector[], 
                  int len)
{
    double max_value = vector[0];
    int i;
    for (i=1;i<len;i++)
    {   if (vector[i]>max_value)
        {   
            max_value = vector[i];
        }
    }
    return max_value;   
}

//--------------------------------------------------------
// ����������Сֵ

double min_vector(double vector[], 
                  int len)
{
    double min_value = vector[0];
    int i;
    for (i=1;i<len;i++)
    {   if (vector[i]<min_value)
        {   
            min_value = vector[i];
        }
    }
    return min_value;   
}

//--------------------------------------------------------
// ��������ĺ�

double sum_vector(double vector[], 
                  int len)
{
    double sum_value = 0;
    int i;
    for (i=0;i<len;i++)
    { 
        sum_value = sum_value + vector[i];
    }
    return sum_value;   
}

//--------------------------------------------------------
// �ж� xn ֵλ����һ������, �ر�ע��:���������(��0��ʼ)

int findsn(double xn,           // ����ֵ
           double point_end[],  // ȡֵ���������
           int len)             // ������
{
    int i,sn;
    for (i=0;i<len;i++)
    {   if (xn<=point_end[i])
        {
            sn = i;   
            break;
        }
    }
    return sn;
}

//--------------------------------------------------------
// ��ӡ��������

void print_array(double *pArray,    // ����ָ��(������)
                 int rows,          // ��
                 int columns)       // ��
{
    int i,j;
    for (i=0;i<rows;i++)
    {   for (j=0;j<columns;j++)
        {
            mexPrintf("%.4f ",pArray[j*rows+i]);        
        }
        mexPrintf("\n");
    }    
} 


