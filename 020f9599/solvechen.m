function x=solvechen(x0,ti)
% global a;
% a=28;
tspan=[0 ti]; 
% x0=[0;1;0];
%    积分求解
[t,x]=ode45(@chen,tspan,x0);
% figure; plot(t,x(:,1))

%Chen 系统
function xdot = chen(~,x)
%dx/dt=a*(y-x)
%dy/dt=(c-a)*x+c*y-x*z
%dz/dt=x*y-b*z
global a;
b=3;c=28;
% xdot=[ 0,0,0];
xdot=[a*(x(2)-x(1));
     (c-a)*x(1)+c*x(2)-x(1)*x(3);
      x(1)*x(2)-b*x(3)];