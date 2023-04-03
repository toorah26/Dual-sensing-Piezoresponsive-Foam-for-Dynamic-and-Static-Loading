clear all;

%% data mining
oldFolder = cd('volt_data');
load 2016apr29_frequencySpan_nanoCastPCplates_taped_data.mat
dC0 = dataCell;
tS0 = timeStep;
% load 2016apr27_frequencySpan_decreasing_data.mat
% dC1 = dataCell;
% tS1 = timeStep;
% load 2016apr14_volumeSubtraction4x1_2out_data.mat
% dC2 = dataCell;
% tS2 = timeStep;
% load 2016apr14_volumeSubtraction4x1_3out_data.mat
% dC3 = dataCell;
% tS3 = timeStep;
cd(oldFolder);

t0 =(0:tS0:tS0*(length(dC0{1,1})-1));
% t1 =(0:tS1:tS1*(length(dC1{1,1})-1));
% t2 =(0:tS2:tS2*(length(dC2{1,1})-1));
% t3 =(0:tS3:tS3*(length(dC3{1,1})-1));

d0 = dC0{1, 1};
% d1 = dC1{1, 1};
% d2 = dC2{1, 1};
% d3 = dC3{1, 1};

%% filtering
N = 6;  % butterworth filter order
Cf = 100;  % cutoff frequency
Sf = 1/timeStep;  % sampling frequency
Wn = Cf*2/Sf;  % butterworth cutoff frequency
[B, A] = butter(N, Wn);  % butterworth filtering

d0filt = filtfilt(B, A, d0);
% d1filt = filtfilt(B, A, d1);
% d2filt = filtfilt(B, A, d2);
% d3filt = filtfilt(B, A, d3);


d0flip = flipud(d0filt);


% % spectrogram
% %pick 1 in every 10 data points
% dThin = [];
% dFiltThin = [];
% j = 1;
% for i = 1:1:length(t0)
%     if mod(i, 10) == 1
%         t0thin(j) = t0(i);
%         d0thin(j) = d0flip(i);
%         d0filtthin(j) = d0filt(i);
%         j = j + 1;
%     end
% end
% 
% window = 10000;
% noverlap = 9900;  % must be less than window
% nfft = 60000;  % never go over 100k
% fs = 1 / (10*tS0);
% 
% figure
% set(gca,'fontname','Times New Roman');
% spectrogram(d0filtthin, window, noverlap, nfft, fs, 'yaxis');
% % axis([0, 2, 0, 50]);
% axis([5, 6.6, 0, 50]);
% % grid on



%% plotting
plot(t0, d0filt);
set(gca,'fontname','Times New Roman');
% set(gca, 'YTick', -0.4:0.1:0.2)
% legend('decreasing');
% title('frequency decrease, rig cycling, 2016apr29, 300s warmup');
xlabel('Time (s)');
ylabel('Voltage (V)');

% axis([0, 115, -0.08, 0.08]);
% set(gca, 'XTick', 10:15:115)

axis([295, 410, -0.08, 0.08]);
set(gca, 'XTick', 300:15:405)

% axis([0, 220, -0.4, 0.2]);
% axis([0, 110, -0.08, 0.08]);
% grid on
% grid minor
% ax = gca;
% ax.Layer = 'top'
