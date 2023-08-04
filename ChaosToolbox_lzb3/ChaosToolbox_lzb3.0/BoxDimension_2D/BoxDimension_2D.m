function [log2_C,log2_r] = BoxDimension_2D(c)
% ���������ͼ��ĺ�ά��
%
% �������
% c - ͼ����󣬲�0��2^p*2^p
%
% �������
% log2_C - �������Ķ���������Ϊp+1
% log2_r - ���ӱ߳��Ķ���������r = 2.^[-p:0]��max(size(c))<=2^p������Ϊp+1

%--------------------------------------------------------------------------

[rows,cols] = size(c);

if (rows>2^12 | cols>2^12)
    error('The size of figure must be less than 4096*4096');
end

if (ndims(c)~=2)
    error('The dimension of input data must be equal to 2!');
end

%--------------------------------------------------------------------------
% �߳���0��2��p�η�

p = ceil(log2(max(rows,cols)));
lens = 2^p;
tmp1 = zeros(lens);
tmp1(1:rows,1:cols) = c;
c = tmp1;                    % ��0

%--------------------------------------------------------------------------
% ����log2_C

c1 = c(:);
c1 = c1(find(c1>0));         % �ҷ�0Ԫ��

log2_C = zeros(1,p+1);
for i = 1:p+1
    log2_C(i) = -log2(length(c1));
    
    if (i~=p+1)
        tmp2 = zeros(lens/2,lens);
        for j = 1:lens/2
            tmp2(j,:) = c(2*j-1,:)+c(2*j,:);        % �����кϲ�
        end
        c = zeros(lens/2,lens/2);                   % �¾���Ϊԭ����1/4
        for j = 1:lens/2
            c(:,j) = tmp2(:,2*j-1)+tmp2(:,2*j);     % �����кϲ�
        end
    
        lens = size(c,1);   
        c1 = c(:);
        c1 = c1(find(c1>0));                        % �ҷ�0Ԫ��
    end
end

%--------------------------------------------------------------------------
% ����log2_r

log2_r = -p:0;


