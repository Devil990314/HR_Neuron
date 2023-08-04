
% �����λ������������� - ������
% ʹ��ƽ̨ - Matlab7.1
% ���ߣ�½�񲨣��������̴�ѧ
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���luzhenbo@yahoo.com.cn
% ������ҳ��http://blog.sina.com.cn/luzhenbo2

% �ο�����:
% Thomas Schreiber and Andreas Schmitz. Surrogate time series [J]. Physica
% D, 2000, 142(3-4): 346-382.

clc
clear all
close all

%-----------------------------------------------------------------
% ���̱��ʽ
% dx/dt = sigma*(y-x)
% dy/dt = r*x - y - x*z
% dz/dt = -b*z + x*y

sigma = 16;             % Lorenz ���̲��� a = 16 | 10
b = 4;                  %                 b = 4 | 8/3
r = 45.92;              %                 c = 45.92 | 28    

y = [-1,0,1];        % ��ʼ�� (1 x 3 ��������)
h = 0.01;            % ����ʱ�䲽��

k1 = 8000;           % ǰ��ĵ�������
k2 = 3000;           % ����ĵ�������

data = LorenzData(y,h,k1+k2,sigma,r,b);
x1 = data(k1+1:end,1);

%-----------------------------------------------------------------
% �����λ�������������

x2 = SurrogateData(x1);

%-----------------------------------------------------------------
% FFT�任

[f_am1,f_ph1] = fft_AmPh(x1);
[f_am2,f_ph2] = fft_AmPh(x2);

%-----------------------------------------------------------------
% �����ʾ

fs = 1/h;
N = k2;
n = 0:N-1;
fx = fs/N*n;

figure; 
subplot(231); plot(x1); axis tight; title('Lorenz��x����')
subplot(232); semilogy(fx,f_am1); axis tight; title('����')
subplot(233); plot(fx,f_ph1); axis tight; title('��λ')

subplot(234); plot(x2); axis tight; title('Lorenz��x�����������')
subplot(235); semilogy(fx,f_am2); axis tight; title('����')
subplot(236); plot(fx,f_ph2); axis tight; title('��λ')

