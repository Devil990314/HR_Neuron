function [Texp,Lexp]=lyapunov(n,rhs_ext_fcn,fcn_integrator,tstart,stept,tend,ystart,ioutp)
%% 常微分方程系统的Lyapunov指数计算
%% n=number of nonlinear odes n是非线性的阶数
%% n2=n*(n+1)=total number of odes，这个不懂，应该是龙哥库塔方法的阶数
n1=n; n2=n1*(n1+1);
%% Number of steps  round是四舍五入的算法，tend和tstart，stept是给了的东西
nit = round((tend-tstart)/stept);
%% Memory allocation 内存分配，给y分配了多一点的地方，这个不懂，给cum分配和阶数一样的地方
%其他的都不懂是什么？
y=zeros(n2,1); cum=zeros(n1,1); y0=y;%这里表明y和y0其实差不多的，是比较高阶的东西，因为n2就代表这比较高阶的东西
gsc=cum; znorm=cum;
%% Initial values分配初值，把所有的初值都变成一列都给了y的第一行，当阶数为一的时候y（4）=1=y（8）=y（10）
y(1:n)=ystart(:);
for i=1:n1
    y((n1+1)*i)=1.0;
end;
t=tstart;%给t分配一个起始值
%% Main loop  把时间的次数分配个iITERLYAP
for ITERLYAP=1:nit
%% Solution of extended ode system
    [T,Y] = feval(fcn_integrator,rhs_ext_fcn,[t t+stept],y);%第一个是函数使用的算法
    %第二个是函数
    %第三个是时间区间
    %第四个是y的值
    %之后就计算出了一个时间段的T,Y的结果，这个结果应该和微分形式有关，导致了LE的求出
    t=t+stept;%t的初始值加步长
    y=Y(size(Y,1),:);%将y重新定义为Y,size是返回Y的第一列的大小,
    %总的来说就是将Y的最后一行付给y
    for i=1:n1%对于阶数为n1的东西
        for j=1:n1%再来一遍
            y0(n1*i+j)=y(n1*j+i);%将y的n1*n1的数值（2到n1*n1+1)交给y0,貌似是颠倒了一下顺序
        end;
    end;
    %%  znorm是一个n1行1列的零矩阵
    znorm(1)=0.0;%先设znorm1为0，之后将znorm1设置为y0的平方，按理说这个应该是微分方程的绝对值啊
    for j=1:n1
       znorm(1)=znorm(1)+y0(n1*j+1)^2;
    end;
    znorm(1)=sqrt(znorm(1));%平方之后在进行开方是进行开方的操作
    for j=1:n1
       y0(n1*j+1)=y0(n1*j+1)/znorm(1);%貌似是在进行归一化
    end;
    for j=2:n1
        for k=1:(j-1)
            gsc(k)=0.0;
            for l=1:n1
                gsc(k)=gsc(k)+y0(n1*l+j)*y0(n1*l+k);
            end;
        end;
        for k=1:n1
            for l=1:(j-1)
                y0(n1*k+j)=y0(n1*k+j)-gsc(l)*y0(n1*k+l);
            end;
        end;
        znorm(j)=0.0;
        for k=1:n1
            znorm(j)=znorm(j)+y0(n1*k+j)^2;
        end;
        znorm(j)=sqrt(znorm(j));
        for k=1:n1
            y0(n1*k+j)=y0(n1*k+j)/znorm(j);
        end;
    end;
    %% update running vector magnitudes
    for k=1:n1
       cum(k)=cum(k)+log(znorm(k));%出现了log（）还是不错的，看懂了一点点
    end;
    %% normalize exponent
    for k=1:n1
    lp(k)=cum(k)/(t-tstart);%这个对应上了cum有三个值
    end;
    %% Output modification
    if ITERLYAP==1
        Lexp=lp;
        Texp=t;
    else
        Lexp=[Lexp; lp];
        Texp=[Texp; t];
    end;
    if (mod(ITERLYAP,ioutp)==0)
        fprintf('t=%6.4f',t);
        for k=1:n1
            fprintf(' %10.6f',lp(k));
        end;
        fprintf('\n');
    end;
    for i=1:n1
        for j=1:n1
            y(n1*j+i)=y0(n1*i+j);
        end;
    end;
end;