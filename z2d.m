function F=z2d(in)
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


vartheta_t=in(5);
vartheta_td=in(6);
x11d=in(7);
x11d_d=in(8);

d1_h=in(9);



e1=x11-x11d+k_o1^(-1)*lambda1;

k1=10;
varepsilon_1=1;


x12d=-k1*e1 -varepsilon_1*(vartheta_t^2)*e1/(B_e1^2-(vartheta_t*e1)^2)-0.5*varepsilon_1*vartheta_td^2*e1^3/(B_e1^2-(vartheta_t*e1)^2)-d1_h+x11d_d+k_a1*k_o1^(-1)*lambda1;




F  =  [x12d, e1, vartheta_t, B_e1]';
%  F        =  [0,0,0,0]';