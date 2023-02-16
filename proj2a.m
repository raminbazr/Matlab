%question 2 a
clear all
close all
clc
%%
E=0;
X=[0.25 0.25 1;0.5 0.5 1;0.75 0.25 1;0.75 0.75 1];     %input
d=[0.25 0.25;0.5 0.5;0.75 0.25;0.75 0.75];             %output( is same to input)
V=rands(3,2);
W=rands(3,2);
deltaW=zeros(3,2);
deltaV=zeros(3,2);
Z =zeros(3,2);
deltaY = zeros(3,2);
alpha=0.7;
eta=0.5;
iterations=1000;
for k=1:iterations
E=0;
for p=1:4
Y=logsig(X(p,:)*V);
y=[Y,1];
z=logsig(y*W);
E=E+sum((d(p,:)-z).^2);
deltaZ=(d(p,:)-z).*z.*(1-z);
for i=1:3
deltaY(i)=y(i)*(1-y(i))*sum(deltaZ.*W(i,:));
end
deltaW = eta*y'*deltaZ+alpha*deltaW;
W=W+deltaW;
% hidden layer
for n=1:3
for m=1:2
deltaV(n,m)=eta.*X(p,n).*deltaY(m)+alpha.*deltaV(n,m);
V(n,m)=V(n,m)+deltaV(n,m);
end
end
Z(p,:,k)=z;
end
E1(k)=sqrt(E/2);
end
%%plot
for j=1:iterations
plot(Z(1,1,j),Z(1,2,j),'*b')
hold on
plot(Z(2,1,j),Z(2,2,j),'*r')
hold on
plot(Z(3,1,j),Z(3,2,j),'*m')
hold on
plot(Z(4,1,j),Z(4,2,j),'*k')
hold on
end
figure
plot(E1)
title 'Error'
save W
save V