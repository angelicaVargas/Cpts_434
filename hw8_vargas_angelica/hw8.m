Z=csvread('glass_data_HW6.csv');
[rows,cols]=size(Z);
disp('Dataset size (rows, cols):')
disp([rows,cols])
V=ones(rows,10);
for k=1:9
    V(:,k+1)=Z(:,k);
end
y=Z(:,10); % needed values

% perform linear regression
A=V'*V;
b=V'*y;
w=A\b;
fit=V*w;

% calc residuals and sum of squared err
r=fit-y;
sse=r'*r;

% calculate r-squared value
ybar=sum(y)/rows;
var=y-ybar;
sst=var'*var;
rsq=(sst-sse)/sst;
disp('Coefficient of determination (R-squared):')
disp(rsq)

% initialize confusion matrix
cmat=zeros(3,3);

% classify based on bin specifications
for i=1:rows
    class=y(i);
    bin=2;
    if(fit(i)<1.5)bin=1;end;
    if(fit(i)>4)bin=6;end;

    % enter info into matrix
    if(bin==1&&class==1)cmat(1,1)=cmat(1,1)+1;end
    if(bin==2&&class==1)cmat(2,1)=cmat(2,1)+1;end
    if(bin==6&&class==1)cmat(3,1)=cmat(3,1)+1;end
    if(bin==1&&class==2)cmat(1,2)=cmat(1,2)+1;end
    if(bin==2&&class==2)cmat(2,2)=cmat(2,2)+1;end
    if(bin==6&&class==2)cmat(3,2)=cmat(3,2)+1;end
    if(bin==1&&class==6)cmat(1,3)=cmat(1,3)+1;end
    if(bin==2&&class==6)cmat(2,3)=cmat(2,3)+1;end
    if(bin==6&&class==6)cmat(3,3)=cmat(3,3)+1;end
end

% display confusinon matrix
disp('Confusion matrix:')
disp(cmat)

% turn into row-specific
row_specific_cmat = cmat';
disp('Row-specific matrix:')
disp(row_specific_cmat)

% totals for each class
tot1s=cmat(1,1)+cmat(2,1)+cmat(3,1);
tot2s=cmat(1,2)+cmat(2,2)+cmat(3,2);
tot6s=cmat(1,3)+cmat(2,3)+cmat(3,3);
totall=tot1s+tot2s+tot6s;

disp('Total records in class 1, 2, and 6:')
disp([tot1s,tot2s,tot6s,totall])

% calc class specific accuracies
accur1s=cmat(1,1)/tot1s;
accur2s=cmat(2,2)/tot2s;
accur6s=cmat(3,3)/tot6s;
accurall=(cmat(1,1)+cmat(2,2)+cmat(3,3))/totall;

disp('Accuracy for class 1, 2, 6, and overall accuracy:')
disp([accur1s,accur2s,accur6s,accurall])