function [wnew,bnew,e] = update_PLA(wold,bold,p,t)
%wold=weight vector from last update of initial condistions
%bold=bias from last update of initial condistions
%p=coordinate of point in pattern presented to network
%t=label on p
wTp=dot(wold,p);
a=1;
test=wTp+bold;
if test<0
    a=0;
end
e=t-a;
if e==0
    wnew=wold;
    bnew=bold;
    return
end
wnew=wold+e*p;
bnew=bold+e;
end