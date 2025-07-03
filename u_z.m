function F=u_z(in)
%==================================================================
%  GLOBAL VARIABLES
%==================================================================
global    G_s  m_s

global    B_e1 

global    k_o1  k_o2   k_a1 k_a2 


%%%%%%%%%%%%%%%%%%%%%%%
%   INPUTS    % 
%%%%%%%%%%%%%%%%%%%%%%%
x11=in(1);
x12=in(2);


lambda1=in(3);
lambda2=in(4);



vartheta_t=in(5);
vartheta_td=in(6);

x12d=in(7);
x12d_d=in(8);

d2_h=in(9);
x1 = in(10);
x3 = in(11);
B = in(12);
V = in(13);


hh1 = 0.5;
mu = 0.5;
C = (B*mu + 0.5*(hh1 + 4*mu^2))*V;



S=x12-x12d+k_o2^(-1)*lambda2;

Sm = 0.01;
hh1 = 0.5;
rr = 0.5;
vv = 0.01;
if S > Sm
    B_dot = hh1*sqrt(rr/2)*tanh(S-vv);
else
    B_dot = 0;
end

v_dot = tanh(S);

k3=10;


   u =m_s*(x12d_d + G_s + k_a2*k_o2^(-1)*lambda2-d2_h -k3*S -B*abs(S)^0.5 * tanh(S) -C)/(cos(x1)*cos(x3));




F  =  [u, S, B_dot, v_dot]';
%  F        =  [0,0,0,0]';