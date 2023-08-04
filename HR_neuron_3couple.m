function dxyz=HR_neuron_3couple(t,x)

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
global Iext2;

global a3;
global b3;
global c3;
global d3;
global s3;
global r3;
global x03;
global Iext3;

global H;
global Q0;
global omega;

dxyz=zeros(9,1);

dxyz(1)=x(2)-a1*x(1)*x(1)*x(1)+b1*x(1)*x(1)-x(3)+Iext1+H*(x(1)-x(4))+Q0*cos(omega*t);
dxyz(2)=c1-d1*x(1)*x(1)-x(2);
dxyz(3)=r1*s1*(x(1)-x01)-r1*x(3);

dxyz(4)=x(5)-a2*x(4)*x(4)*x(4)+b2*x(4)*x(4)-x(6)+Iext2+H*(2*x(4)-x(1)-x(7))+Q0*cos(omega*t);
dxyz(5)=c2-d2*x(4)*x(4)-x(5);
dxyz(6)=r2*s2*(x(4)-x02)-r2*x(6);

dxyz(7)=x(8)-a3*x(7)*x(7)*x(7)+b3*x(7)*x(7)-x(9)+Iext3+H*(x(7)-x(4))+Q0*cos(omega*t);
dxyz(8)=c3-d3*x(7)*x(7)-x(8);
dxyz(9)=r3*s3*(x(7)-x03)-r3*x(9);