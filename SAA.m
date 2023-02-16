Ew=50;
STDw= 20;
%%LHS
Numberofvariables=5;
LHSNoscenario= 10;
P=zeros (LHSNoscenario,Numberofvariables);
for i=1:Numberofvariables
    P(:,i)=randperm(LHSNoscenario);
end
Y=norminv(P/(LHSNoscenario+1),0,1);

Matrix=cov(Y);
L1=chol(Matrix,'lower');

Ystar=Y*inv(L1)';

Pstar=zeros(size(Ystar));
for i=1:Numberofvariables
    [value,order]=sort(Ystar(:,i));
    Pstar(:,i)=order;
end

R=rand(size(Pstar));
S= (1/LHSNoscenario)*(Pstar-R);
W= zeros(Numberofvariables,LHSNoscenario);
for i=1:Numberofvariables
    W(i,:)=norminv(S(:,i)',Ew(i),STDw(i));
end




