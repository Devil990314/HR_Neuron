function [log2_C,log2_r] = BoxDimension_TS(s,partition)
% ����ʱ�����еĹ���ά��
%
% �������
% s - ʱ������
% partition - ÿһά�����ϵķָ���
%
% �������
% log2_C - �������Ķ���
% log2_r - ���ӱ߳��Ķ���

%--------------------------------------------------------------------------
lens = length(s);

if nargin < 2
    partition = min(lens-1,4096);
end

if partition > lens-1
    error(['The value of the 2ed input parameter must be no more than ',num2str(lens-1)]);
end

if partition > 2^12
    error('The value of the 2ed input parameter must be no more than 4096');
end

n = ceil((lens-1)/partition);        % ��С�ĺ��Ӻ��еĵ���
   
%--------------------------------------------------------------------------
% ��һ����һ����������

s = s-min(s)+1e-50;
s = s/max(s)*(lens-1);              % ��ֵ��һ����[1e-50/max(s)*(lens-1),lens-1]

% figure; 
% hold on;
% plot([0,lens-1],repmat(0:lens-1,2,1),'g'); axis equal tight;
% plot(repmat(0:lens-1,2,1)',[0,lens-1],'g');  

%--------------------------------------------------------------------------
% ͼ�����ֵ

c = zeros(partition);                   % ͼ�����
for j = 1:lens-1
    j;
    s0 = s(j:j+1);     
    s1 = ceil(min(s0));         % �¶˵�
    s2 = ceil(max(s0));         % �϶˵�
    for i = s1:s2
        ii = ceil(i/n);
        jj = ceil(j/n);
        c(ii,jj) = c(ii,jj)+1;                     
%         y = [i i-1 i-1 i];
%         x = [j j   j-1 j-1];
%         fill(x,y,'y');
    end    
end

% plot(0:lens-1,s,'r.-'); 
% hold off;

%--------------------------------------------------------------------------
% �߳���0��2��p�η�

[rows,cols] = size(c);
p = ceil(log2(max(rows,cols)));
lens = 2^p;
tmp1 = zeros(lens);
tmp1(1:rows,1:cols) = c;
c = tmp1;                           % �߳���0��2��p�η�

%--------------------------------------------------------------------------
% �����������

c1 = c(:);
c1 = c1(find(c1>0));                % �ҷ�0Ԫ��
L = sum(c1);                        % �����������

%--------------------------------------------------------------------------
% ����log2_C

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
        c1 = c1(find(c1>0));                    % �ҷ�0Ԫ��
    end    
end

%--------------------------------------------------------------------------
% ����log2_r
log2_r = -p:0;


