function KE = KolmogorovEntropy(X,fs,t,D,bmax,p)
% �������ʱ������Kolmogorov�ص�STB�㷨 - ���е��(�����)

if nargin<6
    p = 1;                      % ���ƶ��ݷ���
end

X = X(1:t:end);                 % ��ʱ���ز���

r0 = mean(abs(X-mean(X)));      % r0����,���������
ln = length(X);                 % �ز��������г��� 
ld = length(D);                 % Ƕ��ά����

KE = zeros(1,ld);
for k = 1:ld

    d = D(k);
    n = ln-(d-1);               % �ع�����
    
    B = zeros(1,n);
    for i = 1:n-bmax
        for j = i+p:n-bmax
            
            v = 0;
            for u = 0:d-1
                if abs(X(i+u)-X(j+u))>r0
                    v = 1;
                    break;
                end
            end
            
            if v==1
                continue;
            end
            
            b = 0;
            dis = 0;
            while dis<=r0
                b = b+1;
                if i+d-1+b>n | j+d-1+b>n
                    error('����: bmax ȡֵ̫С!');
                end
                dis = abs(X(i+d-1+b)-X(j+d-1+b)); 
            end
            
            if b~=0
                B(b) = B(b)+1;
            end         
        end
    end
    I = find(B>0);
    B = B(I);
    lb = length(B);
    
%     figure(m);
%     plot(B);                            % ������Ϊb��ֵ,������Ϊbֵ����Ӧ�ĸ���
    
    bm = sum([1:lb].*B)/sum(B);           % b��ƽ��ֵ
    ke = -log(1-1/bm)*fs/t;
    KE(k) = ke;
    
end

