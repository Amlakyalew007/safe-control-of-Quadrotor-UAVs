function [sys,x0,str,ts] = plant_pqr(t,x,u,flag)
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
sizes = simsizes;
sizes.NumContStates = 6;
sizes.NumDiscStates = 0;
sizes.NumOutputs = 6;
sizes.NumInputs = 3;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0 = zeros(1,6);
str = [];
ts = [];

function sys=mdlDerivatives(t,x,u)
    % constants and System dynamics coefficients
    m = 0.5;
    d = 25e-2;
    ob = 1;
    g = 9.8;

    Ix = 3.8278e-3; Iy = 3.8288e-3; Iz = 7.6566e-3; 
    % Kfax = 5.567e-4; Kfay = 5.567e-4; Kfaz = 6.354e-4;
    % Kftx = 5.567e-4; Kfty = 5.567e-4; Kftz = 6.354e-4; 
    Jr = 2.8385e-5;

    % System dynamics coefficients
    a1 = (Iy - Iz) / Ix;
    a2 = -Jr / Ix;
    a3 = (Iz - Ix) / Iy;
    a4 = Jr / Iy;
    a5 = (Ix - Iy) / Iz;
    b1 = d / Ix;
    b2 = d / Iy;
    b3 = 1 / Iz;

    U2 = u(1);
    U3 = u(2);
    U4 = u(3);

   
    dx1 = x(2);
    dx2 = a1 * x(4) * x(6) + a2 * ob * x(4) + b1 * U2 +5*sin(t) ;
    dx3 = x(4) ;
    dx4 = a3 * x(2) * x(6) + a4 * ob * x(2) + b2 * U3 + 5*sin(t) ;
    dx5 = x(6) ;
    dx6 = a5 * x(2) * x(4) + b3 * U4 +5*sin(t);
    sys = [dx1 dx2 dx3 dx4 dx5 dx6]; 
function sys=mdlOutputs(t,x,u)

  sys = [x(1) x(2) x(3) x(4) x(5) x(6)]; 
dbstop if error


