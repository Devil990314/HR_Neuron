#include <math.h>
#include "mex.h"
#include "stdio.h"
#include "stdlib.h"
#include "matrix.h"

//---------------------------------------------------------------------------
// �����������
#define M prhs[0]           // Ƕ��ά��
#define X prhs[1]           // ʱ�����У���������
#define R prhs[2]           // ��������r
#define T prhs[3]           // ʱ���ӳ�

// �����������
#define S plhs[0]

// ���� C ���㺯�� (�ú��������ܺͱ��ļ�������)
double CC_FUNCTION();
double GUANLIAN_JIFEN();

//---------------------------------------------------------------------------
void 
mexFunction (int nlhs, mxArray *plhs[],			// ��������������������������
			 int nrhs, const mxArray *prhs[])	// ��������������������������
{
    double *px,r,*ps;
    int m,t,N;
    
    // ȡ���������
    m = (int) mxGetScalar(M);   // Ƕ��ά��       
    px = mxGetPr(X);            // ʱ�����У���������
    N = mxGetM(X);              // ���г���
    r = mxGetScalar(R);         // ��������r                
	t = (int) mxGetScalar(T);   // ʱ���ӳ�      
	
    // Ϊ������������ڴ�ռ�
	S = mxCreateDoubleMatrix(1,1,mxREAL); 
	
	// ȡ���������ָ��
	ps = mxGetPr(S);

    // ���� C ���㺯�� (�ú��������ܺͱ��ļ�������)
    *ps = CC_FUNCTION(m,px,N,r,t);    
	return;
}

//---------------------------------------------------------------------------
// ���� C ���㺯��
double CC_FUNCTION( int m,          // Ƕ��ά��       
                    double *px,     // ʱ�����У���������
                    int N,          // ���г���
                    double r,       // ��������r
                    int t )         // ʱ���ӳ�
{
    int Xt_cols,i,j;
    double *pxi,c1,c2,tmp,s_mean;

    Xt_cols = N/t;
    pxi = mxMalloc(Xt_cols*sizeof(double));       // ����һ������Ϊ xn_cols �� double ������
        
    tmp = 0;
    for (i=0; i<t; i++)
    {   for (j=0; j<Xt_cols; j++)
        {
            pxi[j] = px[j*t+i];                 // pxi Ϊ px �ĵ� i �У�0<=i<=t
        }
        c1 = GUANLIAN_JIFEN(pxi,Xt_cols,1,m,r);
        c2 = GUANLIAN_JIFEN(pxi,Xt_cols,1,1,r);
        tmp = tmp + (c1-pow(c2,m));
    }
    mxFree(pxi);
    
    s_mean = (double) tmp/t;
    return s_mean; 
}

//-------------------------------------------------------------------------------
//      ����������֡��ر�ע�⣺�����������Ϊ,ʱ������(������)��������������
//-------------------------------------------------------------------------------
double GUANLIAN_JIFEN( double *px, // ʱ�����У���������
                       int N,      // ���г���
                       int t,      // ʱ���ӳ�                       
                       int m,      // Ƕ��ά��       
                       double r)   // ��������r
{
    double c,tmp1,d;
    int i,j1,j2,xn_cols;

    xn_cols = N-(m-1)*t;                                // �ع����� xn ����
    
    tmp1 = 0;
    for (j1=0; j1<xn_cols; j1++)
    {   for (j2=j1+1; j2<xn_cols; j2++)
        {   for (i=0;i<m;i++)
            {
                d = fabs(px[i*t+j1] - px[i*t+j2]);    // ��i��,��j1����j2�ж�ӦԪ�����
                if (d>r)
                {
                    tmp1 = tmp1 + 1;
                    break;
                }                
            }
        }
    }
    
    if (xn_cols<=1)
        c = 0;
    else
    {
        c = (double) 2/((xn_cols)*(xn_cols-1))*tmp1;
        c = 1 - c;
    }
    return c;
}

