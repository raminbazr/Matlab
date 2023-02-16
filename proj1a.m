%we plot error of question 1
clear all
close all
clc
%%
X = [0.5 1];                   %input
D = X;                         %output
eta = 0.6 ;
f = @(x) logsig(x);
iterations = 100;
%% Delta Learning
% initialize w
w = rand();
MemW = zeros(1,iterations);
MemW(1)=w;
P = size(X,2);
for k = 1:iterations
    E=0;
    for p = 1:P
        x = X(:,p);
        d = D(:,p);
        y = f(x*w);
        delta = (d-y)*y*(1-y);
        deltaW = eta*delta*x';
        w = w + deltaW;
        E=E+0.5*(d-y)^2;
    end
       MemW(k+1)=w;
       E1(k)=sqrt(E/2);
end
    %%
    figure,plot(0:1:iterations,MemW);
    xlabel = ('Iterations k');
    ylabel = ('W');
    plot(E1);
    title('Error!')
    save w 
    w; 
    y;



    
    
    
