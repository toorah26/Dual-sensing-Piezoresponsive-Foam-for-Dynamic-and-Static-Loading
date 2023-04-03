clear all;

temperature = [30.1 36.5 42.7 46.9 51.7 56.2 59 62.7 65.9 66.5 67.4 66.7 67.8 67.6];
voltage = [0.04	0.1 0.13 0.15 0.16 0.18 0.19 0.2 0.21 0.21 0.21 0.22 0.22 0.23].*1000;
time = linspace(0,130,14);

scatter(temperature, voltage,'bo','LineWidth',1.5);
hold on ;
my_poly=polyfit(temperature, voltage, 1);
xRange= linspace(30.1, 67.8, 14); % X data range 
yFit=polyval(my_poly, xRange);

 yResid = voltage - yFit;
 ssResid = sum(yResid.^2);
  voltageAve = sum(voltage)/length(voltage);
 yTotal = voltage - voltageAve;
 ssTotal = sum(yTotal.^2);
 rsq = 1 - ssResid/ssTotal

c1 = my_poly(1);
c2 = my_poly(2);
% c3 = my_poly(3);

set(gca,'fontname','Times New Roman');
set(gca,'fontsize',16);
plot(xRange,yFit,'-r','LineWidth',1.5);


legend('Foam Output', 'Linear Fit: V = 4.0T - 61.0', 'Location', 'northwest');% 'x + ' num2str(c3)]);
xlabel('Temperature (\circC)');
ylabel('Average Peak Voltage (mV)');
axis([25, 70, 25, 240]);


figure
xlabel('Elapsed Time (s)')
yyaxis left;
plot(time,voltage,'ob')
ylabel('Voltage (V)')
yyaxis right;
plot(time,temperature,'or')
ylabel('Temperature (\circC)')
legend('Voltage','Temperature','Location','northwest')
