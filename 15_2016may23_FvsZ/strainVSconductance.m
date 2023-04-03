clear all;

strain = [0.80 0.85 0.90];
impedance = [1.85e5 1.65e5 1.6e5];
conductance = 1./impedance;


scatter(strain, impedance);
hold on ;
my_poly=polyfit(strain, impedance, 1);
X2= 0.8:0.01:0.9; % X data range 
Y2=polyval(my_poly,X2);

c1 = my_poly(1);
c2 = my_poly(2);
% c3 = my_poly(3);

plot(X2,Y2);

set(gca,'fontname','Times New Roman');
legend('Data', ['Linear Fit: ' num2str(c1) 'x + ' num2str(c2)], 'Location', 'northwest');
set(gca,'YDir','Reverse')
xlabel('Nominal Strain');
ylabel('Impedance (\Omega)');
axis([0.79, 0.91, 1.55e5, 1.875e5]);
