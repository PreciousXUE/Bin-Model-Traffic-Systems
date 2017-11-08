function sys = process(t, x, flag, u, p)
L = 2; tau  = 0.2;   % road parameters
beta1 = 10; beta2 = 1;

q_inmin = 3000;   % simulation of inflow
q_in = 1220 * sin(pi*t) + q_inmin;

switch flag,
    case 0 % f(x,u,p,t)
        sys = [1/L*((x(1)-100)/(x(1)+x(2)-200)*q_in+u*(-0.8*x(2)^2+80*x(2))...
            -(tau +1)*(-0.8*x(1)^2+80*x(1)));  
            1/L*((1-(x(1)-100)/(x(1)+x(2)-200))*q_in-(u+1)*(-0.8*x(2)^2+80*x(2))...
            +tau *(-0.8*x(1)^2+80*x(1)));
            beta1*x(1)+beta2*x(2)];
    case 1 % df/dx
        sys = [1/L*((x(2)-100)/((x(1)+x(2)-200)^2)*q_in-(tau +1)*(-1.6*x(1)+80)),...
            1/L*((100-x(2))/((x(1)+x(2)-200)^2)*q_in+tau *(-1.6*x(1)+80)), beta1;...
            1/L*((100-x(1))/((x(1)+x(2)-200)^2)*q_in+u*(-1.6*x(2)+80)),...
            1/L*((x(1)-100)/((x(1)+x(2)-200)^2)*q_in-(u+1)*(-1.6*x(2)+80)),beta2;...
            0,0,0];
    case 2 % df/du
        sys = [1/L*(-0.8*x(2)^2+80*x(2)), -1/L*(-0.8*x(2)^2+80*x(2)), 0];
    case 3 % df/dp
        sys = [];
    case 4 % df/dt  % assume constant q_in
        sys = [1/L*(x(1)-100)/(x(1)+x(2)-200)*1220*pi*cos(pi*t), 1/L*(x(2)-100)/(x(1)+x(2)-200)*1220*pi*cos(pi*t),0];
 % %       sys = [1/L*(x(1)-100)/(x(1)+x(2)-200)*4000*pi*cos(pi*t), 1/L*(x(2)-100)/(x(1)+x(2)-200)*4000*pi*cos(pi*t),0];

    case 5 % x0     
        sys = [25; 25; 0];
    case 6 % dx0/dp
        sys = [];
    case 7 % M
        sys = [];
    case 8 % unused flag
        sys = [];
    otherwise
        error(['unhandled flag = ',num2str(flag)]); 
end