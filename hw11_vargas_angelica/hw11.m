Z=readmatrix('glass data short noclass.csv');
[rows,cols]=size(Z);
disp('Dataset size (rows, cols):')
disp([rows,cols])

% calc covariance matrix
sig=cov(Z);
% sig=corrcoef(Z);

% get eigenvalues and eigenvectors:
[V,D] = eig(sig);
eigenvals=sort(diag(D), 'descend');
norm=sum(eigenvals);
disp(['Total variance: ', num2str(norm)]);

% calc proportion of variance
pov=cumsum(eigenvals)/norm;
disp('Eigenvalues and PoV:')
disp([eigenvals, pov])

% plotting eigenvalues ranked by decreasing mag
figure(1)
plot(eigenvals)
title('Eigenvalues in Order')
xlabel('Component Number')
ylabel('Eigenvalue')

% plotting Proportion of Variance (PoV)
figure(2)
plot(pov)
title('Proportion of Variance Explained')
xlabel('Number of Components')
ylabel('Cumulative Variance')

% loop to add data into two components
for i=1:rows
    xt=Z(i,:);
    z1(i)=xt*V(:,9);
    z2(i)=xt*V(:,8);
end

% plot PC2 as function of PC1
figure(3)
plot(z1,z2,'*');
title('PC2 vs PC1')
xlabel('Principal Component 1 (PC1)')
ylabel('Principal Component 2 (PC2)')

