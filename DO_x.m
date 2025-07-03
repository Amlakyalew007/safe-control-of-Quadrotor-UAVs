function F=DO_x(in)
%==================================================================
%  GLOBAL VARIABLES
%==================================================================

global    B_e1   

global     k_o1  k_o2  k_a1 k_a2 

%%%%%%%%%%%%%%%%%%%%%%%
%   INPUTS    % 
%%%%%%%%%%%%%%%%%%%%%%%
x7=in(1);
x8=in(2);

lambda1=in(3);
lambda2=in(4);

delta1=in(5);




d1_h=delta1+k_o1*x7+lambda1;
delta1_d=-k_o1*x8-k_o1*d1_h+k_a1*lambda1-lambda2;



F=[d1_h;delta1_d];
