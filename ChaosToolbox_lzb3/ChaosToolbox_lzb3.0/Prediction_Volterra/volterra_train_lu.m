function [Wn,err_mse] = original_train_lu(xn_train,dn_train,p)
% ѵ������
% [Hn] = original_train(s_train, tau, m, p, Times)
% ���������    xn_train   ѵ������(ÿһ��Ϊһ������)
%               dn_train   ѵ��Ŀ��
%               p          Volterra ��������
% ���������    Wn         ��С���˹����˲���Ȩʸ�� Hn

%--------------------------------------------------
% ����ռ乹�� Volterra ����Ӧ FIR �˲����������ź�ʸ�� Un

[Un,len_filter] = PhaSpa2VoltCoef(xn_train,p);
% ���������    xn_train     ��ռ��еĵ�����(ÿһ��Ϊһ����)
%               p            Volterra ��������
% ���������    Un           Volterra ����Ӧ FIR �˲����������ź�ʸ�� Un
%               len_filter   FIR �˲�������

%--------------------------------------------------
% ��С���˹����˲���Ȩʸ�� Hn

Wn = Un'\dn_train'; 

err = Wn' * Un - dn_train;
err_mse = sum(err.^2)/length(err);



