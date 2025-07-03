function F=DO_y2(in)
%==================================================================
%  GLOBAL VARIABLES
%==================================================================

global    B_e1  

global     m_s k_o1  k_o2  k_a1 k_a2 


%%%%%%%%%%%%%%%%%%%%%%%
%   INPUTS    % 
%%%%%%%%%%%%%%%%%%%%%%%
x9=in(1);
x10=in(2);


lambda1=in(3);
lambda2=in(4);


delta2=in(5);


U1 = in (6);
Uy = in(7);

d2_h=delta2+k_o2*x10+lambda2;
delta2_d=-k_o2*(Uy*U1/m_s)-k_o2*d2_h+k_a2*lambda2;

F  =  [d2_h,delta2_d]';
%  F        =  [0,0,0,0]';