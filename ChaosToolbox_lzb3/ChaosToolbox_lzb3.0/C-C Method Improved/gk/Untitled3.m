for i=1:128000
    y_1 = 0;
     for j=1:16
         num1(j) = ans(16*(i-1)+j);
         y_1 = y_1+num1(j);
     end
     if y_1 > 0
         y(i) = max(num1(1:16));
     else
         y(i) = min(num1(1:16));
     end
end