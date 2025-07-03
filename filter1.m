function out=filter1(in)
qc=in(1);
lambda1=in(2);
lambda2=in(3);
v=qc;


ro1=0.3;
xi1=1;
zeta1=0.1;

ro2=0.3;
xi2=1;
zeta2=0.1;

lambda1_dot=-(lambda1-v)/ro1-xi1*(lambda1-v)/(abs(lambda1-v)+zeta1);
lambda2_dot=-(lambda2-lambda1_dot)/ro2-xi2*(lambda2-lambda1_dot)/(abs(lambda2-lambda1_dot)+zeta2);
out=[lambda1_dot,lambda2_dot];

