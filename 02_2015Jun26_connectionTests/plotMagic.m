oldFolder = cd('volt_data');
load probe2_P1_data.mat
d2 = dataCell;
t2 = timeStep;

load probe4_P1_data.mat
d4 = dataCell;
t4 = timeStep;

load probe6_P1_data.mat
d6 = dataCell;
t6 = timeStep;

cd(oldFolder);

lmin=min([length(d2{1,1}) length(d4{1,1}) length(d6{1,1})]);
d2{1,1}=d2{1,1}(1:lmin);
d4{1,1}=d4{1,1}(1:lmin);
d6{1,1}=d6{1,1}(1:lmin);


tVar2=(0:t2:t2*(length(d2{1,1})-1));
tVar4=(0:t4:t4*(length(d4{1,1})-1));
tVar6=(0:t6:t6*(length(d6{1,1})-1));


plot(tVar6,d6{1,1},tVar4,d4{1,1},tVar2,d2{1,1});
set(gca,'fontname','Times New Roman');
legend('6 Probes','4 Probes','2 Probes');
% title('Probe Quantity Comparison, 2015Jun26');
xlabel('Time (s)');
ylabel('Voltage (V)');
