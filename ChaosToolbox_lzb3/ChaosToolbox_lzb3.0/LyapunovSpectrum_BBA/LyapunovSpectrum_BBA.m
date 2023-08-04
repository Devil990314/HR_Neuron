function [LE,K] = LyapunovSpectrum_BBA(X,fs,t,t2,dl,dg,o,p)

if nargin<8
    p = 0;
    if nargin<7
        o = 3;
    end
end


% �������ʱ������Lyapunovָ���׵�BBA�㷨
% ʹ��ƽ̨ - Matlab7.0
% ���ߣ�½�񲨣��������̴�ѧ
% ��ӭͬ�����Ž���������������������������������ҵĸ�����ҳ
% �����ʼ���luzhenbo@yahoo.com.cn
% ������ҳ��http://luzhenbo.88uu.com.cn

% �ο�����: 
%  Brown R, Bryant P, Abarbanel H D I. Computing the Lyapunov exponents of a dynamical system from oberseved time series[J]. Phys.Rev.A,1991,34:2787-2806.

%--------------------------------------------------------------------------
% ȫ���ع�,�Ի�׼�������ڵ�



XN1 = PhaSpaRecon2(X,t,t2,dg);      % ÿһ��һ�����
m = size(XN1,2);                    % ��ռ���� 

tmp = Taylor_lzb(ones(dl,1),o);
n = length(tmp);                    % Taylorչ��ʽ����
nb = 2*n;                           % ���ڵ����

I1 = [1:m-1]';                      % �ο����
I2 = SearchNN2(XN1(:,I1),I1,nb,max(0,floor(p/t2)));       % ���ڵ��±�

%--------------------------------------------------------------------------
% �ֲ��ع���Jacobian����,��QR�ֽ�

XN2 = XN1(1:dl,:);     

Q = eye(dl);
LE = zeros(dl,m-1);
tmp = zeros(dl,1);
for j = 1:m-1

    A = XN2(:,I2(j,:))-repmat(XN2(:,I1(j)),1,nb);
    A = Taylor_lzb(A,o);
    A = A';
    
    B = XN2(:,I2(j,:)+1)-repmat(XN2(:,I1(j)+1),1,nb);
    B = B';
   
    DF = (A\B)';
    DF = DF(:,1:dl);
    
    [Q,R] = qr(DF*Q);
  
    tmp = tmp + log(diag(R))/t2*fs;
    LE(:,j) = real(tmp/j);
    
end

K = 1:m-1;



