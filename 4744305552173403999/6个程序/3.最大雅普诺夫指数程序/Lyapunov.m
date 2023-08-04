Z=[];
d0=1e-8;%1e-8代表1*10^(-8),
for Re=linspace(0.1,350,100)
    lsum=0;
    x=1;y=1;z=1;
    x1=1;y1=1;z1=1+d0;
    for i=1:1000
        [T1,Y1]=ode45('tctll3',[0 1],[x;y;z;2;8/3;0.002;10;Re]);
        [T2,Y2]=ode45('tctll3',[0 1],[x1;y1;z1;2;8/3;0.002;10;Re]);
        n1=length(Y1);n2=length(Y2);
        x=Y1(n1,1);y=Y1(n1,2);z=Y1(n1,3);
        x1=Y2(n2,1);y1=Y2(n2,2);z1=Y2(n2,3);
        d1=sqrt((x-x1)^2+(y-y1)^2+(z-z1)^2);
        x1=x+(d0/d1)*(x1-x);
        y1=y+(d0/d1)*(y1-y);
        z1=z+(d0/d1)*(z1-z);
        if i>500
            lsum=lsum+log(d1/d0);
        end
    end
   Z=[Z lsum/(i-500)];
end
Re=linspace(0.1,350,100);
plot(Re,Z,'bla-.');
title('最大lyapunov指数')
xlabel('parameter Re'),ylabel('lyapunov exponents')
        