%尺度变换后神经元方程定义
function dxyz=HR_neuron_1(t,x)

global a;
global b;
global c;
global d;
global s;
global r;
global x0;
global Iext;

dxyz=zeros(3,1);

dxyz(1)=0.8*x(2)-6.25*a*x(1)*x(1)*x(1)+2.5*b*x(1)*x(1)-0.4*x(3)+0.4*Iext;
dxyz(2)=0.5*c-3.125*d*x(1)*x(1)-x(2);
dxyz(3)=r*s*(2.5*x(1)-x0)-r*x(3);
