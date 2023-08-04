#include <math.h>
#include "mex.h"
#include "stdio.h"
#include "stdlib.h"

//---------------------------------------------------------------------------
// �����������
#define Y prhs[0]           // ��ʼ�� (1 x 3 �ľ���)
#define H prhs[1]           // ����ʱ�䲽��
#define K prhs[2]           // ���ֲ���
#define SIGMA prhs[3]       // Lorenz���̲���1
#define R prhs[4]           // Lorenz���̲���2
#define B prhs[5]           // Lorenz���̲���3

// �����������
#define Z plhs[0]           // Lorenz������ֵ������ (k x 3 �ľ���)

// ���� C ���㺯�� (�ú��������ܺͱ��ļ�������)
void LORENZ_DATA();
void grkt1f();
void grkt1();

//---------------------------------------------------------------------------
void 
mexFunction (int nlhs, mxArray *plhs[],			// ��������������������������
			 int nrhs, const mxArray *prhs[])	// ��������������������������
{
    double y[3], h, sigma, r, b, *pz;
    int k;

    // ȡ���������
    memcpy(y,mxGetPr(Y),3*sizeof(double));  // ��ʼ�� (1 x 3 ��������)
	h = *mxGetPr(H);                        // ����ʱ�䲽��
	k = (int) *mxGetPr(K);                  // ���ֲ���
    
	sigma = *mxGetPr(SIGMA);            // Lorenz���̲���
    r = *mxGetPr(R);    
    b = *mxGetPr(B);	

    // Ϊ������������ڴ�ռ�
	Z = mxCreateDoubleMatrix(k,3,mxREAL); 
	
	// ȡ���������ָ��
	pz = mxGetPr(Z);

    // ���� C ���㺯�� (�ú��������ܺͱ��ļ�������)
    LORENZ_DATA(y,h,k,sigma,r,b,pz);    // y��һά�����ʵ��
	return;
}

//---------------------------------------------------------------------------
// ���� C ���㺯��
void LORENZ_DATA( double y[],           // y[]��һά������β�
                  double h,
                  int k,
                  double sigma,
                  double r,
                  double b,
                  double *pz )
{
    int n=3;                            // ΢�ַ����з��̸���
    double t=0;                         // ������ʼ��
    
    // Matlab����������������C������������������ռ��һ���������ڴ�
    grkt1(t,y,n,h,k,pz,sigma,r,b);      // pz�Ƿ������ڴ��ָ�룬����ά�����ʵ��
}

//---------------------------------------------------------------------------
void grkt1(t,y,n,h,k,z,sigma1,r1,b1)  // z[]�Ƕ�ά������β�
int n,k;
double t,h,y[],z[],sigma1,r1,b1;
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
    {   grkt1f(t,y,n,d,sigma1,r1,b1);
        for (i=0; i<=n-1; i++) b[i]=y[i];
        for (j=0; j<=2; j++)
        {   for (i=0; i<=n-1; i++)
            {   y[i]=z[i*k+l-1]+a[j]*d[i];
                b[i]=b[i]+a[j+1]*d[i]/3.0;
            }
            tt=t+a[j];
            grkt1f(tt,y,n,d,sigma1,r1,b1);
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
void grkt1f(t,y,n,d,sigma,r,b)
int n;
double t,y[],d[],sigma,r,b;
{ 
	t=t; 
	n=n;

	d[0] = sigma*(y[1]-y[0]); 
	d[1] = r*y[0]-y[1]-y[0]*y[2]; 
	d[2] = -b*y[2]+y[0]*y[1];

    return;
  }