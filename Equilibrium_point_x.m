
%以下为文献中求平衡点公式对应的多项式,此多项式可以求出论文中I=4的数据。
clc
clear all;
syms x;
a=1.0;
b=3.0;
c=1.0;
d=5.0;
s=4.0;
r=0.002;
x01=-1.60;%x02=-1.6013
I=1.6;
eqns=x*x*x+((d-b)/a)*x*x+(s/a)*x-(c+I+s*x01)/a==0;
solve(eqns);
double(ans)


% clc
% clear all;
% syms x;
% a=1.0;
% b=3.0;
% c=1.0;
% d=5.0;
% s=4.0;
% r=0.002;
% x01=-1.60;%x02=-1.6013
% I=1;
% eqns=x*x*x+((d-b)/a)*x*x+((r*s)/a)*x-c-I-r*s*x01==0;
% solve(eqns);
% double(ans)
