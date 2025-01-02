% Use PLA with specified initial weights and bias
p1 = [-1,1,-1]'; % input point
t1 = 1; % input target
p2 = [1,1,-1]';
t2 = 0;
wold = [0.5,-1,-0.5]'; % initial weight
bold = 0.5; % initial bias

% first upd with p1 and t1
[wnew1,bnew1,e1] = update_PLA(wold,bold,p1,t1);
disp(['Error (1): ', num2str(e1)]);
disp(['Bias (1): ', num2str(bnew1)]);
disp('Weight Vector (1):');
disp(wnew1);

% second upd with p2 and t2
[wnew2,bnew2,e2] = update_PLA(wnew1,bnew1,p2,t2);
disp(['Error (2): ', num2str(e2)]);
disp(['Bias (2): ', num2str(bnew2)]);
disp('Weight Vector (2):');
disp(wnew2);

% equation of decision boundary: weight vector*p vector+bias
fprintf('Decision boundary equation: %.2f*x1 + %.2f*x2 + %.2f*x3 + %.2f = 0\n', ...
    wnew2(1), wnew2(2), wnew2(3), bnew2);

% calc distances from decision boundary
d1 = dot(wnew2, p1) + bnew2;
length1 = norm(wnew2);
distance1 = abs(d1)/length1;
disp('Distance point 1: ');
disp(distance1);

d2 = dot(wnew2, p2) + bnew2;
length2 = norm(wnew2);
distance2 = abs(d2)/length2;
disp('Distance point 2: ');
disp(distance2);