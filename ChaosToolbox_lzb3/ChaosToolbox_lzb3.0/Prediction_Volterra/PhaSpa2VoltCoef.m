function [Un,len_filter] = PhaSpa2VoltCoef(xn,p)
% ���� Volterra ����Ӧ FIR �˲����������ź�ʸ�� Un
% [Un, len_filter] = PhaSpa2VoltCoef(xn, p)
% ���������
% xn           ��ռ��еĵ�����(ÿһ��Ϊһ����)
% p            Volterra ��������
% ���������
% Un           Volterra ����Ӧ FIR �˲����������ź�ʸ�� Un

[m,xn_cols] = size(xn);         % m Ϊ�ع�ά����xn_cols Ϊѵ����������
Un(1,:) = ones(1,xn_cols);      % FIR �˲����ĳ�ͷ�����ź�ʸ�� Un (��һ��ϵ��Ϊ 1)
h_cols_1 = 0;

for k = 1:p

    clear h;
    h(1,:) = zeros(1,k);        % k �� Volterra �˵��±� (��һ��Ϊ 0,0,0... )
    i = 1;
    
    % ����һ�����һ����ֵ�ﵽ m-1 ����ѭ��
    while h(i,end)<m-1
        i = i + 1;
        % �Ӻ���ǰ������һ��ÿһ��
        for j = k:-1:1
            % ����һ�е� j ����ֵ�ﵽ m-1 ʱ����һ�еĵ� 1 ���� j+1 �е���ֵ��Ϊ��һ�е� j+1 ����ֵ�� 1�����಻��
            if (h(i-1,j)==m-1)
                h(i,1:j+1) = ones(1,j+1) * (h(i-1,j+1)+1);
                h(i,j+2:end) = h(i-1,j+2:end);
                break;
            end
            
            % ����һ����ֵ��û�дﵽ m-1 ʱ����һ�е� 1 ����ֵ�� 1�����಻��
            h(i,1) = h(i-1,1)+1;
            h(i,2:end) = h(i-1,2:end);            
        end
    end
    %disp('------------------')
    h;                          % ���� k �� Volterra �˵��±�
    h_cols_1 = [h_cols_1;h(:,1)];
    
    index = m - h;
    [index_rows,index_cols] = size(index);
    
    un = zeros(index_rows,xn_cols);
    
    %for q = 1:xn_cols
    %    vector = xn(:,q);
    %    array = vector(index);    % ������������ȡ��x(n),x(n-tau),x(n-2*tau)...
    %    un(:,q) = prod(array,2);    % ����x(n),x(n-tau),x(n-2*tau)...֮��ĳ˻�      
    %end
   
    %------------------------------------------------
    % ������ԭʼ�㷨���������Ż��㷨
    
    for j = 1:index_rows
        xn_rows_index = index(j,:);
        xn_rows = xn(xn_rows_index,:);
        un(j,:) = prod(xn_rows,1);
    end
    
    Un = [Un;un];       % FIR �˲����ĳ�ͷ�����ź�ʸ�� Un
    clear un;
end
      
len_filter = size(Un,1);