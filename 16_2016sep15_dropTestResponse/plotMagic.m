clear all;

%% data mining
oldFolder = cd('volt_data');
load 2016apr29_frequencySpan_nanoCastPCplates_taped_data.mat
dC0 = dataCell;
tS0 = timeStep;
load 2016jan21_floorDropNano2_data.mat
dC1 = dataCell;
tS1 = timeStep;
load 2016may03_frequencySpan_PCplatesTaped2_data.mat
dC2 = dataCell;
tS2 = timeStep;
cd(oldFolder);

t0 =(0:tS0:tS0*(length(dC0{1,1})-1));
t1 =(0:tS1:tS1*(length(dC1{1,1})-1));
t2 =(0:tS2:tS2*(length(dC2{1,1})-1));

d0 = dC0{1, 1};
d1 = dC1{1, 1};
d2 = dC2{1, 1};

%% filtering
N = 6;  % butterworth filter order
Cf = 100;  % cutoff frequency
Sf = 1/timeStep;  % sampling frequency
Wn = Cf*2/Sf;  % butterworth cutoff frequency
[B, A] = butter(N, Wn);  % butterworth filtering

d0filt = filtfilt(B, A, d0);
d1filt = filtfilt(B, A, d1);
d2filt = filtfilt(B, A, d2);




%% spectrogram
% %pick 1 in every 10 data points
% dThin = [];
% dFiltThin = [];
% j = 1;
% for i = 1:1:length(t0)
%     if mod(i, 10) == 1
%         t0thin(j) = t0(i);
%         d0thin(j) = d0(i);
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
% spectrogram(d0thin, window, noverlap, nfft, fs, 'yaxis');
% axis([5, 7, 0, 50]);
% grid on




%% plotting
% plot(t0, d0filt, t1, d1filt);
figure
plot(t1, d1filt);
set(gca,'fontname','Times New Roman');
set(gca,'fontsize',16);
% legend('Cyclic Compressions at 45 Hz', 'Impacts with 8.6 J');
% title('cyclic and drop testing');
xlabel('Time (s)');
ylabel('Voltage (V)');
% axis([0, 60, -.5, .5]);
axis([20.76, 20.85, -.1, .45]);


