clear all;

%% data mining
oldFolder = cd('volt_data');
load 2016feb19_highSpeedVid_data.mat
dfree = dataCell;
tSfree = timeStep;
load 2016may02_frequencySpan_glued_data.mat
dglue = dataCell;
tSglue = timeStep;
load 2016may03_frequencySpan_PCplatesTaped2_data.mat
dtape = dataCell;
tStape = timeStep;
cd(oldFolder);

vfree = dfree{1, 1};
vglue = dglue{1, 1};
vtape = dtape{1, 1};

tfree =(0:tSfree:tSfree*(length(vfree)-1));
tglue =(0:tSglue:tSglue*(length(vglue)-1));
ttape =(0:tStape:tStape*(length(vtape)-1));


%% filtering
N = 6;  % butterworth filter order
Cf = 50;  % cutoff frequency
Sf = 1/timeStep;  % sampling frequency
Wn = Cf*2/Sf;  % butterworth cutoff frequency
[B, A] = butter(N, Wn);  % butterworth filtering

d2filt = filtfilt(B, A, vfree);


%% spectrogram
% %pick 1 in every 10 data points
% v2thin = [];
% d2filtThin = [];
% j = 1;
% for i = 1:1:length(tfree)
%     if mod(i, 10) == 1
%         t2thin(j) = tfree(i);
%         v2thin(j) = vfree(i);
%         d2filtThin(j) = d2filt(i);
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
% % spectrogram(v2thin, window, noverlap, nfft, fs, 'yaxis');
% % axis([0.0, 1.5, 0.01, 0.045]);
% % grid on


%% plotting
plot(tfree, vfree, ttape, vtape, tglue, vglue);

set(gca,'fontname','Times New Roman');
legend('Free', 'Taped', 'Glued');
% title('secure types, cycling at 45Hz, 40s warm-up');
xlabel('Time (s)');
ylabel('Voltage (V)');
axis([40, 50, -.5, .5]);
