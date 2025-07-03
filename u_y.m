function F=u_y(in)
%==================================================================
%  GLOBAL VARIABLES
%==================================================================

global    B_e1 

global     k_o1  k_o2  k_a1 k_a2 


%%%%%%%%%%%%%%%%%%%%%%%
%   INPUTS    % 
%%%%%%%%%%%%%%%%%%%%%%%
x9=in(1);
x10=in(2);


lambda1=in(3);
lambda2=in(4);



vartheta_t=in(5);
vartheta_td=in(6);

x10d=in(7);
x10d_d=in(8);

d2_h=in(9);
% d3_h=0;
B = in(11);
V = in(12);
U1 = in(10);

hh1 = 0.5;
mu = 0.5;
C = (B*mu + 0.5*(hh1 + 4*mu^2))*V;
m = 0.5;


S=x10-x10d+k_o2^(-1)*lambda2;

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

if U1==0
    u = 0;
else
   u=m/U1 * (x10d_d + k_a2*k_o2^(-1)*lambda2-d2_h -k3*S - B*abs(S)^0.5 * tanh(S) -C);
  
end



F  =  [u, S, B_dot, v_dot]';
