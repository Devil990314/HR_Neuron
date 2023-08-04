function [dn_pred] = original_test(xn_test,p,Wn);
% ���Բ���
% [Hn] = original_train(s_train, tau, m, p, Times)
% ���������    xn_test    ��������
%               p          Volterra ��������
%               Wn         ��С���˹����˲���Ȩʸ�� Wn
% ���������    dn_pred    һ��Ԥ��ֵ

%--------------------------------------------------
% ����ռ乹�� Volterra ����Ӧ FIR �˲����������ź�ʸ�� Un

[Un,len_filter] = PhaSpa2VoltCoef(xn_test,p);
% ���������    xn           ��ռ��еĵ�����(ÿһ��Ϊһ����)
%               p            Volterra ��������
% ���������    Un           Volterra ����Ӧ FIR �˲����������ź�ʸ�� Un
%               len_filter   FIR �˲�������

dn_pred = Wn' * Un;