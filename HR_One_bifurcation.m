clear all
clc
close all

global a;  global b;  global c;
global d;  global s;  global r;
global x0; global Iext;

a=1.0; b=3.0; c=1.0; d=5.0;
s=4.0; r=0.002; x0=-1.60;
Iext=2.2;

N=10;
dt=1/N;
td=1000;
t=0:dt:td; 
tlen=length(t);
ymax=[];
ym=[];
ymm=[];
j=1;
ii=1;
for Iext=(3.2:0.01:3.5)
        [t,y]=ode45('HR_neuron',t,[1 1 1]);
        for i=2000:tlen-1%保证所选取的区间为达到稳态时的区间
            % ny=lengyh(y);%y的总长度
            if(y(i-1,1)<y(i,1))&&(y(i+1,1)<y(i,1))&&y(i,1)>0%判断是否为极值点
                ymax(j,1)=Iext;%保存极值点处的激励值
                ymax(j,2)=y(i,1);%保留极值点处x的值
                ymax(j,3)=i;%保留极值点处的点的位置
                ym(ii,1)=Iext;
                    if (j==1)
                        ym(ii,2)=0;
                    end
                     if((j~=1)&&(ym(ii,1)==ym(ii-1)))
                         ym(ii,2)=ymax(j,3)-ymax(j-1,3);
                     end
                j=j+1;
                ii=ii+1;
            end

        end
    disp(Iext);

end;
% ym_len=length(ym(:,1))
% for i=1:ym_len-1
%     if(ym(i,1)==ym(i+1,1))
%         ymm(j,1)=ym(i,1)
%         ymm(j,2)
%     end;
% end;
% plot(ym(:,1),ym(:,2));

% figure(1)
% plot(ymax(:,1),ym(1:end-1,1));
% for Iext=(1.5:0.1:1.8)
%     for ii=1:10
%       [t,y]=ode45('HR_neuron',t,[0 0 0]);

%      for i=100000:tlen-1%保证所选取的区间为达到稳态时的区间
%         if(y(i-1,1)<y(i,1))&&(y(i+1,1)<y(i,1))%判断是否为极值点
%             m=j*ii;
%      
%             ymax(m,1)=Iext;
%             ymax(m,2)=y(i,1);
% 
%             j=j+1;
%         end
%       end
%     end
%     disp (Iext);
% end
% figure(1)
% plot(ymax(:,1),ymax(:,2));


