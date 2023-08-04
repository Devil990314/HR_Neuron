% function dX = Lorenz(t,X,params) 
% 
% a = params(1);
% b = params(2);
% c = params(3);
% 
% x=X(1); 
% y=X(2); 
% z=X(3);
% 
% dX = zeros(3,1);
% dX(1)=a*(y-x);
% dX(2)=x*(b-z)-y;
% dX(3)=x*y-c*z;
% 
% end 

function dX=Hindmarsh_Rose(t,X,params)
a = params(1);
b = params(2);
c = params(3);
d = params(4);
s = params(5);
r = params(6);
x0 = params(7);
Iext = params(8);

x=X(1); 
y=X(2); 
z=X(3);
dX = zeros(3,1);
dX(1)=y-a*x*x*x+b*x*x-z+Iext;
dX(2)=c-d*x*x-y;
dX(3)=r*s*(x-x0)-r*z;