
load vf
load wf

%%
 for i = 1:size (p1.aa,2)
      p1.aaN(:,i) = ( p1.aa(:,i) - mean (p1.aa(i , :))) / (sqrt ( var(p1.aa(:,i))));
 end
x=p1.aaN(246,:);x= [x 1];Y = x * vf ;y = logsig (Y);Z = [y 1]*wf ;z1 = logsig(Z);disp('output z1=');disp(z1);
display('[0 0 1 0 1]');
%%
 for i = 1:size (p1.a,2)
      p1.aN(:,i) = ( p1.a(:,i) - mean (p1.a(i , :))) / (sqrt ( var(p1.a(:,i))));
 end
x= p1.aN(326,:);x= [x 1];Y = x * vf ;y = logsig (Y);Z = [y 1]*wf ;z2 = logsig(Z);disp('output z2=');disp(z2);
display('[0 1 0 0 1]');
%%
 for i = 1:size (p1.e,2)
      p1.eN(:,i) = ( p1.e(:,i) - mean (p1.e(i , :))) / (sqrt ( var(p1.e(:,i))));
 end
x= p1.eN(149,:);x= [x 1];Y = x * vf ;y = logsig (Y);Z = [y 1]*wf ;z3 = logsig(Z);disp('output z3=');disp(z3);
display('[0 0 1 0 1]');
%%
 for i = 1:size (p2.aa,2)
      p2.aaN(:,i) = ( p2.aa(:,i) - mean (p2.aa(i , :))) / (sqrt ( var(p2.aa(:,i))));
 end
x= p2.aa(299,:);x= [x 1];Y = x * vf ;y = logsig (Y);Z = [y 1]*wf ;z4 = logsig(Z);disp('output z4=');disp(z4);
display('[0 0 1 1 0]');
%%
 for i = 1:size (p2.aa,2)
      p2.aN(:,i) = ( p2.a(:,i) - mean (p2.a(i , :))) / (sqrt ( var(p2.a(:,i))));
 end
x= p2.a(326,:);x= [x 1];Y = x * vf ;y = logsig (Y);Z = [y 1]*wf ;z5 = logsig(Z);disp('output z5=');disp(z5);
display('[0 1 0 1 0]');
%%
 for i = 1:size (p2.e,2)
      p2.eN(:,i) = ( p2.e(:,i) - mean (p2.e(i , :))) / (sqrt ( var(p2.e(:,i))));
 end
x= p2.e(121,:);x= [x 1];Y = x * vf ;y = logsig (Y);Z = [y 1]*wf ;z6 = logsig(Z);disp('output z6=');disp(z6);
display('[1 0 0 1 0]');

