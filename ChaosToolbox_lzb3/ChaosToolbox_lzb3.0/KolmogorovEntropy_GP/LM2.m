function [a,b] = LM(Log2_R,Log2_Cr,Linear)


%--------------------------------------------------


len_m = size(Log2_Cr,1);         % Log2_Cr ÿһ�ж�Ӧһ��Ƕ��ά

X = repmat(Log2_R(Linear),len_m,1);
Y = Log2_Cr(:,Linear);

X_m = mean(X,2);
Y_m = mean(Y,2);

%------------------------------------------------------
% ��ȷ���Ƶ�

X2 = X.*(X-repmat(X_m,1,size(X,2)));
Y2 = X.*(Y-repmat(Y_m,1,size(Y,2)));

a = sum(sum(Y2))/sum(sum(X2));
b = Y_m - a*X_m;

%------------------------------------------------------
% �����еı��
% X2 = (X-repmat(X_m,1,lN)).*(X-repmat(X_m,1,lN));
% Y2 = (X-repmat(X_m,1,lN)).*(Y-repmat(Y_m,1,lN));
% 
% a = sum(sum(Y2))/sum(sum(X2))
% b = Y_m - a*X_m


