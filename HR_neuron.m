%单个神经元方程定义
function dxyz=HR_neuron(t,x)

global a;
global b;
global c;
global d;
global s;
global r;
global x0;
global Iext;

dxyz=zeros(3,1);

dxyz(1)=x(2)-a*x(1)*x(1)*x(1)+b*x(1)*x(1)-x(3)+Iext;
dxyz(2)=c-d*x(1)*x(1)-x(2);
dxyz(3)=r*s*(x(1)-x0)-r*x(3);