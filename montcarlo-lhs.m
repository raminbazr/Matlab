var_x=[10 0 0 1.96 3.06 1.96 0.49;0 10 0 0.49 1.96 3.06 1.96;
    0 0 10 0 0.49 1.96 3.06;1.96 0.49 0 15 0 0 0; 
    3.06 1.96 0.49 0 15 0 0;1.96 3.06 1.96 0 0 15 0;
    0.49 1.96 3.06 0 0 0 15];
E_x=[0 0 0 0 0 0 0];
a=chol(var_x);
d=diag(a);
STD_w=diag(diag(a));
M=a/STD_w;
E_w=inv(M)*E_x';
W=repmat(E_w,1,10)+STD_w*(randn(7,10));
X=M*W;
%%%%%%%%%%%%epsilon%%%%%%%%%%%%%
for t=1:7;
    epsilon(t,:)=X(t,:);
end
%%%%%%%%%%%%%%%%%%Model%%%%%%%%%
%%%%%Demand
D0=300;
D(1,:)=250+0.15*D0+epsilon(1,:);
D(2,:)=250+0.15*D(1,:)+epsilon(2,:);
D(3,:)=250+0.15*D(2,:)+epsilon(3,:);
%%%%%price
P0=30;
Price(1,:)=30+0.1*P0+0.2*epsilon(4,:)+epsilon(5,:);
Price(2,:)=30+0.1*Price(1,:)+0.2*epsilon(5,:)+epsilon(6,:);
Price(3,:)=30+0.1*Price(2,:)+0.2*epsilon(6,:)+epsilon(7,:);
%%%%%%%%%%%%%%%LHS%%%%%%%%%%%%%%%%%%%%%
for i=1:7;
    P(:,i)=randperm(10);
end
R=rand(10,7);
S=(1/10).*(P-R);
X1=norminv(S);
% now we use cholosky for removing corrolation.
y =norminv((P/11),0,1);
a1=chol(cov(y),'lower');
Ystar=y*inv(a1)';
R=rand(10,7);
%now we should ranking the each element of Ystar
numberofvariables=7;
for i=1:numberofvariables;
    [value,order]=sort(Ystar(:,i));
    Pstar(:,i)=order;
end
S1=(1/10).*(Pstar-R);
for i=1:7;
    w1(i,:)=norminv(S1(:,i)',E_w(i),d(i));
end
X2=M*w1;
%%%%
a2=chol(cov(X2'),'lower');
Ystar2=Ystar*inv(a2);
%now we should ranking the each element of Ystar2
numberofvariables=7;
for i=1:numberofvariables;
    [value,order]=sort(Ystar2(:,i));
    Pstar2(:,i)=order;
end
S2=(1/10).*(Pstar2-R);
for i=1:7;
    w2(i,:)=norminv(S2(:,i)',E_w(i),d(i));
end
X3=M*w2;
%%%%
a3=chol(cov(X3'),'lower');
Ystar3=Ystar2*inv(a3);
%now we should ranking the each element of Ystar2
numberofvariables=7;
for i=1:numberofvariables;
    [value,order]=sort(Ystar3(:,i));
    Pstar3(:,i)=order;
end
S3=(1/10).*(Pstar3-R);
for i=1:7;
    w3(i,:)=norminv(S3(:,i)',E_w(i),d(i));
end
X4=M*w3;
%%%%%Demand by LHS
D0=300;
DL(1,:)=250+0.15*D0+X4(1,:);
DL(2,:)=250+0.15*DL(1,:)+X4(2,:);
DL(3,:)=250+0.15*DL(2,:)+X4(3,:);
%%%%%price by LHS
P0=30;
PriceL(1,:)=30+0.1*P0+0.2*X4(4,:)+X4(5,:);
PriceL(2,:)=30+0.1*PriceL(1,:)+0.2*X4(5,:)+X4(6,:);
PriceL(3,:)=30+0.1*PriceL(2,:)+0.2*X4(6,:)+X4(7,:);
%%%%%%%%%%%%%%
%plot(PriceL)
%plot(DL)
%plot(D)
%plot(Price)
for i=1:10
   medianX=median(X)
end
for i=1:10
    medianX4=median(X4);
end
%varx=var(X);
%varx4=var(X4);
%meanvarx=mean(varx);
%meanvarx4=mean(varx4);
%meanmX=mean(medianX);
%meanmX4=mean(medianX4);
%x=1:100
%plot(x,medianX,'r-.',x,medianX4,'-*')
