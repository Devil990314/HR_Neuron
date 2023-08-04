function Lorenz
Z=zeros(1,3);
for r=linspace(0.1,350,1000)
    [~,Y]=ode45('tctll3fc',[0,1],[1;1;1;10;2;8/3;0.002;r]);
    %这里的 (T,Y)应为[T,Y],否则LaTex编译不通，以下同（T，Y）=ode45（‘tctll3fc',[0,50],Y(length(Y),:)）
Y(:,1)=Y(:,2)-Y(:,1);
for k=2:length(Y)
    f =k-1;
    if Y(k,1)<0
    if Y(k,1)>0
    y=Y(k,2)-Y(k,1)*(Y(f,2)-Y(k,2))/(Y(f,1)-Y(k,1));
    Z=[Z r+abs(y)*1i];
    end
    else
        if Y(f,1)<0
            y=Y(k,2)-Y(k,1)*(Y(f,2)-Y(k,2))/(Y(f,1)-Y(k,1));
            Z=[Z r+abs(y)*1i];
        end
    end
end
end
plot(Z,'bla.','markersize',1)
title('Bifurcation diagram')
xlabel('r'),ylabel('-y- where x=y')
