
% 作者：巴山
% 欢迎关注matlab爱好者公众号
% Q群：531421022
% 知识星球：资源分享园地
% 抖音号：matlab. (有个点哦)
% B站号：matlabaihaozhe

clc;clear;close all
% 定义微分方程 —— ddefun
ddefun = @(t,x,Z)[Z(1,2)^2+Z(2,2)^2-6*Z(1,3)-8*Z(2,1);...
x(1)*(2*Z(2,2) - x(1)+5 - 2*Z(1,1)^2)];
% 定义时滞向量 —— lags
lags = [0.1 0.2 0.5];
% 定义历史 —— history
history =@(t)[t;exp(t)];
% 定义时间积分区间 —— tspan
tspan = [0 0.8];
sol=dde23(ddefun,lags,history,tspan);
figure('Color','w');
% plot(sol.x,sol.y)
plot(sol.x,sol.y(1,:),'r','LineWidth',2.0);
hold on
plot(sol.x,sol.y(2,:),'b--','LineWidth',2.0)
hold off
title('时滞微分方程组');
xlabel('时间 t');
ylabel('结果 y');
legend('x(t)','y(t)');