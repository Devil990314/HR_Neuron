function pval=g(p,b)
if p>b
    pval=p-b;
elseif p<-b
    pval=p+b;
else 
    pval=0;
end
end