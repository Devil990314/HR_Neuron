%Lorzen方程定义
function dX = Lorenz(t,X,params) 

a = params(1);
b = params(2);
c = params(3);

x=X(1); 
y=X(2); 
z=X(3);

dX = zeros(3,1);
dX(1)=a*(y-x);
dX(2)=x*(b-z)-y;
dX(3)=x*y-c*z;

end 

% function dxyz=HR_neuron(t,x)
% 
% global a;
% global b;
% global c;
% global d;
% global s;
% global r;
% global x0;
% global Iext;
% 
% dxyz=zeros(3,1);
% 
% dxyz(1)=x(2)-a*x(1)*x(1)*x(1)+b*x(1)*x(1)-x(3)+Iext;
% dxyz(2)=c-d*x(1)*x(1)-x(2);
% dxyz(3)=r*s*(x(1)-x0)-r*x(3);