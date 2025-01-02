function [b0,b1,b2,b3,rsq,StdErrEst,StdRes] = linfit3D(x1,x2,x3,y)
n=length(y);
m=3;
V=ones(n,4); %initalize V matrix
V(:,2)=x1;
V(:,3)=x2;
V(:,4)=x3;
A=V'*V;
b=V'*y;
w=A\b; %solve Normal Equations
b0=w(1);
b1=w(2);
b2=w(3);
b3=w(4);
fit=V*w;
%standard error of estimataion and coefficient of determination
r=fit-y;
sse=r'*r;
StdErrEst=sqrt(sse/(n-m-1));
ybar=sum(y)/n;
var=y-ybar;
sst=var'*var;
ssr=sst-sse;
rsq=ssr/sst;
%standard residuals with minimum leverage
h=1/n;
StdErrRes=StdErrEst*sqrt(1-h);
StdRes=r/StdErrRes;
end