%%%%question 2-a
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

names = fieldnames(p1);
for n = 1:3
   data = [data ; p1.(names{n})]; 
   for m = 1:length(p1.(names{n}))
      target = [target ; p1.(names{n+3})]; 
   end
end

for n = 1:3
   data = [data ; p2.(names{n})]; 
   for m = 1:length(p2.(names{n}))
      target = [target ; p2.(names{n+3})]; 
   end
end


data_mean = mean(data);
data_var = var(data);
for n = 1:size(data,2)
   data(:,n) = (data(:,n) - data_mean(n))/sqrt(data_var(n));
end

%====================Training procedure============================
emax = 0.52;
etta = 0.4;
alpha = 0;
v = rands(65,18)/100;
w = rands(19,18)/100;
t = rands(6,64)/100;
r = 0;
e = 1;
const = 0.001;
c = 0;
itnum = 2000;
error = zeros(1,itnum);
data_ind = randperm(size(data,1),size(data,1));
while (e > emax && r < itnum)
    r = r+1;
    e = 0;
    c = 0;
    dw = 0 ; dv = 0 ; dt = 0;
   for n = 1:size(data,1)
       x = logsig([target(data_ind(n),:) 1] * t);
       y = logsig([x 1] * v); 
       z = purelin([y 1] * w);
       e = e + sum((data(data_ind(n),:) - z).^2); 
       delta_z = 1*(data(data_ind(n),:) - z) .* const;
       delta_y =  0.5 * (1-([y 1].^2)).*(w * delta_z')';
       delta_x = 0.5 * (1-([x 1].^2)) .*(v * delta_y(1:end-1)')';
       w = w + etta * [y 1]' * delta_z + alpha*dw;
       v = v + etta * [x 1]' * delta_y(1:end-1) + alpha*dv;
       t = t + etta * [target(data_ind(n),:) 1]' * delta_x(1:end-1) + alpha*dt;
       dw = 0.01*etta * [y 1]' * delta_z;
       dv = etta * [x 1]' * delta_y(1:end-1);
       dt = etta * [target(data_ind(n),:) 1]' * delta_x(1:end-1);
   end
   e = sqrt(e/(size(data,1)*size(data,2)));
   error(r) = e;
end
error(find(error) == 0) = [];
plot(error)
xlabel('Epoch')
ylabel('Error(RMSE)')
title('Learning procedure for reverse network')