clear all;

%% data mining
oldFolder = cd('volt_data');
load 2016jan26_instronCycle1-8_equalTime_preLoad_data.mat
d2 = dataCell;
ts2 = timeStep;
% load 2016jan26_instronCycle1-8_equalTime_preLoad_data.mat
% d8 = dataCell;
% ts8 = timeStep;
% load 2016jan26_instronCycle125-8_latex_data.mat
% d8 = dataCell;
% ts8 = timeStep;
cd(oldFolder);

t2 =(0:ts2:ts2*(length(d2{1,1})-1));
% t8 =(0:ts8:ts8*(length(d8{1,1})-1));
% t5 =(0:ts5:ts5*(length(d5{1,1})-1));
% t5i =(0:ts5i:ts5i*(length(d5i{1,1})-1));
% t5i2 =(0:ts5i2:ts5i2*(length(d5i2{1,1})-1));

v2 = d2{1, 1};

% f = 99.5;
% T = 1/f;
% 
% sq2 = (2.8*square(2*pi*f*(t2+T/4),49.49)-0.055)';%+randn(size(t2))/10;
% dcnvlv2 = v2-sq2;

%% filtering
N = 6;  % butterworth filter order
Cf = 50;  % cutoff frequency
Sf = 1/timeStep;  % sampling frequency
Wn = Cf*2/Sf;  % butterworth cutoff frequency
[B, A] = butter(N, Wn);  % butterworth filtering

d2filt = filtfilt(B, A, v2);
d2filt = d2filt*1000;
% d8filt = filtfilt(B, A, d8{1, 1});
% d5filt = filtfilt(B, A, d5{1, 1});
% d5ifilt = filtfilt(B, A, d5i{1, 1});
% d5i2filt = filtfilt(B, A, d5i2{1, 1});

% d2resistance = d2filt/(3/10000);
% d8resistance = d8filt/(3/10000);

%% plotting
%plot(t2,dcnvlv2,t2,v2,t2,sq2,t2,d2filt);
%legend('difference','raw','square','difference-filtered, cutoff f=40Hz');
% plot(t2,dcnvlv2,t2,d2filt);
% legend('difference','difference-filitered, f_c=150Hz');
%plot(t2,dcnvlv2,t2,v2,t2,sq2);
%plot(t2,d2{1,1},t5,d5{1,1});
% plot(t2,d2{1,1},t2,d2filt);
%plot(t8,d8{1,1},t8,d8filt);
%plot(t8,d8filt);
% plot(t5,d5{1,1},t5,d5filt);
%plot(t5i2,d5i2{1,1},t5i2,d5i2filt);

plot(t2, d2filt);


set(gca,'fontname','Times New Roman');
set(gca,'fontsize',16);

% plot(t2,d2filt); %voltage+resistance
%plot(t8,d8filt); %voltage+resistance

% legend('filt','raw');
%title('latex foam with conductive fabric, instron cycling, 0.125-2 Hz, 2016jan28');
xlabel('Time (s)');
xlim([35,36]);
ylabel('Voltage (mV)');
ylim([-15,15]);

