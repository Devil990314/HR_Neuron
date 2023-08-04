%只有耦合强度无时间滞后的神经元方程
function dxyz=HR_neuron_2couple(t,x)

global a1;
global b1;
global c1;
global d1;
global s1;
global r1;
global x01;
global Iext1;

global a2;
global b2;
global c2;
global d2;
global s2;
global r2;
global x02;

global I0;
global k;

dxyz=zeros(6,1);

dxyz(1)=x(2)-a1*x(1)*x(1)*x(1)+b1*x(1)*x(1)+Iext1-x(3)+k*(x(4)-x(1));%电耦合
dxyz(2)=c1-d1*x(1)*x(1)-x(2);
dxyz(3)=r1*s1*(x(1)-x01)-r1*x(3);

dxyz(4)=x(5)-a2*x(4)*x(4)*x(4)+b2*x(4)*x(4)+I0-x(6)+k*(x(1)-x(4));
dxyz(5)=c2-d2*x(4)*x(4)-x(5);
dxyz(6)=r2*s2*(x(4)-x02)-r2*x(6);