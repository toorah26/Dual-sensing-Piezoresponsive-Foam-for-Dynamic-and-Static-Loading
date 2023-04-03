clear all;

%% data mining
filename = 'resistivityVSstrain.xlsx';
data = xlsread(filename);

strain_L1 = data(:,1);
resist_L1 = data(:,2);
rho_L1 = data(:,3);
conduc_L1 = data(:,4);

strain_L2 = data(:,5);
resist_L2 = data(:,6);
rho_L2 = data(:,7);
conduc_L2 = data(:,8);

strain_P1 = data(:,9);
resist_P1 = data(:,10);
rho_P1 = data(:,11);
conduc_P1 = data(:,12);

strain_P2 = data(:,13);
resist_P2 = data(:,14);
rho_P2 = data(:,15);
conduc_P2 = data(:,16);

strain_S1 = data(:,17);
resist_S1 = data(:,18);
rho_S1 = data(:,19);
conduc_S1 = data(:,20);

strain_S2 = data(:,21);
resist_S2 = data(:,22);
rho_S2 = data(:,23);
conduc_S2 = data(:,24);


%% plotting
hold on

% f1 = fit(strain_L1, conduc_L1, 'poly1', 'Exclude', strain_L1 < 0.79);
% plot(f1, strain_L1, conduc_L1, 'o');

% f2 = fit(strain_L2, conduc_L2, 'poly1');%, 'Exclude', strain_L2 < 0.79);
% plot(f2, strain_L2, conduc_L2, '+');

% f3 = fit(strain_P1, conduc_P1, 'poly1');%, 'Exclude', strain_L2 < 0.79);
% plot(f3, strain_P1, conduc_P1, '^');

% t = ~isnan(strain_P2) & ~isnan(conduc_P2);
% f4 = fit(strain_P2(t), conduc_P2(t), 'poly1');%, 'Exclude', conduc_P2 < 0.45);
% plot(f4, strain_P2, conduc_P2, 'x');


scatter(strain_L1, rho_L1, 'o');
scatter(strain_L2, rho_L2, '+');
scatter(strain_P1, rho_P1, '^');
scatter(strain_P2, rho_P2, 'x');
scatter(strain_S1, rho_S1, 's');
scatter(strain_S2, rho_S2, 'd');



set(gca,'YScale','log')
set(gca,'fontname','Times New Roman');
legend('Location', 'northwest', 'Latex-1','Latex-2', 'Polyurethane-1', 'Polyurethane-2', 'Silicone-1', 'Silicone-2');
set(gca,'YDir','Reverse')
% title('');
xlabel('Strain');
ylabel('Resistivity (\Omega/in^3)');
