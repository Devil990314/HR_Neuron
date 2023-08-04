function dx=tctll3equ(t,x);
global r
% dx=[-10*x(1)+10*x(2)+0.002*x(1)*x(3)/r;
%     -x(1)*x(3)+2*r*x(1)-x(2);
%     x(1)*x(2)-(8/3)*x3];
global   ph Fah  Fm  ep wA zeta
 

zeta=0.1;
 ph=0;
 Fm=0.1;
 Fah=0.2;
 ep=0.1;
 wA=1;
 
gt=g(x(1),1);
dy=zeros(2,1);
dx=[x(2);
   -2*zeta*x(2)-gt*(1+ep*cos(wA*t))+Fm+Fah*cos(wA*t)];

