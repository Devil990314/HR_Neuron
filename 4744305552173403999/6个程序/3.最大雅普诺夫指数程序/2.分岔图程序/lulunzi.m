function dy = Lorenz(t,y);

% Lorenz


%系统微分方程：

%dx/dt = -a(x-y)

%dy/dt = x(r-z)-y

%dz/dt = xy-bz

dy=zeros(6,1);

dy(1)=-y(4)*(y(1)-y(2));

dy(2)=y(1)*(y(5)-y(3))-y(2);

dy(3)=y(1)*y(2)-y(6)*y(3);

dy(4)=0;

dy(5)=0;

dy(6)=0;