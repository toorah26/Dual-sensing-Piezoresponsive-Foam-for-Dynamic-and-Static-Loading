%{
QAMresistance.m
2016may16
cory newton

This script accepts two input signals, uses QAM (Quadrature Amplitude
Modulation) to find their respective I(t) and Q(t), then compares the two
signals to result the impedance.
%}

clear all
clc


%% constants
Z1 = 10e3;  % series resistor


%% data mining
oldFolder = cd('volt_data');
load 2016may23_FvsZ_lowStrain_data.mat
vINlow = dataCell{1, 1};
tsINlow = timeStep;
tINlow =(0:tsINlow:tsINlow * (length(vINlow) - 1)).';
vOUTlow = dataCell{2, 1};
tsOUTlow = timeStep;  % identical to tsIN
tOUTlow =(0:tsOUTlow:tsOUTlow * (length(vOUTlow) - 1)).';  % identical to tIN?

load 2016may23_FvsZ_midStrain_data.mat
vINmid = dataCell{1, 1};
tsINmid = timeStep;
tINmid =(0:tsINmid:tsINmid * (length(vINmid) - 1)).';
vOUTmid = dataCell{2, 1};
tsOUTmid = timeStep;  % identical to tsIN
tOUTmid =(0:tsOUTmid:tsOUTmid * (length(vOUTmid) - 1)).';  % identical to tIN?



cd(oldFolder);


%% demodulation
f0 = 5e3;  % carrier frequency ?? probably input frequency, 5kHz. might need to extract this exact frequency as a function of time (FFT) - check out evan's max peak from spectrogram code
cosdemodlow = cos(2 * pi() * f0 * tINlow);  % cosine signal multiplier
sindemodlow = sin(2 * pi() * f0 * tINlow);  % sine signal multiplier
cosdemodmid = cos(2 * pi() * f0 * tINmid);  % cosine signal multiplier
sindemodmid = sin(2 * pi() * f0 * tINmid);  % sine signal multiplier

% filtering parameters
N = 6;  % butterworth filter order
Cf = 1e4;  % cutoff frequency
Sf = 1 / timeStep;  % sampling frequency
Wn = Cf / (Sf / 2);  % normalized cutoff frequency
[B, A] = butter(N, Wn, 'low');  % butterworth filtering

% input signal
vINr = vINlow .* cosdemodlow;  % multiply by cosine
iINlow = filtfilt(B, A, vINr);  % in-phase component
vINr2 = vINlow .* sindemodlow;  % multiply by sine
qINlow = filtfilt(B, A, vINr2);  % out-phase component

vINr = vINmid .* cosdemodmid;  % multiply by cosine
iINmid = filtfilt(B, A, vINr);  % in-phase component
vINr2 = vINmid .* sindemodmid;  % multiply by sine
qINmid = filtfilt(B, A, vINr2);  % out-phase component



% output signal
vOUTr = vOUTlow .* cosdemodlow;  % multiply by cosine
iOUTlow = filtfilt(B, A, vOUTr);  % in-phase component
vOUTr2 = vOUTlow .* sindemodlow;  % multiply by sine
qOUTlow = filtfilt(B, A, vOUTr2);  % out-phase component

vOUTr = vOUTmid .* cosdemodmid;  % multiply by cosine
iOUTmid = filtfilt(B, A, vOUTr);  % in-phase component
vOUTr2 = vOUTmid .* sindemodmid;  % multiply by sine
qOUTmid = filtfilt(B, A, vOUTr2);  % out-phase component



%% demodulated signal calculation
ampINlow = sqrt(iINlow.^2 + qINlow.^2);  % amplitude of voltage IN
phaINlow = atan2(qINlow, iINlow);  % phase of voltage IN
ZINlow = complex(ampINlow, phaINlow);

ampOUTlow = sqrt(iOUTlow.^2 + qOUTlow.^2);  % amplitude of voltage OUT
phaOUTlow = atan2(qOUTlow, iOUTlow);  % phase of voltage OUT
ZOUTlow = complex(ampOUTlow, phaOUTlow);

ampINmid = sqrt(iINmid.^2 + qINmid.^2);  % amplitude of voltage IN
phaINmid = atan2(qINmid, iINmid);  % phase of voltage IN
ZINmid = complex(ampINmid, phaINmid);

ampOUTmid = sqrt(iOUTmid.^2 + qOUTmid.^2);  % amplitude of voltage OUT
phaOUTmid = atan2(qOUTmid, iOUTmid);  % phase of voltage OUT
ZOUTmid = complex(ampOUTmid, phaOUTmid);



%% resistance calculation
% ampZ2low = Z1 .* (ampINlow ./ ampOUTlow - 1);  % impedance amplitude
% phaZ2low = Z1 .* (phaINlow ./ phaOUTlow - 1);  % impedance phase
% ampZ2mid = Z1 .* (ampINmid ./ ampOUTmid - 1);  % impedance amplitude
% phaZ2mid = Z1 .* (phaINmid ./ phaOUTmid - 1);  % impedance phase
% ampZ2high = Z1 .* (ampINhigh ./ ampOUThigh - 1);  % impedance amplitude
% phaZ2high = Z1 .* (phaINhigh ./ phaOUThigh - 1);  % impedance phase
% Z2 = ampZ2 .* exp(1i * (2 * pi * f0) * phaZ2);  % Euler equation
% R = real(Z2);
% X = imag(Z2);

Z2low = Z1 ./ (ZINlow ./ ZOUTlow - 1);  % impedance
Z2lowReal = real(Z2low);
Z2mid = Z1 ./ (ZINmid ./ ZOUTmid - 1);  % impedance

% Zstarlow = Z2low;
% Ystarlow = 1 ./ Zstarlow;
% jBimaglow = imag(Ystarlow);
% jwCimaglow = 1 ./ jBimaglow;
% caplow = jwCimaglow ./ (2*pi()*f0);
% 
% Zstarmid = Z2mid;
% Ystarmid = 1 ./ Zstarmid;
% jBimagmid = imag(Ystarmid);
% jwCimagmid = 1 ./ jBimagmid;
% capmid = jwCimagmid ./ (2*pi()*f0);
% 
% Zstarhigh = Z2high;
% Ystarhigh = 1 ./ Zstarhigh;
% jBimaghigh = imag(Ystarhigh);
% jwCimaghigh = 1 ./ jBimaghigh;
% caphigh = jwCimaghigh ./ (2*pi()*f0);




% filtering parameters
N = 6;  % butterworth filter order
Cf = 40;  % cutoff frequency
Sf = 1 / timeStep;  % sampling frequency
Wn = Cf / (Sf / 2);  % normalized cutoff frequency
[D, C] = butter(N, Wn, 'low');  % butterworth filtering
Z2lowfilt = filtfilt(D, C, real(Z2low));  % filtered amplitude
Z2midfilt = filtfilt(D, C, real(Z2mid));  % filtered amplitude


% caplowfilt = filtfilt(D, C, caplow);  % filtered amplitude
% capmidfilt = filtfilt(D, C, capmid);  % filtered amplitude
% caphighfilt = filtfilt(D, C, caphigh);  % filtered amplitude


% %% spectrogram
% %pick 1 in every 10 data points
% tINlowThin = [];
% Z2lowThin = [];
% j = 1;
% for i = 1:1:length(tINlow)
%     if mod(i, 10) == 1
%         tINlowThin(j) = tINlow(i);
%         Z2lowThin(j) = Z2lowReal(i);
%         j = j + 1;
%     end
% end
% 
% window = 10000;
% noverlap = 9900;  % must be less than window
% nfft = 60000;  % never go over 100k
% fs = 1 / (10*tsINlow);
% 
% figure
% spectrogram(Z2lowThin, window, noverlap, nfft, fs, 'yaxis');
% axis([0, 2, 0, 50]);
% grid on


%% resistance plot
% figure(1);
% plot(tINlow, caplow, tINmid, capmid, tINhigh, caphigh);
% figure(2);
% plot(tIN, X);

figure(1);
% plot(tINlow, Z2lowfilt, tINmid, Z2midfilt, tINhigh, Z2highfilt/1e6);
plot(tINlow, Z2lowfilt, tINmid, Z2midfilt);
set(gca,'fontname','Times New Roman');
% title('2016xxx##, impedance vs. time');
xlabel('Time (s)');
ylabel('Impedance (\Omega)');
xlim([60, 61]);
ylim([-0.5e5, 2.5e5]);
% set(gca, 'YTick', -0.5e5:0.1e5:2.5e5)
legend('0.70-0.90 Strain', '0.75-0.95 Strain');%, 'Large pre-strain');
