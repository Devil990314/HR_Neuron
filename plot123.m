%绘制同步误差随耦合强度和时滞变化的双参数图形
% 读取excel中第二个Sheet内容
[num]=xlsread('C:\Users\Asus\Desktop\Matlab_同步误差随k变化表.xlsx', 10);
clims=[0.2 1.0];
imagesc(num,clims);
%imagesc(num);
colormap jet;
colorbar;
%view(90,-90);
xlabel('时滞');
ylabel('耦合强度');
title('同步误差随时滞和耦合强度变化的双参数图')
% fullname  = ['C:\Users\Asus\Desktop\','双参数_30_0.01-0.60——new','.tif']
% print('-dtiff','-r600',fullname)%axis ([0.05 0.30 1 20]);