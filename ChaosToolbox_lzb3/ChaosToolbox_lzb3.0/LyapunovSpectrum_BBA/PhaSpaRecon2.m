function [XN] = PhaSpaRecon2(X,t,t2,m)
% �������е���ռ��ع� (phase space reconstruction)
% ���������    X     ��������(������)
%              t     �ع�ʱ��
%              t2    ����ʱ��
%              m     �ع�ά��
% ���������    xn    ��ռ��еĵ�����(ÿһ��Ϊһ����)

[rows,cols] = size(X);
if (cols>rows)
    X = X';
end

n = length(X);
num = floor((n-(m-1)*t-1)/t2)+1;

XN = zeros(m,num);
for j = 1:num
    XN(:,j) = X(1+(j-1)*t2:t:1+(j-1)*t2+(m-1)*t);
end
