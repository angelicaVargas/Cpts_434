function [b,margin] = bias_equal_margins(w,xp,x0)
%w=weight vector perpendicular to decision boundary
%xp=coordinate of point in member class cloest to DB
%x0=coordinate of point in non-member class cloest to DB
wTxp=dot(w,xp);
wTx0=dot(w,x0);
b=-(wTxp+wTx0)/2;
margin=(wTxp+b)/norm(w);
end