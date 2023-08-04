clear;
yinit = [0.1,0.1,0.1];
orthmatrix = [1 0 0;
              0 1 0;
              0 0 1];

y = zeros(12,1);
% 初始化输入
y(1:3) = yinit;
y(4:12) = orthmatrix;
tstart = 0; % 时间初始值
tstep = 1e-3; % 时间步长
wholetimes = 1e5; % 总的循环次数
steps = 10; % 每次演化的步数
iteratetimes = wholetimes/steps; % 演化的次数
mod = zeros(3,1);
lp = zeros(3,1);
% 初始化三个Lyapunov指数
Lyapunov1 = zeros(iteratetimes,1);
Lyapunov2 = zeros(iteratetimes,1);
Lyapunov3 = zeros(iteratetimes,1);
for i=1:iteratetimes
    tspan = tstart:tstep:(tstart + tstep*steps);  
    [T,Y] = ode45(@(t,y) Lorenz_ly(t,y), tspan, y);
    % 取积分得到的最后一个时刻的值
    y = Y(size(Y,1),:);
    % 重新定义起始时刻
    tstart = tstart + tstep*steps;
    y0 = [y(4) y(7) y(10);
          y(5) y(8) y(11);
          y(6) y(9) y(12)];
    %正交化
    y0 = ThreeGS(y0);
    % 取三个向量的模
    mod(1) = sqrt(y0(:,1)'*y0(:,1));
    mod(2) = sqrt(y0(:,2)'*y0(:,2));
    mod(3) = sqrt(y0(:,3)'*y0(:,3));
    y0(:,1) = y0(:,1)/mod(1);
    y0(:,2) = y0(:,2)/mod(2);
    y0(:,3) = y0(:,3)/mod(3);
    lp = lp+log(abs(mod));
    %三个Lyapunov指数
    Lyapunov1(i) = lp(1)/(tstart);
    Lyapunov2(i) = lp(2)/(tstart);
    Lyapunov3(i) = lp(3)/(tstart);
        y(4:12) = y0';
end
% 作Lyapunov指数谱图
figure,
i = 1:iteratetimes;
plot(i,Lyapunov1,i,Lyapunov2,i,Lyapunov3)


%G-S正交化
function A = ThreeGS(V) % V 为3*3向量
v1 = V(:,1);
v2 = V(:,2);
v3 = V(:,3);
a1 = zeros(3,1);
a2 = zeros(3,1);
a3 = zeros(3,1);
a1 = v1;
a2 = v2-((a1'*v2)/(a1'*a1))*a1;
a3 = v3-((a1'*v3)/(a1'*a1))*a1-((a2'*v3)/(a2'*a2))*a2;
A = [a1,a2,a3];
end

function dX = Rossler_ly(t,X)
% Rossler吸引子，用来计算Lyapunov指数
%        a=0.15,b=0.20,c=10.0
%        dx/dt = -y-z,
%        dy/dt = x+ay,
%        dz/dt = b+z(x-c),
a = 0.20;
b = 0.20;
c = 5.7;
x=X(1); y=X(2); z=X(3);
% Y的三个列向量为相互正交的单位向量
Y = [X(4), X(7), X(10);
    X(5), X(8), X(11);
    X(6), X(9), X(12)];
% 输出向量的初始化，必不可少
dX = zeros(12,1);
% Rossler吸引子
dX(1) = -y-z;
dX(2) = x+a*y;
dX(3) = b+z*(x-c);
% Rossler吸引子的Jacobi矩阵
Jaco = [0 -1 -1;
        1 a 0;
        z 0 x-c];
dX(4:12) = Jaco*Y;
end

function dX = Lorenz_ly(t,X)
% Lorenz 吸引子，用来计算Lyapunov指数
a = 10;
b = 28;
c = 8/3;
x=X(1); y=X(2); z=X(3);
% Y的三个列向量为相互正交的单位向量
Y = [X(4), X(7), X(10);
    X(5), X(8), X(11);
    X(6), X(9), X(12)];
% 输出向量的初始化，必不可少
dX = zeros(12,1);
% Lorenz 吸引子
dX(1)=a*(y-x);
dX(2)=x*(b-z)-y;
dX(3)=x*y-c*z;
% Lorenz 吸引子的Jacobi矩阵
Jaco = [-a a 0;
        b-z -1 -x;
        y x -c];
dX(4:12) = Jaco*Y;
end


% %% 2.1 换一种计算方法
% %初始化
% a=0:0.004:4;
% Nx=200;%最终储存最后200个点
% Na=length(a);
% BF=zeros(Na,Nx);
% 
% for k=1:Na
%     a_k=a(k);
%     x0=0.234;%随便初始一个点
%     for m=1:100 %先初始100步，来排除初始点选取的干扰
%         x0=Logistic(x0,a_k);
%     end
%     xs=zeros(1,Nx);%再正式开始循环，记录下一个点在迭代时候每一个位置
%     for m=1:Nx
%         x2=x0;
%         x0=Logistic(x2,a_k);
%         xs(m)=x2;
%     end
%     %把结果保存
%     BF(k,:)=xs;
% end
% %画图%这里用scatter还是plot函数绘图都行
% figure()
% hold on
% for k=1:Na
%     a_k=a(k);
%     plot(a_k*ones(1,Nx),BF(k,:),...
%         'LineStyle','none','Marker','.','MarkerFaceColor','k','MarkerEdgeColor','k',...
%         'MarkerSize',1)
% end
% hold off
% xlabel('a')
% ylabel('x')
% 
% %% 后置函数
% function x2=Logistic(x1,a)
% %Logistic系统
% %x(n+1)=a*(1-x(n))*x(n)
% x2=a*(1-x1).*x1;
% end
