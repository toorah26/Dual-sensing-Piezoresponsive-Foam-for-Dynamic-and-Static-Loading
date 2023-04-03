clear all;

volume = [1.8 1.2 0.5];
voltage = [0.4 0.2 0.12];


scatter(volume,voltage);
hold on ;
my_poly=polyfit(volume,voltage,1);
X2= 0.5:0.01:1.8; % X data range 
Y2=polyval(my_poly,X2);

c1 = my_poly(1);
c2 = my_poly(2);
% c3 = my_poly(3);

plot(X2,Y2);

set(gca,'fontname','Times New Roman');
legend('Data', ['Polynomial Fit: ' num2str(c1) 'x + ' num2str(c2)], 'Location', 'northwest');
xlabel('Volume (inches^{3})');
ylabel('Voltage (V)');
axis([0.5, 2, 0, 0.5]);
