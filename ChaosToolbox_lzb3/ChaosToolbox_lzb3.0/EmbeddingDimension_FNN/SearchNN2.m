function [index,distance] = SearchNN2(X1,query_indices,K,exclude)
% ���ع���ռ���Ѱ������ڵ��
% ����:   X1                �ع�����ռ�
%         query_indices     ����ڲο���ȱʡΪ,[1:size(xn,2)]'  
%         K                 ����ڵ�ĸ���,ȱʡΪ 1
%         exclude           ���ƶ��ݷ��룬��������ƽ������,ȱʡΪ 0
% ���:   index             ����ڵ��±�
%         distance          ����ھ���  

if nargin < 4 
    exclude = 0;        % ���ƶ��ݷ��룬��������ƽ������        
    if nargin < 3
        K = 1;                  % ����ڵ�ĸ���
        if nargin < 2
            N = size(xn,2);             % �ع��������
            query_indices = [1:N]';     % �ο���    
        end
    end
end

%--------------------------------------------------------------------------

L1 = 7;
L2 = 7;
[Tree] = KNN_Tree(X1,L1,L2);

% function [Tree] = KNN_Tree(X1,L1,L2)
% KNN�ֲ����㷨
% �������:
% X  - ������,ÿһ��һ����
% L1 - ��һ�����ڵ���
% L2 - �ڶ������ڵ���
%
% �������:
% Tree{i}.len                   % ÿһ�����
% Tree{i}.C                     % ÿһ������
% Tree{i}.Rmax                  % ���뾶
% Tree{i}.Tree{j}.X             % ������
% Tree{i}.Tree{j}.I             % ����ǩ
% Tree{i}.Tree{j}.len           % ��������ʱ��Ϊ0
% Tree{i}.Tree{j}.C             % ��������ʱ��Ϊ0
% Tree{i}.Tree{j}.Rmax          % ��������ʱ��Ϊ0 
% Tree{i}.Tree{j}.R             % ÿ��������������ľ���
%
% Tree{L1+1}.IJK                % ����������������ڵ����

%--------------------------------------------------------------------------

[index,distance] = KNN_Search(Tree,query_indices,K,exclude);

% function [index,distance] = KNN_Search(Tree,query_indices,K,exclude)
% ���ع���ռ���Ѱ������ڵ��(������)
% ����:   Tree               KNN�ֲ���
%         query_indices     ����ڲο���ȱʡΪ,[1:size(xn,2)]'  
%         K                 ����ڵ�ĸ���,ȱʡΪ 1
%         exclude           ���ƶ��ݷ��룬��������ƽ������,ȱʡΪ 0
% ���:   index             ����ڵ��±�
%         distance          ����ھ���  

%--------------------------------------------------------------------------

function [Tree] = KNN_Tree(X1,L1,L2)
% KNN�ֲ����㷨
% �������:
% X  - ������,ÿһ��һ����
% L1 - ��һ�����ڵ���
% L2 - �ڶ������ڵ���
%
% �������:
% Tree{i}.len                   % ÿһ�����
% Tree{i}.C                     % ÿһ������
% Tree{i}.Rmax                  % ���뾶
% Tree{i}.Tree{j}.X             % ������
% Tree{i}.Tree{j}.I             % �����±� 
% Tree{i}.Tree{j}.len           % ��������ʱ��Ϊ0
% Tree{i}.Tree{j}.C             % ��������ʱ��Ϊ0
% Tree{i}.Tree{j}.Rmax          % ��������ʱ��Ϊ0 
% Tree{i}.Tree{j}.R             % ÿ��������������ľ���
%
% Tree{L1+1}.IJK                % ����������������ڵ����

IJK = zeros(3,size(X1,2));
[M1,R1max,N1,T1,R1] = KMeans2(X1,L1);
IJK(1,:) = T1;                             % ����ǩ
for i = 1:L1
    I = find(T1==i);
    X2 = X1(:,I);

    Tree{i}.len = N1(i);                    % ÿһ�����
    Tree{i}.C = M1(:,i);                    % ÿһ������
    Tree{i}.Rmax = R1max(i);                % ���뾶
    
    [M2,R2max,N2,T2,R2] = KMeans2(X2,L2);
    IJK(2,I) = T2;                          % ����ǩ
    for j = 1:L2
        J = find(T2==j);        
        X3 = X2(:,J);
        
        Tree{i}.Tree{j}.X = X3;             % ÿһ������
        Tree{i}.Tree{j}.I = I(J);           % �����±�  
        Tree{i}.Tree{j}.len = N2(j);        % ÿһ�����  
        Tree{i}.Tree{j}.C = M2(:,j);        % ÿһ������
        Tree{i}.Tree{j}.Rmax = R2max(j);    % ���뾶
        Tree{i}.Tree{j}.R = R2(J);          % ÿ��������������ľ���
        
        IJK(3,I(J)) = 1:length(J);          % �������
    end
end
Tree{L1+1}.IJK = IJK;                       % ����������������ڵ����

%--------------------------------------------------------------------------

function [M1,R1max,N1,T1,R1] = KMeans2(X,c)
% ��׼ K-Means ����
% �������:
% X - ������,ÿһ��һ����
% c - ����������
%
% �������:
% M1    - ��������,ÿһ��һ����
% R1max - ÿ��������������ľ����������
% N1    - ÿһ�����
% T1    - ����ǩ,��ʸ��
% R1    - ÿ��������������ľ���

M1 = Initialize(X,c);                % ��c-1����Ľ���õ�c����Ĵ����

tmax = 20;
k = 0;
Je = zeros(1,tmax);
while k<tmax
    
    k = k+1;    
    
    [M2,T1,R1,N1,R1max,je1] = KMeans2_Center_Update(X,M1);  % ����������ʹ��ۺ�����������
    Je(k) = je1;                                            % ���ۺ�����ֵ
    
    if k>2 & abs(Je(k)-Je(k-1))/(Je(k-1)+1e-8)<0.005
        break;                                  % ����2�ε���,je����,��ǰ����
    end
    M1 = M2;
end
Je = Je(1:k);

%--------------------------------------------------------------------------

function [M] = Initialize(X,c)
% ��c-1����Ľ���õ�c����Ĵ����
% �ο�����
% ������ ����. ģʽʶ��[M]. ����:�廪��ѧ������. 1999. p236
%
% �������:
% X - ������,ÿһ��һ����
% c - ����������
%
% �������:
% M - ��������,ÿһ��һ����

n = size(X,2);              % ��������
M = zeros(size(X,1),c);     % ��c-1����Ľ���õ�c����Ĵ����
M(:,1) = mean(X,2);
Dis = zeros(1,n);
for i = 2:c
    for k = 1:n
        d0 = inf;
        for j = 1:i-1
            d1 = norm(X(:,k)-M(:,j));
            if d1<d0
                d0 = d1;
            end
        end
        Dis(k) = d0;
    end
    [tmp,m] = max(Dis);
    M(:,i) = X(:,m);
end

%--------------------------------------------------------------------------

function [M2,T1,R1,N1,R1max,je1] = KMeans2_Center_Update(X,M1)
% K-Means ����(���ĸ��º���)
% �ο�����
% Richard O.Duda ��,��궫 ��. ģʽ����[M]. ����:��е��ҵ������. 2003. p424
%
% �������:
% X   - ������,ÿһ��һ����
% M1  - ��������,ÿһ��һ����
%
% �������:
% M2    - �¾�������,ÿһ��һ����
% T1    - ����ǩ,��ʸ��
% R1    - ÿ��������������ľ���
% N1    - ÿһ�����
% R1max - ÿ��������������ľ����������
% je1   - ���ۺ���ֵ

[d,n] = size(X);                        % ��������
[d,c] = size(M1);
D = zeros(c,n);                         % �������
for i = 1:c
    tmp1 = X - repmat(M1(:,i),1,n);
    D(i,:) = sum(tmp1.^2);              % ���������ĵľ����ƽ��
end

[R1,T1] = sort(D);
T1 = T1(1,:);
R1 = sqrt(R1(1,:));
    
N1 = zeros(1,c);
M2 = zeros(d,c);
R1max = zeros(1,c);
for i = 1:c
    J = find(T1==i);

    if ~isempty(J)
        N1(i) = length(J);              % ÿһ�����        
        M2(:,i) = mean(X(:,J),2);       % ����ʸ������(��������)                  
        R1max(i) = max(R1(J));
    else
        N1(i) = 0;                      % ��������ʱ��Ϊ0
        M2(:,i) = 0;                    % ��������ʱ��Ϊ0
        R1max(i) = 0;                   % ��������ʱ��Ϊ0
    end
end
je1 = sum(R1);                        % ���ۺ���ֵ

%--------------------------------------------------------------------------

function [index,distance] = KNN_Search(Tree,query_indices,K,exclude)
% ���ع���ռ���Ѱ������ڵ��(������)
% ����:   Tree               KNN�ֲ���
%         query_indices     ����ڲο���ȱʡΪ,[1:size(xn,2)]'  
%         K                 ����ڵ�ĸ���,ȱʡΪ 1
%         exclude           ���ƶ��ݷ��룬��������ƽ������,ȱʡΪ 0
% ���:   index             ����ڵ��±�
%         distance          ����ھ���  
%
% ����TreeΪ
% Tree{i}.len                   % ÿһ�����
% Tree{i}.C                     % ÿһ������
% Tree{i}.Rmax                  % ���뾶
% Tree{i}.Tree{j}.X             % ������
% Tree{i}.Tree{j}.I             % �����±� 
% Tree{i}.Tree{j}.len           % ��������ʱ��Ϊ0
% Tree{i}.Tree{j}.C             % ��������ʱ��Ϊ0
% Tree{i}.Tree{j}.Rmax          % ��������ʱ��Ϊ0 
% Tree{i}.Tree{j}.R             % ÿ��������������ľ���
%
% Tree{L1+1}.IJK                % ����������������ڵ����

n = length(query_indices);
index = zeros(n,K);
distance = zeros(n,K);
for i = 1:n
    [in,di] = KNN_Search_1P(Tree,query_indices(i),K,exclude);
    index(i,:) = in;
    distance(i,:) = di;
end

%--------------------------------------------------------------------------
% ���ع���ռ���Ѱ������ڵ��(1�����K�����㷨 )

function [index,distance] = KNN_Search_1P(Tree,i,K,exclude)

IJK = Tree{end}.IJK;
ijk = IJK(:,i);
x = Tree{ijk(1)}.Tree{ijk(2)}.X(:,ijk(3));      % ��i��������

d = length(x);                                  % ����ά��
m = size(IJK,2);                                % ��������

if exclude>=0
    I = max(1,i-exclude):min(m,i+exclude);
    for j = 1:length(I)
        Tree = X_Inf(Tree,I(j));     % ��������X�е�m��������֦������������Tree
    end
end

%--------------------------------------------------------------------------
% K���ڳ�ѡ

L1 = length(Tree)-1;             % ��һ�����ڵ���
L2 = length(Tree{1}.Tree);       % �ڶ������ڵ���

Len = zeros(1,L1*L2);
C = zeros(d,L1*L2);
IJ = zeros(2,L1*L2);
k = 0;
for i = 1:L1
    for j = 1:L2
        k = k+1;
        IJ(1,k) = i;                        % ��һ�����ڵ����
        IJ(2,k) = j;                        % �ڶ������ڵ����
        Len(k) = Tree{i}.Tree{j}.len;       % ÿһ�����
        C(:,k) = Tree{i}.Tree{j}.C;         % ÿһ������
    end
end
C(:,find(Len==0))=inf;                      % 0�����ڵ��������

tmp1 = C-repmat(x,1,L1*L2);
D = sum(tmp1.^2);
[tmp2,I] = sort(D);                         % �۲����ڵ����ľ�������
Len = Len(I);    
IJ = IJ(:,I);

for i = 1:L1*L2
    if sum(Len(1:i))>2*K
        n = i;                              % ǰn���ڵ����������ܺʹ���2�����ڵ���
        break
    end
end
n = max(n,2);                               % ���ٰ��������ڵ�

Len = Len(1:n);                              % ȡǰn���ڵ�
IJ = IJ(:,1:n);

X1 = [];
I1 = [];
for k = 1:n
        i = IJ(1,k);
        j = IJ(2,k);
        X1 = [X1,Tree{i}.Tree{j}.X];        % �ڶ���ڵ�����
        I1 = [I1,Tree{i}.Tree{j}.I];        % �ڶ���ڵ��±�
end

tmp1 = X1-repmat(x,1,size(X1,2));           
E = sum(tmp1.^2);
[tmp2,I2] = sort(E);                        % �۲����ǰn���ڵ�����������������
E = E(I2);
I1 = I1(I2);

index = I1(1:K);                          % ǰK�������±�
distance = sqrt(E(1:K));                  % ǰK�����ھ���

%--------------------------------------------------------------------------
% K���ڼ���

for i = 1:L1
    len = Tree{i}.len;
    C = Tree{i}.C;                          % ��һ���i���ڵ������
    Rmax = Tree{i}.Rmax;                    % ��һ���i���ڵ�����뾶
    dmax = distance(end);                   % �۲�����K�����ڵľ���
    d = norm(x-C);
    if len==0 | d>dmax+Rmax                 % ��һ��ڵ������֦
        continue;
    end
    
    for j = 1:L2
        tmp1 = abs(IJ-repmat([i;j],1,size(IJ,2)));
        tmp2 = ~sum(tmp1);
        if ~isempty(find(tmp2==1))          % ���[i;j]��IJ�м�֦  
            continue;
        end   
        
        len = Tree{i}.Tree{j}.len;
        C = Tree{i}.Tree{j}.C;
        Rmax = Tree{i}.Tree{j}.Rmax;
        d = norm(x-C);
        if len==0 | d>dmax+Rmax             % �ڶ���ڵ������֦
            continue;
        end

        for k = 1:len
            R = Tree{i}.Tree{j}.R(k);
            if d>dmax+R                     % �ڶ���ڵ㵥����֦                    
                continue;                
            end
            
            x2 = Tree{i}.Tree{j}.X(:,k);         
            d2 = norm(x-x2);
            if d2>dmax                      % ������ڵ�K�����ڵľ����֦
                continue;
            end
            index(K) = Tree{i}.Tree{j}.I(k);        % ���ڵ��滻
            distance(K) = d2;
                        
            [tmp3,I3] = sort(distance);
            index = index(I3);                      % ��������
            distance = distance(I3);
            dmax = distance(K);                  % dmax���� 
        end
    end
end

%--------------------------------------------------------------------------
% ��������X�е�m��������֦������������Tree

function [Tree] = X_Inf(Tree,m)

IJK = Tree{end}.IJK;
i = IJK(1,m);
j = IJK(2,m);
k = IJK(3,m);

% ��֦����

Tree{i}.Tree{j}.X(:,k) = inf;
Tree{i}.Tree{j}.R(k) = inf;

% ����TreeΪ
% Tree{i}.len                   % ÿһ�����
% Tree{i}.C                     % ÿһ������
% Tree{i}.Rmax                  % ���뾶
% Tree{i}.Tree{j}.X             % ������
% Tree{i}.Tree{j}.I             % �����±� 
% Tree{i}.Tree{j}.len           % ��������ʱ��Ϊ0
% Tree{i}.Tree{j}.C             % ��������ʱ��Ϊ0
% Tree{i}.Tree{j}.Rmax          % ��������ʱ��Ϊ0 
% Tree{i}.Tree{j}.R             % ÿ��������������ľ���
%
% Tree{L1+1}.IJK                % ����������������ڵ����
