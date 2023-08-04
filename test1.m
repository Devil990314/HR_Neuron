function dX = Chen2(t,X)
% Chen吸引子，用来计算Lyapunov指数
%   dx/dt=a*(y-x)
%   dy/dt=(c-a)*x+c*y-x*z
%   dz/dt=x*y-b*z
global a; % 变量不放入参数表中
global b;
global c;
X=zeros(3,1);
x=X(1); y=X(2); z=X(3);
% Y的三个列向量为相互正交的单位向量
Y = [X(4), X(7), X(10);
    X(5), X(8), X(11);
    X(6), X(9), X(12)];
% 输出向量的初始化
dX = zeros(12,1);
% Lorenz吸引子
dX(1) = a*(y-x);
dX(2) = (c-a)*x+c*y-x*z;
dX(3) = x*y-b*z;
% Lorenz吸引子的Jacobi矩阵
Jaco = [-a    a   0;
        c-a-z c -x;
        y     x -b];
         dX(4:12) = Jaco*Y;
Z1=[];
Z2=[];
Z3=[];
global a;
global b;
global c;
b=3;c=28;
for a=linspace(32,40,100);
    y=[1;1;1;1;0;0;0;1;0;0;0;1];
    lp=0;
    for k=1:200
        [T,Y] = ode45('Chen2', 1, y);
        y = Y(size(Y,1),:);
        y0 = [y(4) y(7) y(10);
              y(5) y(8) y(11);
              y(6) y(9) y(12)];
        y0=GS(y0);
        mod(1)=norm(y0(:,1));
        mod(2)=norm(y0(:,2));
        mod(3)=norm(y0(:,3));
        lp = lp+log(abs(mod));
        y0(:,1)=y0(:,1)/mod(1);
        y0(:,2)=y0(:,2)/mod(2);
        y0(:,3)=y0(:,3)/mod(3);
        y(4:12) = y0';
    end
    lp=lp/200;
    Z1=[Z1 lp(1)]; 
    Z2=[Z2 lp(2)]; 
    Z3=[Z3 lp(3)]; 
end
a=linspace(32,40,100);
plot(a,Z1,'-',a,Z2,'-',a,Z3,'-');
title('Lyapunov exponents of Chen')
xlabel('b=3,c=28,parameter a'),ylabel('lyapunov exponents')
grid on
%以上是三个变量的Lyapunov指数谱，下面是最大的Lyapunov指数谱：
Z=[];
d0=1e-8;
for a=linspace(32,40,80)
lsum=0;
x=1;y=1;z=1;
x1=1;y1=1;z1=1+d0;
for i=1:100
   [T1,Y1]=ode45('Chen',1,[x;y;z;a;3;28]); 
   [T2,Y2]=ode45('Chen',1,[x1;y1;z1;a;3;28]);
   n1=length(Y1);n2=length(Y2);
   x=Y1(n1,1);y=Y1(n1,2);z=Y1(n1,3);
   x1=Y2(n2,1);y1=Y2(n2,2);z1=Y2(n2,3);
   d1=sqrt((x-x1)^2+(y-y1)^2+(z-z1)^2);
   x1=x+(d0/d1)*(x1-x);
   y1=y+(d0/d1)*(y1-y);
   z1=z+(d0/d1)*(z1-z);
   if i>50
       lsum=lsum+log(d1/d0);
   end
end
Z=[Z lsum/(i-50)];
end
a=linspace(32,40,80);
plot(a,Z,'-');
title('Chen 系统最大lyapunov指数')
xlabel('parameter a'),ylabel('lyapunov exponents')