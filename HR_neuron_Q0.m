function dxyz=HR_neuron_Q0(t,x)

global a1;
global b1;
global c1;
global d1;
global s1;
global r1;
global x01;
global Iext1;
global Q0;
global omega;

dxyz=zeros(3,1);

dxyz(1)=x(2)-a1*x(1)*x(1)*x(1)+b1*x(1)*x(1)-x(3)+Iext1+Q0*cos(omega*t);
dxyz(2)=c1-d1*x(1)*x(1)-x(2);
dxyz(3)=r1*s1*(x(1)-x01)-r1*x(3);