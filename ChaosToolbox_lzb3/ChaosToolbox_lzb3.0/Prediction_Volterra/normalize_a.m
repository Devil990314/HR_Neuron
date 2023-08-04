 function [sig_output,mean_sig,w] = normalize_a(sig_input,a)
% �źŹ�һ������ֵΪ 0,���Ϊ a
% [sig_output] = normalize_sig(sig_input)
% ���������sig_input  �����ź�(����������)
% ���������sig_output ��׼�����ź�

[rows,cols] = size(sig_input);
if (rows ==1)
    sig_input = sig_input';
    len = cols;
    num = 1;
else
    len = rows;
    num = cols;
end

mean_sig = mean(sig_input);
sig_input = sig_input - repmat(mean_sig,len,1);  % 0 ��ֵ

dis = max(sig_input) - min(sig_input);
w = a/dis;                                       % ʵ�ʼ�Ȩֵ
sig_output = sig_input .* repmat(w,len,1);        % ���Ϊ 1




