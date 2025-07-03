function [sys,x0,str,ts] = control_qpr(t,x,u,flag)
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
sizes.NumContStates = 36;
sizes.NumDiscStates = 0;
sizes.NumOutputs = 3;
sizes.NumInputs = 15;
sizes.DirFeedthrough = -1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0 = 0.2*ones(1,36);
str = [];
ts = [-1 0];

function sys=mdlDerivatives(t,x,u) 
 % constants and System dynamics coefficients
num_centers = 10;
spread = 4;
centers = [-1   -0.8  -0.4  -0.2   0.8    1     1.2    1.6    2     2.4];
k = [6, 4, 3, 7, 5, 5];
gamma = 10;
Sm = 0.001;
hh = 5*ones(1,3);
r = 5*ones(1,3);
v = 0.05*ones(1,3);
 
% state vector X = [x1 x2 x3 x4 x5 x6]'
x1 = u(1); % Angular position phi
x2 = u(2); % Angular velocity phi_dot
x3 = u(3); % Angular position theta
x4 = u(4); % Angular velocity thta_dot
x5 = u(5); % Angular position psi
x6 = u(6); % Angular velocity psi_dot

% the desired signals of state vector X = [x1 x2 x3 x4 x5 x6]',
% and it's first and second derivative
x1d = u(7);
x1d_d = u(8);
x1d_dd = u(9);
x3d = u(10);
x3d_d = u(11);
x3d_dd = u(12);
x5d = u(13);
x5d_d = u(14);
x5d_dd = u(15);


%error value and its derivative 
e =[x1-x1d, x3-x3d, x5-x5d];
de =[x2 - x1d_d, x4 - x3d_d, x6 - x5d_d];

% sliding surface
z1 = x2 - x1d_d + k(1) * e(1);
z2 = x4 - x3d_d + k(2) * e(2);
z3 = x6 - x5d_d + k(3) * e(3);
S =[z1 z2 z3];


% RBF's gaussian activation function 
J3=[e;de]';
    h1 = zeros(num_centers,1);
    h2 = zeros(num_centers,1);
    h3 = zeros(num_centers,1);

for j=1:1:num_centers 
 h1(j)=exp(-norm(J3(1,:)-centers(:,j))^2/(spread*spread)); 
 h2(j)=exp(-norm(J3(2,:)-centers(:,j))^2/(spread*spread)); 
 h3(j)=exp(-norm(J3(3,:)-centers(:,j))^2/(spread*spread)); 

end 

% Adaptive gain design for the super-twisting sliding mode control
    for i = 1:3
    if S(i) >= Sm
        sys(30+i) = hh(i)*sqrt(r(i)/2)*tanh(S(i)-v(i));
    else
        sys(30+i) = 0;
    end
    end

     for i = 1: 3
          sys(33+i) = tanh(S(i)/4);
     end
% Adaptive Law for RBF NN
    sys(1:10) =  gamma*S(1)*h1;
    sys(11:20) =  gamma*S(2)*h2;
    sys(21:30) =  gamma*S(3)*h3;
 


function sys=mdlOutputs(t,x,u)
 % System parameters
  %  spread center weight;
    
  num_centers = 10;
  spread = 4;
  centers = [-1   -0.8  -0.4  -0.2   0.8    1     1.2    1.6    2     2.4];
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
    k = [6, 4, 3, 7, 5, 5];

x1 = u(1);
x2 = u(2);
x3 = u(3);
x4 = u(4);
x5 = u(5);
x6 = u(6);

x1d = u(7);
x1d_d = u(8);
x1d_dd = u(9);
x3d = u(10);
x3d_d = u(11);
x3d_dd = u(12);
x5d = u(13);
x5d_d = u(14);
x5d_dd = u(15);



e =[x1-x1d, x3-x3d, x5-x5d];
de =[x2 - x1d_d, x4 - x3d_d, x6 - x5d_d];

z1 = x2 - x1d_d + k(1) * e(1);
z2 = x4 - x3d_d + k(2) * e(2);
z3 = x6 - x5d_d + k(3) * e(3);
S =[z1 z2 z3];

J3=[e;de]';
    h1 = zeros(num_centers,1);
    h2 = zeros(num_centers,1);
    h3 = zeros(num_centers,1);

for j=1:1:num_centers 
 h1(j)=exp(-norm(J3(1,:)-centers(:,j))^2/(spread*spread)); 
 h2(j)=exp(-norm(J3(2,:)-centers(:,j))^2/(spread*spread)); 
 h3(j)=exp(-norm(J3(3,:)-centers(:,j))^2/(spread*spread)); 

end 
W_f1 = [x(1:10)]';
W_f2 = [x(11:20)]';
W_f3 = [x(21:30)]';

f=[W_f1*h1;
    W_f2*h2;
    W_f3*h3; 
   ];
B = [x(31) x(32) x(33)];
hh = 5*ones(1,3);
mu =5*ones(1,3);

    C = zeros(1,3);
    for i = 1:3
        C(i) = mu(i)*B(i) + 0.5*(hh(i) + 4*mu(i)^2);
    end

% system output

 sys(1) = 1 / b1 * (-f(1)- a1 * x4 * x6 - a2 * ob * x4 -k(1)*de(1) - e(1) + x1d_dd  -k(2)*S(1)-B(1)*abs(S(1))^0.5 * tanh(S(1)) -C(1)*x(34));
 sys(2) = 1 / b2 * (-f(2)- a3 * x2 * x6 - a4 * ob * x2 -k(3)*de(2) - e(2) + x3d_dd  -k(4)*S(2)-B(2)*abs(S(1))^0.5 * tanh(S(1)) -C(2)*x(35));
 sys(3) = 1 / b3 * (-f(3)- a5 * x2 * x4 - k(5)*de(3) - e(3) + x5d_dd -k(6)*S(3)-B(3)*abs(S(3))^0.5 * tanh(S(3)) -C(3)*x(36));


dbstop if error


