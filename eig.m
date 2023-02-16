clc
clear
cov_x=[2.5 0.1 0.2;0.1 0.4 0.3;0.2 0.3 0.9];
E_x=[10 6 5];
[V, landa]=eig(cov_x);
E_w=V'*E_x';
var_w= landa;
W=repmat(E_w,1,1000)+sqrt(var_w)*(randn(3,1000));
X=V*W;
A= X(1,:);  B= X(2,:);  C=X(3,:);
%D= A'*B.^2*C.^3';
for k=1:1000
   D(:,k)=A(:,k)'*B(:,k).^2*C(:,k).^3;
end

%now we use komara
Z=sort(D);
i=1:1000;
FZ=@(i)i/1001;

f=@(y,Ramin) y(1)+((y(2)-y(1)).*((1-((1-Ramin).^(1/y(3)))).^(1/ y(4))));
y0=[0.1 0.1 0.1 0.1];
y =lsqcurvefit(f,y0,FZ(i),Z)



