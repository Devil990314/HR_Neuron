function dx=tctll3(~,x)
dx=[-10*x(1)+10*x(2)+0.002*x(1)*x(3)/34;
    -x(1)*x(3)+2*34*x(1)-x(2);
    x(1)*x(2)-(8/3)*x(3)];