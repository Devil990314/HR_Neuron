#include <math.h>
#include "mex.h"
#include "stdio.h"
#include "stdlib.h"

//---------------------------------------------------------------------------
// �����������
#define Y prhs[0]           // ��ʼ�� (1 x 3 �ľ���)
#define H prhs[1]           // ����ʱ�䲽��
#define K prhs[2]           // ���ֲ���
#define DELTA prhs[3]       // Duffing���̲���1
#define A prhs[4]           // Duffing���̲���2
#define F prhs[5]           // Duffing���̲���3
#define OMEGA prhs[6]       // Duffing���̲���4

// �����������
#define Z plhs[0]           // Duffing������ֵ������ (k x 3 �ľ���)

// ���� C ���㺯�� (�ú��������ܺͱ��ļ�������)
void DUFFING_DATA();
void grkt1f();
void grkt1();

//---------------------------------------------------------------------------
void 
mexFunction (int nlhs, mxArray *plhs[],			// ��������������������������
			 int nrhs, const mxArray *prhs[])	// ��������������������������
{
    double y[3],h,delta,a,f,omega,*pz;
    int k;

   
    //-----------------------------------------------
    
    // ȡ���������
    memcpy(y,mxGetPr(Y),3*sizeof(double));  // ��ʼ�� (1 x 3 ��������)
	h = *mxGetPr(H);                        // ����ʱ�䲽��
	k = (int) *mxGetPr(K);                  // ���ֲ���
    
	delta = *mxGetPr(DELTA);            // Duffing���̲���
    a = *mxGetPr(A);    
    f = *mxGetPr(F);	
    omega = *mxGetPr(OMEGA);

    // Ϊ������������ڴ�ռ�
	Z = mxCreateDoubleMatrix(k,3,mxREAL); 
	
	// ȡ���������ָ��
	pz = mxGetPr(Z);

    // ���� C ���㺯�� (�ú��������ܺͱ��ļ�������)
    DUFFING_DATA(y,h,k,delta,a,f,omega,pz);    // y��һά�����ʵ��
	return;
}

//---------------------------------------------------------------------------
// ���� C ���㺯��
void DUFFING_DATA( double y[],           // y[]��һά������β�
                  double h,
                  int k,
                  double delta,
                  double a,
                  double f,
                  double omega,
                  double *pz )
{
    int n=3;                            // ΢�ַ����з��̸���
    double t=0;                         // ������ʼ��
    
    // Matlab����������������C������������������ռ��һ���������ڴ�
    grkt1(t,y,n,h,k,pz,delta,a,f,omega);      // pz�Ƿ������ڴ��ָ�룬����ά�����ʵ��
}

//---------------------------------------------------------------------------
void grkt1(t,y,n,h,k,z,delta,a1,f,omega)  // z[]�Ƕ�ά������β�
int n,k;
double t,h,y[],z[],delta,a1,f,omega;
{ 
    extern void grkt1f();
    int i,j,l;
    double a[4],tt,*b,*d;
    b=malloc(n*sizeof(double));
    d=malloc(n*sizeof(double));
    a[0]=h/2.0; a[1]=a[0];
    a[2]=h; a[3]=h;
    for (i=0; i<=n-1; i++) z[i*k]=y[i];
    for (l=1; l<=k-1; l++)
    {   grkt1f(t,y,n,d,delta,a1,f,omega);
        for (i=0; i<=n-1; i++) b[i]=y[i];
        for (j=0; j<=2; j++)
        {   for (i=0; i<=n-1; i++)
            {   y[i]=z[i*k+l-1]+a[j]*d[i];
                b[i]=b[i]+a[j+1]*d[i]/3.0;
            }
            tt=t+a[j];
            grkt1f(tt,y,n,d,delta,a1,f,omega);
        }
        for (i=0; i<=n-1; i++)
            y[i]=b[i]+h*d[i]/6.0;
        for (i=0; i<=n-1; i++)
            z[i*k+l]=y[i];
        t=t+h;
    }
    free(b); free(d);
	return;
}

//---------------------------------------------------------------------------
void grkt1f(t,y,n,d,delta,a,f,omega)
int n;
double t,y[],d[],delta,a,f,omega;
{ 
	t=t; 
	n=n;

	d[0] = y[1]; 
	d[1] = -delta*y[1]+a*y[0]*(1-y[0]*y[0])+f*cos(y[2]);
	d[2] = omega;

    return;
  }
  


   