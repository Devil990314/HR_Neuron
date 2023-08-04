function Lorenz_bifur_r

Z=[];

for r=linspace(1,200,500);

[T,Y]=ode45(@Lorenz,[0,1],[1;1;1;16;r;4]);

[T,Y]=ode45(@Lorenz,[0,50],Y(length(Y),:));

Y(:,1)=Y(:,2)-Y(:,1);

for k=2:length(Y)

f=k-1;

if Y(k,1)<0

if Y(f,1)>0

y=Y(k,2)-Y(k,1)*(Y(f,2)-Y(k,2))/(Y(f,1)-Y(k,1));

Z=[Z r+abs(y)*i];

end

else

if Y(f,1)<0

y=Y(k,2)-Y(k,1)*(Y(f,2)-Y(k,2))/(Y(f,1)-Y(k,1));

Z=[Z r+abs(y)*i];

end

end

end

end

plot(Z,'.','markersize',1)

title('Lorenz映射分岔')

xlabel('r'),ylabel('|y| where x=y')


