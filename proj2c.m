%question 2 _c
clc, clear, close all
load W
load V
X=rand(200,3);
alpha=0.7;
eta=0.9;
Z =zeros(3,2);
iterations=100;
for k=1:iterations
X(:,3)=1;
for p=1:100
Y=logsig(X(p,:)*V);
y=[Y,1];
z=logsig(y*W);
Z(p,:,k)=z;
end
X = Z(:,:,k);
end
for n=1:100
for k=1:iterations
plot(Z(n,1,k),Z(n,2,k),'.b')
hold on
end

end
X1=rand(200,3);
X2=rand(200,3);
for i=1:2
X2=(-1/V(2,i)).*(X1.*V(1,i)+V(3,i));
plot(X1,X2,'linewidth',2.5)
axis([0 1 0 1]);
hold on
plot(0.25,0.25,'.k',0.5,0.5,'.k',0.75,0.25,'.k',0.75,0.75,'.k','markersize',25)
end