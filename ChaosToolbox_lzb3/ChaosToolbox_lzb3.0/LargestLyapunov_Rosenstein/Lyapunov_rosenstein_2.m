function [Y] = Lyapunov_rosenstein_2(x,fs,tau,m,taumax,P)
% �������ʱ������ Lyapunov ָ����С���������� - �Լ�д
% ������ Lyapunov_rosenstein_1 ��ȫһ�� 
% �ο����ף�
% Michael T.Rosenstein,
% "A practical method for calculating largest lyapunov exponents from small sets",
% Physica D,1993,65: 117-134


%-----------------------------------------------------------------
% ��ռ��ع�

xn = PhaSpaRecon(x,tau,m);              % ÿ��Ϊһ����
N = size(xn,2);                         % ��ռ����

%-----------------------------------------------------------------
% ���ڼ���

query_indices1 = [1:N-taumax]';                 % �ο���
k = 1;                                          % ����ڵ�ĸ���
exclude = max(P-1,0);                           % ���ƶ��ݷ��룬��������ƽ������
[index1,distance1] = SearchNN2(xn,query_indices1,k,exclude);

i = find(index1 <= N-taumax);                   % Ѱ�� index_pair(:,2) ��С�ڵ��� N-taumax ���±� ��
query_indices1 = query_indices1(i);
index1 = index1(i,:);                           % ���ڵ��(ԭʼ��)
distance1 = distance1(i,:);

M = length(query_indices1);                     % ���ڵ����
Y = zeros(taumax+1,1);
for i = 0:taumax
    query_indices2 = query_indices1 + i;
    index2 = index1 + i;
    xn_1 = xn(:,query_indices2)-xn(:,index2);
    distance2 = zeros(M,1);
    for j = 1:M
        distance2(j) = norm(xn_1(:,j));
    end
    distance2;                                  % j ���Ժ�Ľ��ڵ�Ծ���
    Y(i+1) = mean(log2(distance2./distance1))*fs;
%    Y(i+1) = mean(log2(distance2))*fs;    
end

