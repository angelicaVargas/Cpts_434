function [db1,db2,dypbar,dypran] = inference2D(x1,x2,s,pptdist)
n=length(x1);
sumx1sq=x1'*x1;
sumx1=sum(x1);
sb1=s/sqrt(sumx1sq-sumx1^2/n);
db1=pptdist*sb1;
sumx2sq=x2'*x2;
sumx2=sum(x2);
sb2=s/sqrt(sumx2sq-sumx2^2/n);
db2=pptdist*sb2;
h=1/n;
dypbar=s*pptdist*sqrt(h);
dypran=s*pptdist*sqrt(1+h);
end