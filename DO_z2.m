function F=DO_z2(in)
%==================================================================
%  GLOBAL VARIABLES
%==================================================================
global    G_s  m_s

global    B_e1 

global    k_o1  k_o2  k_a1 k_a2 


%%%%%%%%%%%%%%%%%%%%%%%
%   INPUTS    % 
%%%%%%%%%%%%%%%%%%%%%%%
x11=in(1);
x12=in(2);


lambda1=in(3);
lambda2=in(4);


delta2=in(5);


x1 = in (6);
x3 = in (7);
U1 = in(8);

d2_h=delta2+k_o2*x12+lambda2;
delta2_d=-k_o2*(U1*cos(x1)*cos(x3)/m_s - G_s)-k_o2*d2_h+k_a2*lambda2;

F  =  [d2_h,delta2_d]';
%  F        =  [0,0,0,0]';