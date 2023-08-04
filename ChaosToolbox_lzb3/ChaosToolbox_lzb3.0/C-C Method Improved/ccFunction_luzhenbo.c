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
#define BLCOK prhs[4]       // �ֿ���

// �����������
#define S plhs[0]

// ���� C ���㺯�� (�ú��������ܺͱ��ļ�������)
double GUANLIAN_JIFEN_BLOCK_RUN();
double GUANLIAN_JIFEN_BLOCK();
double GUANLIAN_JIFEN();

//---------------------------------------------------------------------------
void 
mexFunction (int nlhs, mxArray *plhs[],			// ��������������������������
			 int nrhs, const mxArray *prhs[])	// ��������������������������
{
    double *px,r,*ps;
    int m,t,N,block;

    // ȡ���������
    m = (int) mxGetScalar(M);           // Ƕ��ά��       
    px = mxGetPr(X);                    // ʱ�����У���������
    N = mxGetM(X);                      // ���г���
    r = mxGetScalar(R);                 // ��������r                
	t = (int) mxGetScalar(T);           // ʱ���ӳ�      
	block = (int) mxGetScalar(BLCOK);   // �ֿ���
	
    // Ϊ������������ڴ�ռ�
	S = mxCreateDoubleMatrix(1,1,mxREAL); 
	
	// ȡ���������ָ��
	ps = mxGetPr(S);

    // ���� C ���㺯�� (�ú��������ܺͱ��ļ�������)
    *ps = GUANLIAN_JIFEN_BLOCK_RUN(px,N,t,m,r,block);    
	return;
}

//-------------------------------------------------------------------------------
double GUANLIAN_JIFEN_BLOCK_RUN(double *px,     // �ع�����,ÿһ��Ϊһ����
                                int N,          // ���г���
                                int t,          // ʱ���ӳ� 
                                int m,          // Ƕ��ά�� 
                                double r,       // ��������r
                                int block)      // �ֿ���
{
    double *pxn,c,c1,c2;
    int xn_cols,i,j,p=1;

    xn_cols = N-(m-1)*t;                        // �ع����� xn ����
    pxn = mxMalloc(m*xn_cols*sizeof(double));
     for (i=0; i<m; i++)
         for (j=0; j<xn_cols; j++)
             pxn[j*m+i] = px[i*t+j];
             
    c1 = GUANLIAN_JIFEN_BLOCK(pxn,m,xn_cols,r,p,block);
    c2 = GUANLIAN_JIFEN_BLOCK(px,1,N,r,p,block);
    c = c1 - pow(c2,m);   
    
    mxFree(pxn);    
    return c;
}

//-------------------------------------------------------------------------------
double GUANLIAN_JIFEN_BLOCK(double *pxn,     // �ع�����,ÿһ��Ϊһ����
                            int m,           // Ƕ��ά��,�ع����� xn ����       
                            int xn_cols,     // �ع�����,�ع����� xn ����
                            double r,        // ��������r
                            int p,           // ���ƶ��ݷ���,Ĭ��Ϊ1
                            int block)       // �ֿ���
{
    double c,*pxn_block,tmp;
    int i,j,k,xn_cols_block;    

    if (block == 1)
    {
        c = GUANLIAN_JIFEN(pxn,m,xn_cols,r,p);    
    }
    else
    {
        xn_cols_block = xn_cols/block;
        pxn_block = mxMalloc(m*xn_cols_block*sizeof(double));
        tmp = 0;
        for (k=0; k<block; k++)
        {
            for (i=0; i<m; i++)
                for (j=0; j<xn_cols_block; j++)
                    pxn_block[j*m+i] = pxn[(j*block+k)*m+i];
            tmp = tmp + GUANLIAN_JIFEN(pxn_block,m,xn_cols_block,r,p);                        
        }
        c = (double) tmp/block;
        mxFree(pxn_block);
    }
    return c;
}

//-------------------------------------------------------------------------------
//      ����������֡��ر�ע�⣺�����������Ϊ,ʱ������(������)��������������
//-------------------------------------------------------------------------------
double GUANLIAN_JIFEN( double *pxn,     // �ع�����,ÿһ��Ϊһ����
                       int m,           // Ƕ��ά��,�ع����� xn ����       
                       int xn_cols,     // �ع�����,�ع����� xn ����
                       double r,        // ��������r
                       int p)
{
    double c,d_ij,tmp1,d;
    int i,j1,j2;
    
    tmp1 = 0;
    for (j1=0; j1<xn_cols; j1++)
    {   for (j2=j1+p; j2<xn_cols; j2++)
        {   for (i=0;i<m;i++)
            {
                d = fabs(pxn[j1*m+i] - pxn[j2*m+i]);    // ��i��,��j1����j2�ж�ӦԪ�����
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
        c = (double) 2/((xn_cols-p)*(xn_cols-p+1))*tmp1;
        c = 1 - c;
    }
    
    return c;
}