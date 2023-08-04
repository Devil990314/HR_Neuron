[t,u]=ode45('tctll3',(0:2*pi/20:100),[0.1 0.2 0],[]);
figure(1)
Y=fft(u(:,1));
Y(1)=[];
n=length(Y);
power=abs(Y(1:n/2)).^2/(length(Y).^2);
freq=100*(1:n/2)/length(Y);
plot(freq,power,'k')
xlabel('f'),ylabel('power') 

