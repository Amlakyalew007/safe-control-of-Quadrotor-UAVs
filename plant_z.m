function [out]=plant_z(in)


%==================================================================
%  GLOBAL VARIABLES
%==================================================================
global    G_s  m_s

global    B_e1    

global    k_o1  k_o2  k_a1 k_a2 

%========================================================
%   INPUTS 
%========================================================
%读入飞行器气动参数 %弧度
x11 = in(1);
x12 = in(2);


d1 = in(3);
d2 = in(4);


U1=in(5);
x1 = in(6);
x3 = in(7);


f1 =  0.1*sin(x12*x11) + d1;
f2 = x12 + 0.2*x11 + d2;

x11_d= x12 + f1 ;
x12_d= U1*(cos(x1)*cos(x3))/m_s - G_s + f2;


%=====================================
% output
%======================================
out = [x11_d; x12_d; f1; f2];




