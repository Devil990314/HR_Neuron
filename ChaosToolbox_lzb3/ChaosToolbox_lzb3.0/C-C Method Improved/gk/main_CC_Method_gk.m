clear;clc;
load('100s_8.mat');
start_time = 10;
X = y(start_time*2560+1:start_time*2560+2048);
X=X';
maxLags = 300;
block = 50;

%-----------------------------------------------------------------------
% �Ľ���C-C����

tic
[delta_S1_mean,delta_S1_S2] = CC_Improved(X,maxLags,block);
t = toc

%-----------------------------------------------------------------------
% �����ͼ

figure;
subplot(211); 
plot(1:maxLags,delta_S1_mean); grid; title('delta S1 mean')
subplot(212); 
plot(1:maxLags,delta_S1_S2); grid; title('delta S1 S2')
