% linfit.m
function [b0,b1,rsq,StdErrEst,StdRes] = linfit(x,y)
    n=length(x);
    m=1;
    V=ones(n,2); %initalize V matrix
    V(:,2)=x;
    A=V'*V;
    b=V'*y;
    w=A\b; %solve Normal Equations
    b0=w(1);
    b1=w(2);
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
    %standard residuals
    xbar=sum(x)/n;
    varx=x-xbar;
    sstx=varx'*varx;
    for i=1:n
        h=(x(i)-xbar)^2/sstx+1/n;
        StdErrRes=StdErrEst*sqrt(1-h);
        StdRes(i)=r(i)/StdErrRes;
    end
end