clear all;

frequency = [45 37 32 28 21 16 10 0 1 2 3 4 5 6 7 8];
voltage = [132 119 99 87 77 60 37 0 2 5 8 10 13 15 18 20];


scatter(frequency, voltage,'LineWidth',1.5);
hold on ;
my_poly=polyfit(frequency, voltage, 1);
xRange= linspace(0, 50, 16); % X data range 
ylim([0,150]);
yFit=polyval(my_poly, xRange);

% yResid = voltage - yFit;
% ssResid = sum(yResid.^2);
% voltageAve = sum(voltage)/length(voltage);
% yTotal = voltage - voltageAve;
% ssTotal = sum(yTotal.^2);
% rsq = 1 - ssResid/ssTotal

c1 = my_poly(1);
c2 = abs(my_poly(2));
% c3 = my_poly(3);

set(gca,'fontname','Times New Roman');
set(gca,'fontsize',16);
plot(xRange,yFit,'LineWidth',1.5);

set(gca,'fontname','Times New Roman');
legend('Foam Output', ['Linear Fit: ' num2str(c1) 'x - ' num2str(c2)], 'Location', 'northwest');
xlabel('Cycling Frequency (Hz)');
ylabel('Average Peak Voltage (mV)');
% axis([25, 70, 0.025, 0.24]);

datapoints = length(dataCell)