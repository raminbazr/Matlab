clear all
close all
clc
%%
X = [0.5 1];                   %input
D = X;                         %output
eta = 0.6;                     %eta should be less than one
f = @(x) logsig(x);
iterations = 1000;
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
end
    %%
    figure,plot(0:1:iterations,MemW);
    xlabel = ('Iterations k');
    ylabel = ('W');
   
   
    
   



    
    
    
