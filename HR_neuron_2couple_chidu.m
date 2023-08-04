%只有耦合强度无时间滞后的神经元方程
%尺度变换后的方程
function dxyz=HR_neuron_2couple_chidu(t,x)

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

dxyz(1)=0.8*x(2)-6.25*a1*x(1)*x(1)*x(1)+2.5*b1*x(1)*x(1)-0.4*x(3)+0.4*Iext1+k*(x(4)-x(1));
dxyz(2)=0.5*c1-3.125*d1*x(1)*x(1)-x(2);
dxyz(3)=r1*s1*(2.5*x(1)-x01)-r1*x(3);
dxyz(4)=0.8*x(5)-6.25*a2*x(4)*x(4)*x(4)+2.5*b2*x(4)*x(4)-0.4*x(6)+0.4*I0+k*(x(1)-x(4));
dxyz(5)=0.5*c2-3.125*d2*x(4)*x(4)-x(5);
dxyz(6)=r2*s2*(2.5*x(4)-x02)-r2*x(6);



