% function jeffcott()
global a;
Z=[];
d0=1e-8;
ti=0.1;
X1=[];
for a=linspace(25,50,26)
lsum=0;
x=0;y=1;z=0;
x1=0;y1=1;z1=d0;
for i=1:1000
%    [T1,Y1]=ode45(@Chen,1,[x;y;z;a;3;28]); 
%    [T2,Y2]=ode45(@Chen,1,[x1;y1;z1;a;3;28]);
x0=[x;y;z];
x01=[x1;y1;z1];
Y1=solvechen(x0,ti);
Y2=solvechen(x01,ti);
   n1=length(Y1);n2=length(Y2);
   x=Y1(n1,1);y=Y1(n1,2);z=Y1(n1,3);%    X=x;
   x1=Y2(n2,1);y1=Y2(n2,2);z1=Y2(n2,3);
   d1=sqrt((x-x1)^2+(y-y1)^2+(z-z1)^2);
   x1=x+(d0/d1)*(x1-x);
   y1=y+(d0/d1)*(y1-y);
   z1=z+(d0/d1)*(z1-z);
   if i>500
       lsum=lsum+log(d1/d0);
   end
end
% X1=[X1 X];
Z=[Z lsum/(i-500)];
end
a=linspace(25,50,26);
figure;plot(a,Z);
title('Chen 系统最大lyapunov指数')
xlabel('parameter a'),ylabel('lyapunov exponents')
% figure;plot(a,X1);
