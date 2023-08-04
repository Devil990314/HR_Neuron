function dX=Bao2_LE(t,X)
global b
a=1;k=0.8;
x=X(1); y=X(2); z=X(3); w=X(4);%把传递过来的初值设置好
Y=[X(5) X(9) X(13) X(17);
   X(6) X(10) X(14) X(18);
   X(7) X(11) X(15) X(19);
   X(8) X(12) X(16) X(20)];%这个是用来干什么的
dX=zeros(16,1);%先把dX站好位置16行一列的零
%%混沌系统方程
dX(1) =-x-1.4*tanh(x)+1.2*tanh(y)-7*tanh(z);
dX(2) =-y+1.1*tanh(x)+0*tanh(y)+2.8*tanh(z);
dX(3) =-z+k*(a-b*tanh(w))*tanh(x)-2*tanh(y)+4*tanh(z);
dX(4) =-w+tanh(x);
%%Jacobi矩阵
Jaco =[-1-1.4*(sech(x))^2          1.2*(sech(y))^2           -7*(sech(z))^2      0;
    1.1*(sech(x))^2                  -1                       2.8*(sech(z))^2      0;
    k*(a-b*tanh(w))*(sech(x))^2   -2*(sech(y))^2         -1+4*(sech(z))^2   -k*b*tanh(x)*(sech(w))^2;
    (sech(x))^2                 0                             0              -1];
dX(5:20) = Jaco*Y;%

%以上的数据是你创建的系统，系统方程以及雅可比矩阵，也要弄成一个m文件

clear
format long
global b

for i=1:1:61
    b=0.01*(i-1);%应该计算的是随b的李雅普诺夫函数,每次b改变都会调用下面的东西，因此下面的函数是用来计算一次b的
    [T,Res]=lyapunov(4,@Bao2_LE,@ode45,0,1,2000,[0 0.1 0 0],0);%一个b算了100分钟的时间
    %%plot(T,Res); %%画随时间变化的lyapunov指数谱，
    %这个应该是包老师自己做的函数。第一位是阶数，是三阶的。
    %第二个是函数的表现
    %第三个是使用的算法
    %第四个是时间开始为0
    %第五个是间隔
    %第六个是时间结束的时间
    %第七个是初值
    %第八个是不知道
    Lyapunov1(i) = Res(end,1);
    Lyapunov2(i) = Res(end,2);
    Lyapunov3(i) = Res(end,3);
    Lyapunov4(i) = Res(end,4);
end;
cc_val=0.01*([1:1:61]);%这个应该是b吧，因为b要从0开始
plot(cc_val,Lyapunov1(:));hold on
plot(cc_val,Lyapunov2(:));hold on
plot(cc_val,Lyapunov3(:));hold on
plot(cc_val,Lyapunov4(:));hold on
————————————————
版权声明：本文为CSDN博主「qq_44938668」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/qq_44938668/article/details/120921885