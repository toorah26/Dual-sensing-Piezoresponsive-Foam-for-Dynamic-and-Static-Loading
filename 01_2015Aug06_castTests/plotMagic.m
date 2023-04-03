clear all;

oldFolder = cd('volt_data');
load brassCastNeatFree_data.mat
dBCNF = dataCell;
tBCNF = timeStep;
load brassCastNeatAdhered_data.mat
dBCNA = dataCell;
tBCNA = timeStep;
load brassCastNanoFree_data.mat
dBCNaF = dataCell;
tBCNaF = timeStep;
load brassCastNanoAdhered_data.mat
dBCNaA = dataCell;
tBCNaA = timeStep;
cd(oldFolder);

%truncation
%lmin=min([length(d2{1,1}) length(d4{1,1}) length(d6{1,1})]);
%d2{1,1}=d2{1,1}(1:lmin);
%d4{1,1}=d4{1,1}(1:lmin);
%d6{1,1}=d6{1,1}(1:lmin);


tVarBCNF=(0:tBCNF:tBCNF*(length(dBCNF{1,1})-1));
tVarBCNA=(0:tBCNA:tBCNA*(length(dBCNA{1,1})-1));
tVarBCNaF=(0:tBCNaF:tBCNaF*(length(dBCNaF{1,1})-1));
tVarBCNaA=(0:tBCNaA:tBCNaA*(length(dBCNaA{1,1})-1));


%% pick 1 in every 10 data points
t1Thin = [];
t2Thin = [];
neatThin = [];
nanoThin = [];
j = 1;
for i = 1:1:length(tVarBCNA)
    if mod(i, 50) == 1
        t1Thin(j) = tVarBCNA(i);
        neatThin(j) = dBCNA{1,1}(i);
        j = j + 1;
    end
end

j = 1;
for i = 1:1:length(tVarBCNaA)
    if mod(i, 50) == 1
        t2Thin(j) = tVarBCNaA(i);
        nanoThin(j) = dBCNaA{1,1}(i);
        j = j + 1;
    end
end


%% filtering
N = 6;  % butterworth filter order
Cf = 40;  % cutoff frequency
Sf = 1 / timeStep;  % sampling frequency
Wn = Cf / (Sf / 2);  % normalized cutoff frequency
[D, C] = butter(N, Wn, 'low');  % butterworth filtering
neat = filtfilt(D, C, dBCNA{1,1});  % filtered amplitude
nano = filtfilt(D, C, dBCNaA{1,1});  % filtered amplitude
neatThinFilt = filtfilt(D, C, neatThin);  % filtered amplitude
nanoThinFilt = filtfilt(D, C, nanoThin);  % filtered amplitude


%% plot(tVarBCNF,dBCNF{1,1},tVarBCNA,dBCNA{1,1},tVarBCNaF,dBCNaF{1,1},tVarBCNaA,dBCNaA{1,1});
% legend('Neat Free','Neat Adhered','Nano Free','Nano Adhered');
% plot(tVarBCNA,dBCNA{1,1},tVarBCNaA,dBCNaA{1,1});
plot(tVarBCNaA, nano, tVarBCNA, neat);
% plot(t1Thin, neatThinFilt, t2Thin, nanoThinFilt);
set(gca,'fontname','Times New Roman');
legend('Nanocomposite Foam','Neat Foam');
% title('Brass Plates, Cast, 2015Aug06');
xlabel('Time (s)');
ylabel('Voltage (V)');
axis([4.97, 5.11, -5e-3, 5e-3]);