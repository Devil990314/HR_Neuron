function [delta_S1_mean,delta_S1_S2] = CC_Improved(X,maxLags,block);

if nargin<3
    block = 50;
end


m_vector = 2:5;
sigma = std(X);
r_vector = sigma/2*[1:4];

Sj = zeros(1,length(r_vector));
delta_S1 = zeros(length(m_vector),maxLags);
delta_S1_mean = zeros(1,maxLags);
S1_mean = zeros(1,maxLags);
S2_mean = zeros(1,maxLags);

%-----------------------------------------------------------------------
% �Ľ���C-C����
% �������׼�ϵͳ����ѧ����¼�ø�<���ڸĽ���C-C��������ռ��ع�����ѡ��5.pdf>

for t = 1:maxLags
    temp1 = 0;
    temp2 = 0;
    for i = 1:length(m_vector)
        for j = 1:length(r_vector)
            m = m_vector(i);
            r = r_vector(j);
            S1 = ccFunction_luzhenbo(m,X,r,t,block);    % �ҵ��㷨 - ����S1(m,N,r,t)
            S2 = ccFunction(m,X,r,t);                   % �����еı�׼�㷨 - ����S2(m,N,r,t)
            temp1 = temp1 + S1;
            temp2 = temp2 + S2;
            Sj(j) = S1;
        end
        delta_S1(i,t) = max(Sj)-min(Sj);
    end
    delta_S1_mean = mean(delta_S1);
    % �μ� <<����ʱ�����з�����Ӧ��>> P69 ʽ(3.31)
    S1_mean(t) = temp1/(length(m_vector)*length(r_vector));
    S2_mean(t) = temp2/(length(m_vector)*length(r_vector));
end

delta_S1_S2 = abs(S1_mean-S2_mean);

