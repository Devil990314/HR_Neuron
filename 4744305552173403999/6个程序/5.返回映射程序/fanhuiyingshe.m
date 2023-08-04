x0=[1 2 0];
tspan=0:0.01:800;
[t,y]=ode45(@tctll3,tspan,x0);
dzdt=diff(y(:,3));
count=1;
for i=1:20000-1
    if ( dzdt(i)*dzdt(i+1)<0&& dzdt(i)>0 )
        z(count)=y(i,3);
        count=count+1;
    end
end
for j=1:count-2
    plot(z(j),z(j+1),'k','Marker','.');
    hold on
end
title('The Lorenz Map','Fontsize',10)
xlabel('z_n','FontSize',20)
ylabel('z_n+1','FontSize',20)
