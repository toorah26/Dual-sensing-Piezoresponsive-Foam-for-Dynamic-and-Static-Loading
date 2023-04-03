clear all;

oldFolder = cd('volt_data');
load 6Probe_P1_data.mat
dNeat = dataCell;
tNeat = timeStep;

load 6Probe_4-2_data.mat
dNano = dataCell;
tNano = timeStep;

cd(oldFolder);

%truncation
%lmin=min([length(d2{1,1}) length(d4{1,1}) length(d6{1,1})]);
%d2{1,1}=d2{1,1}(1:lmin);
%d4{1,1}=d4{1,1}(1:lmin);
%d6{1,1}=d6{1,1}(1:lmin);


tVarNeat=(0:tNeat:tNeat*(length(dNeat{1,1})-1));
tVarNano=(0:tNano:tNano*(length(dNano{1,1})-1));



%% filtering
N = 6;  % butterworth filter order
Cf = 40;  % cutoff frequency
Sf = 1 / timeStep;  % sampling frequency
Wn = Cf / (Sf / 2);  % normalized cutoff frequency
[D, C] = butter(N, Wn, 'low');  % butterworth filtering
neat = filtfilt(D, C, dNeat{1,1});  % filtered amplitude
nano = filtfilt(D, C, dNano{1,1});  % filtered amplitude

%% spectrogram
% %pick 1 in every 10 data points
% tVarNeatThin = [];
% dNeatThin = [];
% dNanoThin = [];
% j = 1;
% for i = 1:1:length(tVarNeat)
%     if mod(i, 10) == 1
%         tVarNeatThin(j) = tVarNeat(i);
%         dNeatThin(j) = dNeat{1, 1}(i);
%         dNanoThin(j) = dNano{1, 1}(i);
%         j = j + 1;
%     end
% end
% 
% window = 10000;
% noverlap = 9900;  % must be less than window
% nfft = 60000;  % never go over 100k
% fs = 1 / (10*timeStep);
% 
% figure
% spectrogram(dNeatThin, window, noverlap, nfft, fs, 'yaxis');
% % axis([0, 2, 0, 0.050]);
% grid on



% plot(tVarNano,dNano{1,1},tVarNeat,dNeat{1,1});
plot(tVarNeat,neat, tVarNano,nano);
set(gca,'fontname','Times New Roman');
legend('Neat Foam','Nanocomposite Foam');
% title('Composite Testing, 6 Probes, 2015Jun29');
xlabel('Time (s)');
ylabel('Voltage (V)');
