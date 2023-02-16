%%%%question 1
clear
clc
close all
load('F:\home\NN1_Project_data\Z21.mat');
load('F:\home\NN1_Project_data\LHCB21.mat');
data = [];
target = [];
p1 = struct; p2 = struct;
p1.aa = CB(Z==1,:);
p1.a = CB(Z==2,:);
p1.e = CB(Z==3,:);
p1.tag_aa = [0 0 1 0 1]; p1.tag_a = [0 1 0 0 1]; p1.tag_e = [1 0 0 0 1];
load('F:\home\NN1_Project_data\Z210.mat');
load('F:\home\NN1_Project_data\LHCB210.mat');

p2.aa = CB(Z==1,:);
p2.a = CB(Z==2,:);
p2.e = CB(Z==3,:);
p2.tag_aa = [0 0 1 1 0]; p2.tag_a = [0 1 0 1 0]; p2.tag_e = [1 0 0 1 0];
DATA = [];
names = fieldnames(p1);
for x = 1:3
   data = [data ; p1.(names{x})]; 
   for m = 1:length(p1.(names{x}))
      target = [target ; p1.(names{x+3})]; 
   end
end

for x = 1:3
   data = [data ; p2.(names{x})]; 
   for m = 1:length(p2.(names{x}))
      target = [target ; p2.(names{x+3})]; 
   end
end
%data = 1467*18
%target = 1467*5
data_mean = mean(data);
data_var = var(data);

for x = 1:size(data,2)
   data(:,x) = (data(:,x) - data_mean(x))/sqrt(data_var(x));
end

%====================Training procedure============================
emax = 0.01;
etta = 0.2;
vf = rands(19,64)/100;
wf = rands(65,5)/100;
k = 0;
e = 1;
t = 0;
itnum = 2000;
error = zeros(1,itnum);
data_ind = randperm(size(data,1),size(data,1));   %1*1467
while (e > emax && k < itnum)
    k = k+1;
    e = 0;
    t = 0;
   for x = 1:size(data,1)   %1467
       y = logsig([data(data_ind(x),:) 1] * vf); 
       z = logsig([y 1] * wf);
       e = e + sum((target(data_ind(x),:) - z).^2); 
       delta_z = (target(data_ind(x),:) - z)*z' .*(1 - (z));
       delta_y =(1 - y )*y'.*(wf * delta_z')';
       wf = wf + etta * [y 1]' * delta_z;
       vf = vf + etta * [data(data_ind(x),:) 1]' * delta_y(1:end-1);
   end
   e = sqrt(e/(size(data,1)*size(data,2)));  %1467 * 18
   error(k) = e;
end
error(error == 0) = [];
plot(error)
xlabel('epoch');
ylabel('Error(RMSE)');
title('Learning procedure')
save vf
save wf
save('DATA','vf')
save('DATA','wf')


