#include <math.h>
#include "mex.h"
#include "stdio.h"
#include "stdlib.h"
#include "matrix.h"

//---------------------------------------------------------------------------
// �����������
#define X    prhs[0]           // ʱ�����У�������
#define FS   prhs[1]           // ����Ƶ��
#define T    prhs[2]           // ʱ��
#define M    prhs[3]           // Ƕ��ά����������
#define BMAX prhs[4]           // �����ɢ����ֵ
#define P    prhs[5]           // ���ƶ��ݷ���,Ĭ��Ϊ1

// �����������
#define KE plhs[0]

// ���� C ���㺯�� (�ú��������ܺͱ��ļ�������)
double Kolmogorov();

//---------------------------------------------------------------------------
void 
mexFunction (int nlhs, mxArray *plhs[],			// ��������������������������
			 int nrhs, const mxArray *prhs[])	// ��������������������������
{
    double *pX1,*pX2,*pKE,*pM;                  // ����һ��Ҫ������double����
    int i,j,lx1,lx2,lm,m,p,fs,bmax,t;
    
    //----------------------------------------------
          
    
    if (nrhs<6)
        p = 1;
    else
        p = (int) mxGetScalar(P);           // ���ƶ��ݷ���,Ĭ��Ϊ1   
        
    //---------------------------------------------------------------
    // ȡ���������
    pX1 = mxGetPr(X);                   // ʱ�����У���������
    lx1 = max(mxGetM(X),mxGetN(X));     // ���г���              

    fs = (int) mxGetScalar(FS);         // ����Ƶ��     
    t = (int) mxGetScalar(T);           // ʱ��
    
    pM = mxGetPr(M);
    lm = max(mxGetM(M),mxGetN(M));    
    
    bmax = (int) mxGetScalar(BMAX);     // �����ɢ����ֵ   
    
    // Ϊ������������ڴ�ռ�
	KE = mxCreateDoubleMatrix(1,lm,mxREAL); 
   
	// ȡ���������ָ��
	pKE = mxGetPr(KE);
	
    // ���� C ���㺯�� (�ú��������ܺͱ��ļ�������)
    lx2 = lx1/t;
    pX2 = (double*) mxCalloc(lx2,sizeof(double));
    for (i=0;i<lx2;i++)
    {
        pX2[i] = pX1[i*t];                // ��ʱ���ز���
    }
    
    for (i=0;i<lm;i++)
    {
        m = (int) pM[i];
        pKE[i] = Kolmogorov(pX2,lx2,fs,t,m,bmax,p);
    }    
    mxFree(pX2);
    return;
}

//-------------------------------------------------------------------------------

double Kolmogorov(double *pX,   // ʱ�����У���������
                  int n,        // ���г���
                  int fs,       // ����Ƶ��
                  int t,        // ʱ��
                  int m,        // Ƕ��ά�� 
                  int bmax,     // �����ɢ����ֵ   
                  int p)        // ���ƶ��ݷ���,Ĭ��Ϊ1
{
    int i,j,M,*pB,u,v,b;
    double tmp1,tmp2,r0,k_e,B_mean,d;

    tmp1 = 0;
    for (i=0;i<n;i++)
        tmp1 = tmp1+pX[i];
    tmp1 = tmp1/n;            // ���о�ֵ
    
    tmp2 = 0;
    for (i=0;i<n;i++)
        tmp2 = tmp2+fabs(pX[i]-tmp1);
    r0 = tmp2/n;                // ����ֵ
    
    M = n-(m-1);                // �ع�����   
    
    //mexPrintf("M = %d\n",M);	  
    
    pB = (int*) mxCalloc(M,sizeof(int));
    
    for (i=0;i<M-bmax;i++)
    {   for (j=i+p;j<M-bmax;j++)
        {
            v = 0;
            for (u=0;u<m;u++)
            {   
                if (fabs(pX[i+u]-pX[j+u])>r0)
                {
                    v = 1;
                    break;
                }
            }
        
            if (v==1)
                continue;  
            
            b = 0;
            d = 0;
            while (d<=r0)
            {    
                b = b+1;
    
                if (i+m-1+b>n-1 || j+m-1+b>n-1)
                    mexErrMsgTxt("\n����: bmax ȡֵ̫С!\n");

                d = fabs(pX[i+m-1+b]-pX[j+m-1+b]);
            }
            
            if (b>0)  
                pB[b-1] = pB[b-1]+1;
        }
    }
    
    tmp1 = 0;
    tmp2 = 0;
    for (i=0;i<M;i++)
    {
        tmp1 = tmp1 + pB[i]*(i+1);
        tmp2 = tmp2 + pB[i];
    }
    B_mean = tmp1/tmp2;
    
    k_e = -log(1-1/B_mean)*fs/t;    
    
    mxFree(pB);
    
    // mexPrintf("k = %d\n",k);	      

    return k_e;
}


