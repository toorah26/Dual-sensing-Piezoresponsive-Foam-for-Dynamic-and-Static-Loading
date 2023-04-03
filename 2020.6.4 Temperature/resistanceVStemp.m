%ResistanceVStemperature

R = [9664.732901
8964.26064
8917.845148
8926.810422
7574.712365
7892.558077]./1000;

T = [0
1.999632485
6.468670954
10.48010172
21.34974024
32.50406201];

fit = (9277-53.133.*T)./1000;

figure
hold on
set(gca,'fontname','Times New Roman');
set(gca,'fontsize',16);
plot(T,R,'o','LineWidth',1.5)
plot(T,fit,'-r','LineWidth',1.5)
xlabel('Temperature (\circC)')
ylabel('Resistance (MOhm)')
ylim([6,11])
legend('Foam Output','Linear Fit: R = 9.277 - 0.053T')
