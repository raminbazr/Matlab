% question 1 _ b
close all;
clear all;
clc
%
X = [0.5 1];                    %input
D = X;                          %output
eta = 0.6 ;
f = @(x) logsig(x);
iterations = 100;
P = size(X,2);
w = 1.677;                    %from example 1-a
for k = 1:iterations
    for p=1:P
        x = X(:,P);
        d = x;
        y = f(x*w);
        delta = (d-y)*y*(1-y);
        deltaW = eta*delta*x';
        w = w + deltaW;
        %we have here recurrent, this means the next input will be last output
        X(:,p) = y;
        subplot(2,1,1)
        plot(k,X(1),'.r','linewidth',2.5)
        ylabel 'y(1)'
        title 'X1 = 0.5'
        drawnow
        hold on
        subplot(2,1,2)
        plot(k,X(2),'.b','linewidth',2.5)
        ylabel 'y(2)'
        title 'X2 = 1'
        drawnow
        hold on
    end
end
%%

disp(['X(1) = ', num2str(X(1))]);
disp(['X(2) = ', num2str(X(2))]);


