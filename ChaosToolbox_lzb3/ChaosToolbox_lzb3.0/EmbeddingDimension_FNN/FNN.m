function [Percent,Percent1,Percent2] = FNN(x,tau,d_max,R_tol,A_tol)

%--------------------------------------------------

R_A = std(x);       % ������ƽ���߶�
xn = PhaSpaRecon(x,tau,d_max+1);    % ÿ��Ϊһ����
N = size(xn,2);
ref = [1:N]';

Percent = zeros(d_max,1);
for d = 1:d_max
    xn_d = xn(1:d,:);
    
    if d==1
        xn_d = [xn_d;xn_d];
    end
    
    [index,R_d] = SearchNN2(xn_d,ref);               % ��dά��ռ���Ѱ������ڵ��,������
    index_pair = [ref,index];
    
    xn_d1 = xn(d+1,:);
    dis_d1 = abs(diff(xn_d1(index_pair),1,2));      % ��d+1ά�����֮�����
    
    test1 = dis_d1./R_d;                            % �о�1
    
    xn_d_1 = xn(1:d+1,:);    
    R_d_1 = (sqrt(sum((xn_d_1(:,index_pair(:,1))-xn_d_1(:,index_pair(:,2))).^2)))';     % d+1ά����ڵ��֮��ľ���
    
    test2 = R_d_1/R_A;                              % �о�2
   
    NN = find(test1>R_tol | test2>A_tol);           % �ۺ��о�1���о�2
    Percent(d) = length(NN)/length(test1)*100;      % ͳ�Ƽٽ�����(��λΪ: %)
    
    NN = find(test1>R_tol);           % �ۺ��о�1���о�2
    Percent1(d) = length(NN)/length(test1)*100;      % ͳ�Ƽٽ�����(��λΪ: %)
    
    NN = find(test2>A_tol);           % �ۺ��о�1���о�2
    Percent2(d) = length(NN)/length(test1)*100;      % ͳ�Ƽٽ�����(��λΪ: %)    
end


