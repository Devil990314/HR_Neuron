% clear;clc;
% global r
% r=34.5;
% h=0.01;t=0;
% ntp=500;x=rand;
% y=rand;
% z=rand;
% rr=[x,y,z]';
% for pp=1:4000+ntp
%     k1=h*tctll3equ(t,rr);
%     k2=h*tctll3equ(t+h/2,rr+k1/2);
%     k3=h*tctll3equ(t+h/2,rr+k1/4+k2/4);
%     k4=h*tctll3equ(t+h,rr-k2+2*k3);
%     rr=rr+(k1+4*k3+k4)/6;t=t+h;
%    
%     if pp>ntp
%  RR(:,pp-ntp)=rr;
%     end
%     if rem(pp,1000)==0
%         sign1=pp
%     end
% end
% plot3(RR(1,:),RR(2,:),RR(3,:),'k');
% hold on;
% grid on;
% xlabel('x');ylabel('y');zlabel('z');
% title('Lorenz attractors');


clear;clc;
global r
r=34.5;
h=0.01;t=0;
ntp=50;x=rand;
y=rand;

rr=[x,y]';
for pp=1:4000+ntp
    k1=h*tctll3equ(t,rr);
    k2=h*tctll3equ(t+h/2,rr+k1/2);
    k3=h*tctll3equ(t+h/2,rr+k1/4+k2/4);
    k4=h*tctll3equ(t+h,rr-k2+2*k3);
    rr=rr+(k1+4*k3+k4)/6;t=t+h;
   
    if pp>ntp
 RR(:,pp-ntp)=rr;
    end
    if rem(pp,1000)==0
        sign1=pp
    end
end
plot(RR(1,:),RR(2,:),'k');
hold on;
grid on;
xlabel('x');ylabel('y');zlabel('z');
title('Lorenz attractors');