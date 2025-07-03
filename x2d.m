function F=x2d(in)
%==================================================================
%  GLOBAL VARIABLES
%==================================================================

global    B_e1  

global    k_o1  k_o2  k_a1 k_a2 


%%%%%%%%%%%%%%%%%%%%%%%
%   INPUTS    % 
%%%%%%%%%%%%%%%%%%%%%%%
x7=in(1);
x8=in(2);

lambda1 = in(3);
lambda2 = in(4);

vartheta_t=in(5);
vartheta_td=in(6);
x7d=in(7);
x7d_d=in(8);

d1_h=in(9);



e1=x7-x7d+k_o1^(-1)*lambda1;

k1=10;
varepsilon_1=1;


x2d=-k1*e1 -varepsilon_1*(vartheta_t^2)*e1/(B_e1^2-(vartheta_t*e1)^2)-0.5*varepsilon_1*vartheta_td^2*e1^3/(B_e1^2-(vartheta_t*e1)^2) - d1_h + x7d_d+k_a1*k_o1^(-1)*lambda1;




F  =  [x2d,e1,vartheta_t,B_e1]';
%  F        =  [0,0,0,0]';