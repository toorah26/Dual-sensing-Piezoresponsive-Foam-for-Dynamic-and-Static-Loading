clear all;

oldFolder = cd('volt_data');
load 2016jan13_pcPlateProbe_neat2_data.mat
dPCNA = dataCell;
tPCNA = timeStep;
load 2016jan15_pcPlateProbe_nanocomp2_data.mat
dPCNaA = dataCell;
tPCNaA = timeStep;
cd(oldFolder);

tVarPCNA=(0:tPCNA:tPCNA*(length(dPCNA{1,1})-1));
tVarPCNaA=(0:tPCNaA:tPCNaA*(length(dPCNaA{1,1})-1));


%% filtering
N = 6;  % butterworth filter order
Cf = 50;  % cutoff frequency
Sf = 1 / timeStep;  % sampling frequency
Wn = Cf / (Sf / 2);  % normalized cutoff frequency
[D, C] = butter(N, Wn, 'low');  % butterworth filtering
neat = filtfilt(D, C, dPCNA{1,1});  % filtered amplitude
nano = filtfilt(D, C, dPCNaA{1,1});  % filtered amplitude


%% plotting
% plot(tVarPCNA,dPCNA{1,1},tVarPCNaA,dPCNaA{1,1});
plot(tVarPCNaA, nano, tVarPCNA, neat);
% title('polycarbonate plates, cast, adhered, 2015jan15');
set(gca,'fontname','Times New Roman');
legend('Nanocomposite Foam','Neat Foam');
xlabel('Time (s)');
ylabel('Voltage (V)');
