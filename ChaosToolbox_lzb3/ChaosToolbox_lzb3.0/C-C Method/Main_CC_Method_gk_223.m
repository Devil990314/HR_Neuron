clear;clc;
load('100s.mat')
start_time = 0;
y = time_100s(:,2);
X = y(start_time*20480+1:start_time*20480+2048);
maxLags = 300;

%--------------------------------------------------------------------------
% 计算
tic
[S_mean,delta_S_mean,S_cor] = CC_luzhenbo(X,maxLags);
toc

%--------------------------------------------------------------------------
% 结果做图

figure    
subplot(311)
plot(1:maxLags,S_mean); grid; title('S mean')
subplot(312)
plot(1:maxLags,delta_S_mean); grid; title('delta S mean')
subplot(313)
plot(1:maxLags,S_cor); grid; title('S cor')
