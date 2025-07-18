function [out]=plant_x(in)


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
x7 = in(1);
x8 = in(2);


d1 = in(3);
d2 = in(4);


ux=in(5);
U1 = in(6);


f1 =  0.25*cos(x8*x7) + d1;
f2 = 0.5*(x8 + x7) + d2;
x7_d= x8 + f1;
x8_d=ux*U1/m_s + f2;


%=====================================
% output
%======================================
out = [x7_d; x8_d; f1];




