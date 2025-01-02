function [b0,b1,b2,rsq,s,F,StdRes] = linfit2D(x1,x2,y)
n=length(y);
m=2;
V=ones(n,3); %initalize V matrix
V(:,2)=x1;
V(:,3)=x2;
A=V'*V;
b=V'*y;
w=A\b; %solve Normal Equations
b0=w(1);
b1=w(2);
b2=w(3);
fit=V*w;
%standard error of estimataion and coefficient of determination
r=fit-y;
sse=r'*r;
mse=sse/(n-m-1);
s=sqrt(mse);
ybar=sum(y)/n;
var=y-ybar;
sst=var'*var;
ssr=sst-sse;
rsq=ssr/sst;
msr=ssr/m;
F=msr/mse;
%standard residuals with minimum leverage
h=1/n;
StdErrRes=s*sqrt(1-h);
StdRes=r/StdErrRes;
end