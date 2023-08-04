 clc
clear

%load('steady.mat')
load('100s_16.mat')
start_time = 10;
%X=steady1(:,2);
X=y(start_time*1280+1:start_time*1280+2048);
maxLags = 300;      % 最大时延

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
