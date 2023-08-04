
clc
clear all
close all

%导入数据




%% Lyapunov指数谱计算

% 参数设置

fs = 1;
t = ts;                   % 重构时延
% t2 = 1;                   % 迭代时延
t2 = 2;
% dg = min(m,10);           % 全局嵌入维(不能小于3，dg>=2da+1)
% dl = dg;                  % 局部嵌入维（最多获得10个Lyapunov指数）
dg = 6;
dl = 2;
o = 3;                    % 多项式拟合阶数    
p = 1;                    % 序列平均周期 (不考虑该因素时 p = 1)

%--------------------------------------------------------------------------
% Lyapunov指数谱的BBA算法

tic
[LE,K] = LyapunovSpectrum_BBA(unit,fs,t,t2,dl,dg,o,p);

figure(6)
plot(K,LE)
xlabel('K'); 
ylabel('Lyapunov Exponents (nats/s)');
% title(['Henon, length = ',num2str(k2)]);

LE = LE(:,end)
KL = sum(LE(find(LE>0)))
sumLE = sum(LE)
t = toc


% abs(lambda1-LE(1)) / max(lambda1,LE(1))


% LE = LE(:,end)

