clear all;

%% data mining
oldFolder = cd('volt_data');
load 2016apr11_volumeSubtraction_full_data.mat
dCfull = dataCell;
tSfull = timeStep;
load 2016apr11_volumeSubtraction_1out_data.mat
dC1 = dataCell;
tS1 = timeStep;
load 2016apr11_volumeSubtraction_2out_data.mat
dC2 = dataCell;
tS2 = timeStep;
load 2016apr11_volumeSubtraction_3out_data.mat
dC3 = dataCell;
tS3 = timeStep;
load 2016apr11_volumeSubtraction_4out_data.mat
dC4 = dataCell;
tS4 = timeStep;
cd(oldFolder);

tfull =(0:tSfull:tSfull*(length(dCfull{1,1})-1));
t1 =(0:tS1:tS1*(length(dC1{1,1})-1));
t2 =(0:tS2:tS2*(length(dC2{1,1})-1));
t3 =(0:tS3:tS3*(length(dC3{1,1})-1));
t4 =(0:tS4:tS4*(length(dC4{1,1})-1));

dfull = dCfull{1, 1};
d1 = dC1{1, 1};
d2 = dC2{1, 1};
d3 = dC3{1, 1};
d4 = dC4{1, 1};

%% filtering
N = 6;  % butterworth filter order
Cf = 120;  % cutoff frequency
Sf = 1/timeStep;  % sampling frequency
Wn = Cf*2/Sf;  % butterworth cutoff frequency
[B, A] = butter(N, Wn);  % butterworth filtering

dfullfilt = filtfilt(B, A, dfull);
d1filt = filtfilt(B, A, d1);
d2filt = filtfilt(B, A, d2);
d3filt = filtfilt(B, A, d3);
d4filt = filtfilt(B, A, d4);

% %% spectrogram
% %pick 1 in every 10 data points
% dThin = [];
% dFiltThin = [];
% j = 1;
% for i = 1:1:length(t)
%     if mod(i, 10) == 1
%         tThin(j) = t(i);
%         dThin(j) = d(i);
%         dFiltThin(j) = dFilt(i);
%         j = j + 1;
%     end
% end
% 
% window = 10000;
% noverlap = 9900;  % must be less than window
% nfft = 60000;  % never go over 100k
% fs = 1 / (10*tS);
% 
% figure
% spectrogram(dThin, window, noverlap, nfft, fs, 'yaxis');
% % axis([0.0, 2.2, 0.01, 0.060]);
% grid on




%% plotting
plot(t2, d2filt, t3, d3filt, t4, d4filt);
set(gca,'fontname','Times New Roman');
legend('1.8 inches^{3}', '1.2 inches^{3}', '0.5 inches^{3}', 'Location', 'northwest');
% title('volume subtraction, rig cycling, ~15 Hz, 2016apr11');
xlabel('Time (s)');
ylabel('Voltage (V)');

