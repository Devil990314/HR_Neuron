
% �Ľ���C-C�����ع���ռ� - ������
% ʹ��ƽ̨ - Matlab7.1
% ���ߣ�½��
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���41670240@qq.com
% ������ҳ��http://blog.sina.com.cn/luzhenbo2

% �ο�����
% ½��, ��־��, ������. ���ڸĽ���C-C��������ռ��ع�����ѡ��[J]. 
% ϵͳ����ѧ��, 2007, 19(11): 2527-2529.

clc
clear
close all

%---------------------------------------------------
% ��������ʱ������
sig = 1;                     % ��ѡ1,2,3��Ӧ��������
k1 = 50000;                  % ǰ��ĵ�������
k2 = 3000;                   % ����ĵ�������
        
switch sig
    case 1
        sigma = 16;          % Lorenz ���̲��� a
        b = 4;               %                 b
        r = 45.92;           %                 c            

        y = [-1,0,1];        % ��ʼ�� (1 x 3 ��������)
        h = 0.01;            % ����ʱ�䲽��
        
        z = LorenzData(y,h,k1+k2,sigma,r,b);
    case 2
        d = 0.2;             % Rossler ���̲��� a
        e = 0.2;             %                  b            
        f = 5;               %                  c

        y = [-1,0,1];        % ��ʼ�� (1 x 3 ��������)
        h = 0.05;            % ����ʱ�䲽��
       
        z = RosslerData(y,h,k1+k2,d,e,f);
    case 3
        delta = 0.05;
        a = 0.5;
        f = 7.5;
        omega = 1;

        y = [-1,0,1];        % ��ʼ�� (1 x 3 ��������)
        h = 0.05;            % ����ʱ�䲽��

        z = DuffingData(y,h,k1+k2,delta,a,f,omega);
end

X = z(k1+1:end,1);
%X = X_gk;
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

