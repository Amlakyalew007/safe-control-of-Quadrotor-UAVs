function [sys,x0,str,ts] =control_BS(t,x,u,flag) 
switch flag, 
case 0, 
 [sys,x0,str,ts]=mdlInitializeSizes; 
case 1, 
 sys=mdlDerivatives(t,x,u);
 case 3, 
 sys=mdlOutputs(t,x,u); 
case {2,4,9} 
 sys=[]; 
otherwise 
 error(['Unhandled flag = ',num2str(flag)]); 
end 
function [sys,x0,str,ts]=mdlInitializeSizes 
global Fai 


Fai=5*eye(6); 
sizes = simsizes; 
sizes.NumContStates = 12; 
sizes.NumDiscStates = 0; 
sizes.NumOutputs = 6; 
sizes.NumInputs = 30; 
sizes.DirFeedthrough = 1; 
sizes.NumSampleTimes = 0; 
sys = simsizes(sizes); 
x0 = 0.1*ones(1,12); 
str = []; 
ts = []; 

function sys=mdlDerivatives(t,x,u) 
global Fai 
 pd = u(1);
 d_pd = u(2);
 dd_pd = u(3);
 qd = u(4);
 d_qd = u(5);
 dd_qd = u(6);
 rd = u(7);
 d_rd = u(8);
 dd_rd = u(9);
 xd = u(10);
 d_xd = u(11);
 dd_xd = u(12);
 yd = u(13);
 d_yd = u(14);
 dd_yd = u(15);
 zd = u(16);
 d_zd = u(17);
 dd_zd = u(18);

 x1 = u(19);
 d_x1 = u(20);
 x2 = u(21);
 d_x2 = u(22);
 x3 = u(23);
 d_x3 = u(24);
 x4 = u(25);
 d_x4 = u(26);
 x5 = u(27);
 d_x5 = u(28);
 x6 = u(29);
 d_x6 = u(30);


% X = [x1; x2; x3; x4; x5; x6];

e1 = x1 - pd;
e2 = x2 - qd;
e3 = x3 - rd;
e4 = x4 - xd;
e5 = x5 - yd;
e6 = x6 - zd;
de1 = d_x1 - d_pd;
de2 = d_x2 - d_qd;
de3 = d_x3 - d_rd;
de4 = d_x4 - d_xd;
de5 = d_x5 - d_yd;
de6 = d_x6 - d_zd;
 s1 = k1*e1 + de1;
 s2 = k2*e2 + de2;
 s3 = k3*e3 + de3;
 s4 = k4*e4 + de4;
 s5 = k5*e5 + de5; 
 s6 = k6*e6 + de6;

e = [e1; e2; e3; e4; e5; e6];
de = [de1; de2; de3; de4; de5; de6];


function sys=mdlOutputs(t,x,u) 
global Fai 
pd = u(1);
d_pd = u(2);
dd_pd = u(3);
qd = u(4);
d_qd = u(5);
dd_qd = u(6);
rd = u(7);
d_rd = u(8);
dd_rd = u(9);
xd = u(10);
d_xd = u(11);
dd_xd = u(12);
yd = u(13);
d_yd = u(14);
dd_yd = u(15);
zd = u(16);
d_zd = u(17);
dd_zd = u(18);

x1 = u(19);
d_x1 = u(20);
x2 = u(21);
d_x2 = u(22);
x3 = u(23);
d_x3 = u(24);
x4 = u(25);
d_x4 = u(26);
x5 = u(27);
d_x5 = u(28);
x6 = u(29);
d_x6 = u(30); 

% X = [x1; x2; x3; x4; x5; x6];

e1 = x1 - pd;
e2 = x2 - qd;
e3 = x3 - rd;
e4 = x4 - xd;
e5 = x5 - yd;
e6 = x6 - zd;
de1 = d_x1 - d_pd;
de2 = d_x2 - d_qd;
de3 = d_x3 - d_rd;
de4 = d_x4 - d_xd;
de5 = d_x5 - d_yd;
de6 = d_x6 - d_zd;

e = [e1; e2; e3; e4; e5; e6];
de = [de1; de2; de3; de4; de5; de6];


g    = 9.8;     l    =  0.3;    %wr   =  u(5);
ob   = 1;        Jr   =  5e-5;     m    =  0.5;
Ix  = 0.006; Iy  =  0.006; Iz  =  0.012;
a1 = (Iy-Iz)/Ix; a2 = Jr/Ix; a3 = (Iz-Ix)/Iy; a4 = Jr/Iy;
a5 = (Ix-Iy)/Iz; b1 = l/Ix; b2 = l/Iy; b3 = l/Iz;
k=2;

 % Control inputs 
    U2 = 1 / b1 * (- a1 * d_x2 * d_x3 - a2 * ob * d_x2 -Fai*de1 - e1 + dd_pd -B(1).*abs(S(1))^0.5 .*tanh(S(1)/k) -k*S(1) - C(1).*V(1));
    U3 = 1 / b2 * (- a3 * d_x1 * d_x3 - a4 * ob * d_x1 -Fai*de2 - e2 + dd_qd -B(2).*abs(S(2))^0.5 .*tanh(S(2)/k) -k*S(2) - C(2).*V(2));
    U4 = 1 / b3 * (- a5 * d_x1 * d_x2 - Fai*de3 - e3 + dd_rd -B(3).*abs(S(3))^0.5 .*tanh(S(3)/k) -k*S(3) - C(3).*V(3));

    U1 = m / (cos(x1) * cos(x2)) * (-Fai*de6 -e6 + dd_zd + g -B(6).*abs(S(6))^0.5 .*tanh(S(6)/k) -k*S(6) - C(6).*V(6)); % x1 = phi, x3 = theta
    if U1 == 0
        Ux = 0; Uy = 0;
    else
        Ux = m / U1 * (dd_xd -B(4).*abs(S(4))^0.5 .*tanh(S(4)/k) -k*S(4) - C(4).*V(4));
        Uy = m / U1 * (dd_yd -B(5).*abs(S(5))^0.5 .*tanh(S(5)/k) -k*S(5) - C(5).*V(5));
    end


sys(1) = U2;
sys(2) = U3;
sys(3) = U4;
sys(4) = U1;
sys(5) = Ux;
sys(6) = Uy;



