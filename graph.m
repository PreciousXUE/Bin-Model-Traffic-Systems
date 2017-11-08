tau  = 0.2; 
beta1 = 10; beta2 = 1;  % system parameters

load optimprofiles tplot uplot xplot

% ploting
%..........................................................................
figure(1)
plot(tplot,uplot,'k')
title('')
xlabel('Time (h)')
ylabel('u')
axis tight %([0 1 -4 10])
%set(1,'PaperUnits','centimeters')
%set(1,'PaperPosition',[3 10 11 8.25])
hold on;     


% to check whether there is singular optimal signal
temp1 = beta1-(beta1-beta2)./(1.6*xplot(:,2)-1.6*xplot(:,1)).*(-1.6*xplot(:,1)+80);
temp2 = (beta2-beta1)./(1.6*(xplot(:,2)-xplot(:,1)).^2);

q_inmin = 3000;
q_in = 1220 * sin(pi*tplot) + q_inmin;
q_in1 = q_in .* (xplot(:,1) - 100) ./ (xplot(:,1) + xplot(:,2) - 200);
q_in2 = q_in-q_in1;

temp3 = q_in1-q_in2-(2*tau +1)*(-0.8*xplot(:,1).^2+80*xplot(:,1))+(-0.8*xplot(:,2).^2+80*xplot(:,2));
u_singular = (temp1./temp2-temp3)./(2*(-0.8*xplot(:,2).^2+80*xplot(:,2)));
plot(tplot, u_singular, '-r')

%--------------------------------------------------------
figure(2)
plot(tplot, xplot(:,1), 'c-', tplot, xplot(:,2), 'b:')
title('')
xlabel('Time')
ylabel('Density (veh/km)')
legend('k_1', 'k_2')
axis tight %([0 1 0 1])
%set(1,'PaperUnits','centimeters')
%set(1,'PaperPosition',[3 10 11 8.25])
%--------------------------------------------------------

figure(3)
plot(tplot, xplot(:,3))
title('')
xlabel('time')
ylabel('x_3')
legend('x_3')
axis tight %([0 1 0 1])
%set(1,'PaperUnits','centimeters')
%set(1,'PaperPosition',[3 10 11 8.25])


%--------------------------------------------------------
figure(4)
plot(tplot, q_in1, 'r-', tplot, q_in2, 'b:')
legend('q_{in}^1', 'q_{in}^2')
xlabel('Time (h)'); ylabel('Inflows (veh/h)');

%..........................................................................