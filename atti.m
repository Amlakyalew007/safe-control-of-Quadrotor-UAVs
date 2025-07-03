function dx = atti(x)
    % System parameters
    % global spread center weight;
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
    t = x(7);
    xdd = [cos(t) -sin(t) cos(t) -sin(t) cos(t) -sin(t)];
     xd = [sin(t) cos(t) sin(t) cos(t) sin(t) cos(t) ]';
     % xdd = [cos(t); -sin(t); cos(t); -sin(t); 1; 0; 0; 0; 0; 0; 0; 0];
     %  xd = [sin(t); cos(t); sin(t); cos(t); t; 1; 0; 0; 0; 0; 7; 0];
    z = zeros(6, 1);

    % RBF Function (Gaussian)
c = [6, 4, 3, 7, 5, 5];
    for w = 1:2:5
        z(w) = x(w) - xd(w);
        
    end


    de = zeros(1,3);
    for q = 2:2:6
        z(q) = x(q) - xdd(q - 1) + c(q-1) * z(q - 1);% Tune alpha parameters
                de(q/2) = x(q)-xd(q);
    end

    e = [z(1) z(3) z(5)];
   
    e2 = [z(2) z(4) z(6)];

    % q1 = 0.1; q2 = 0.1; q3 = 0.1; q4 = 0.1; q5 = 0.1; q6 = 0.1;
    % k1 = 0.1; k2 = 0.1; k3 = 0.1; k4 = 0.1; k5 = 0.1; k6 = 0.1;
    k=3;
    % Control inputs 
    U2 = 1 / b1 * (- a1 * x(4) * x(6) - a2 * ob * x(4) -c(1)*de(1) - e(1) + xdd(2)  -c(2)*e2(1));
    U3 = 1 / b2 * (- a3 * x(2) * x(6) - a4 * ob * x(2) -c(3)*de(2) - e(2) + xdd(4)  -c(4)*e2(2));
    U4 = 1 / b3 * (- a5 * x(2) * x(4) - c(5)*de(3) - e(3) + xdd(6) -c(6)*e2(3));


    % System dynamics
    dx1 = x(2);
    dx2 = a1 * x(4) * x(6) + a2 * ob * x(4) + b1 * U2 ;
    dx3 = x(4) ;
    dx4 = a3 * x(2) * x(6) + a4 * ob * x(2) + b2 * U3 ;
    dx5 = x(6) ;
    dx6 = a5 * x(2) * x(4) + b3 * U4;
    
    % State vector
    dx = [dx1 dx2 dx3 dx4 dx5 dx6]; 

dbstop if error
