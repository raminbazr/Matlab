%%% SECTION TITLE  *question 2_b* 

%train_nn;
vf = rands(19,64)/100;
wf = rands(65,5)/100;
% 
% %====================Reverse Training procedure============================
% emax = 0.52;
% etta = 0.4;
% alpha = 0;
v = rands(65,18)/100;
w = rands(19,18)/100;
t = rands(6,64)/100;
% r = 0;
% e = 1;
% const = 0.001;
% c = 0;
% itnum = 2000;
% error = zeros(1,itnum);
% data_ind = randperm(size(data,1),size(data,1));
% while (e > emax && r < itnum)
%     r = r+1;
%     e = 0;
%     c = 0;
%     dw = 0 ; dv = 0 ; dt = 0;
%    for n = 1:size(data,1)
%        x = logsig([target(data_ind(n),:) 1] * t);
%        y = logsig([x 1] * v); 
%        z = purelin([y 1] * w);
%        e = e + sum((data(data_ind(n),:) - z).^2); 
%        delta_z = 1*(data(data_ind(n),:) - z) .* const;
%        delta_y =  0.5 * (1-([y 1].^2)).*(w * delta_z')';
%        delta_x = 0.5 * (1-([x 1].^2)) .*(v * delta_y(1:end-1)')';
%        w = w + etta * [y 1]' * delta_z + alpha*dw;
%        v = v + etta * [x 1]' * delta_y(1:end-1) + alpha*dv;
%        t = t + etta * [target(data_ind(n),:) 1]' * delta_x(1:end-1) + alpha*dt;
%        dw = 0.01*etta * [y 1]' * delta_z;
%        dv = etta * [x 1]' * delta_y(1:end-1);
%        dt = etta * [target(data_ind(n),:) 1]' * delta_x(1:end-1);
%    end
%    e = sqrt(e/(size(data,1)*size(data,2)));
%    r
%    e
%    error(r) = e;
% end

input = [0 0 1 0 1 ; 0 1 0 0 1 ; 1 0 0 0 1 ; 0 0 1 1 0 ; 0 1 0 1 0 ; 1 0 0 1 0];  %output of forward network

for x = 1:size(input,1)
    in = input(x,:);
    for y = 1:100
        out = logsig([in 1] * t);
        out = logsig([out 1] * v);
        outr(x,:) = purelin([out 1] * w);
        if y == 1
            outr1(x,:) = outr(x,:);
        end
        out = logsig([outr(x,:) 1] * vf);
        outf(x,:) = logsig([out 1] * wf);
        in = outf(x,:);
    end
end

data_mean = data;
mean_vec(1,:) = mean(data_mean(1:length(p1.aa),:)); data_mean(1:length(p1.aa),:) = [];
mean_vec(2,:) = mean(data_mean(1:length(p1.a),:)); data_mean(1:length(p1.a),:) = [];
mean_vec(3,:) = mean(data_mean(1:length(p1.e),:)); data_mean(1:length(p1.e),:) = [];
mean_vec(4,:) = mean(data_mean(1:length(p2.aa),:)); data_mean(1:length(p2.aa),:) = [];
mean_vec(5,:) = mean(data_mean(1:length(p2.a),:)); data_mean(1:length(p2.a),:) = [];
mean_vec(6,:) = mean(data_mean(1:length(p2.e),:)); data_mean(1:length(p2.e),:) = [];

for x = 1:3
   figure, subplot(2,2,1:2), plot(outr(x,:))
   title('Synthesized vector of a for person #1');
   grid('on')
   hold on, plot(mean_vec(x,:),'r')
   grid('on')
   subplot(2,2,3:4), plot(outr(x+3,:))
   grid('on')
   hold on, plot(mean_vec(x+3,:),'r')
   grid('on')
   title('Synthesized vector of a for person #2');
end
%figure(4)
%plot(outr(1,:),'r')
%hold on ,plot(outr(2,:),'b')
%hold on ,plot(outr(3,:),'r')

%figure(5)
%plot(mean_vec(1,:),'r')
%hold on ,plot(mean_vec(2,:),'r')
%hold on ,plot(mean_vec(3,:),'r')
