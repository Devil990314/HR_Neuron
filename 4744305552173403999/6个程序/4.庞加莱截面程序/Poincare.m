Z=[];
[T,Y]=ode45('tctll3pjm',[0,5000],[0.1;0.2;0.3;2;8/3;0.002;10;34]);
for k=1:length(Y)
    if abs(Y(k,1))<1e-2
        Z=[Z Y(k,1)+1i*Y(k,3)];
    end
end
plot(Z,'bla.','markersize',3)
title('3模ctl系统的Poincare映像y0')
xlabel('x'),ylabel('z')

