%question 2 _ b
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
