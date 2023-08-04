function r = Amutual_lzb(x,maxLags,partitions)
% �ҵĻ���Ϣ����
% Input arguments:
%     x - vector holding time series data
%      maxLags - maximal time lag
%      partitions - number of partitions for the one-dimensional histogram
% Output arguments:
%      r - vector of length maxLags, holding auto mutual information

len = length(x);
min_x = min(x);
max_x = max(x);

width = (max_x-min_x)/partitions;          % ������
point_end = min_x + [1:partitions]*width;  % ÿһ�����յ�

p1 = zeros(partitions,1);
for n = 1:len
    sn = findsn(x(n),point_end);           % �ж� x(n) ֵλ����һ������
    p1(sn) = p1(sn) + 1;
end
p1 = p1/sum(p1);                           % �����ֵ��һά�����ܶ�

r = zeros(maxLags+1,1);
for tau = 0:maxLags
    p2 = zeros(partitions);
    for n = 1:len-tau
        i = findsn(x(n),point_end);
        j = findsn(x(n+tau),point_end);
        p2(i,j) = p2(i,j) + 1;
    end
    p2 = p2/sum(sum(p2));                  % �����ֵ�Ķ�ά�����ܶ�(ʱ�Ӳ�ͬ,��ֵҲ��ͬ)
    
    tmp = 0;
    for i = 1:partitions
        for j = 1:partitions
            a = p2(i,j);
            b = p1(i)*p1(j);
            if (a>0 & b~=0)
                tmp = tmp + a*log2(a/b);    % �����ۼӺ�,��2Ϊ�׵Ķ���
            end
        end
    end
    r(tau+1) =  tmp;  
end
