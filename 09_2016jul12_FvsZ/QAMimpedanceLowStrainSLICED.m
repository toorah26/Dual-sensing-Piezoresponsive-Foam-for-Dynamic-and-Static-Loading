%{
QAMimpedanceLowStrain.m
2016jul12
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
load 2016may23_FvsZ_lowStrain_data.mat
vINlow = dataCell{1, 1};
tsINlow = timeStep;
tINlow =(0:tsINlow:tsINlow * (length(vINlow) - 1)).';
vOUTlow = dataCell{2, 1};
tsOUTlow = timeStep;  % identical to tsIN
tOUTlow =(0:tsOUTlow:tsOUTlow * (length(vOUTlow) - 1)).';  % identical to tIN?



%% demodulation
f0 = 5e3;  % carrier frequency ?? probably input frequency, 5kHz. might need to extract this exact frequency as a function of time (FFT) - check out evan's max peak from spectrogram code
cosdemodlow = cos(2 * pi() * f0 * tINlow);  % cosine signal multiplier
sindemodlow = sin(2 * pi() * f0 * tINlow);  % sine signal multiplier

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

% output signal
vOUTr = vOUTlow .* cosdemodlow;  % multiply by cosine
iOUTlow = filtfilt(B, A, vOUTr);  % in-phase component
vOUTr2 = vOUTlow .* sindemodlow;  % multiply by sine
qOUTlow = filtfilt(B, A, vOUTr2);  % out-phase component


%% demodulated signal calculation
ampINlow = sqrt(iINlow.^2 + qINlow.^2);  % amplitude of voltage IN
phaINlow = atan2(qINlow, iINlow);  % phase of voltage IN
VcomplexINlow = complex(ampINlow, phaINlow);  % complex voltage IN

ampOUTlow = sqrt(iOUTlow.^2 + qOUTlow.^2);  % amplitude of voltage OUT
phaOUTlow = atan2(qOUTlow, iOUTlow);  % phase of voltage OUT
VcomplexOUTlow = complex(ampOUTlow, phaOUTlow);  % complex voltage OUT


%% resistance calculation
Z2low = Z1 ./ (VcomplexINlow ./ VcomplexOUTlow - 1);  % impedance

Z2try = Z1 ./ (vINlow ./ vOUTlow - 1);

Z2lowREAL = real(Z2low);
Z2lowIMAG = imag(Z2low);

Zstar = Z2low;
Ystar = 1 ./ Zstar;
jBimag = imag(Ystar);
jwCimag = 1 ./ jBimag;

capacitance = jwCimag ./ (2*pi()*f0);



% Z2 = ampZ2 .* exp(1i * (2 * pi * f0) * phaZ2);  % Euler equation
% R = real(Z2);
% X = imag(Z2);


%% remove AC wave from output voltage
vOUTlowRaw = vOUTlow - vINlow;


%% filtering
N = 6;  % butterworth filter order
Cf = 40;  % cutoff frequency
Sf = 1 / timeStep;  % sampling frequency
Wn = Cf / (Sf / 2);  % normalized cutoff frequency
[D, C] = butter(N, Wn, 'low');  % butterworth filtering
Z2lowREALfilt = filtfilt(D, C, Z2lowREAL);  % filtered amplitude
% capacitancefilt = filtfilt(D, C, capacitance);  % filtered amplitude
% 
% Z2tryfilt = filtfilt(D, C, Z2try);
% vOUTlowfilt = filtfilt(D, C, vOUTlow);

vOUTlowRawfilt = filtfilt(D, C, vOUTlowRaw);


%% spectrogram
% %pick 1 in every 10 data points
% tINlowThin = [];
% Z2lowREALfiltThin = [];
% j = 1;
% for i = 1:1:length(tINlow)
%     if mod(i, 10) == 1
%         tINlowThin(j) = tINlow(i);
%         Z2lowREALfiltThin(j) = Z2lowREALfilt(i);
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
% spectrogram(Z2lowREALfiltThin, window, noverlap, nfft, fs, 'yaxis');
% axis([0, 2, 0, 0.050]);
% grid on


% % resistance plot
% figure(1);
% plot(tOUTlow, Z2lowREALfilt/2e4, tOUTlow, vOUTlowRawfilt*1e3);
% set(gca,'fontname','Times New Roman');
% % plot(tINlow, capacitance);
% 
% % title('2016xxx##, impedance vs. time');
% xlabel('Time (s)');
% ylabel('Impedance (50 k\Omega), Voltage (mV)');
% axis([0, 120, -10, 15]);
% legend('Impedance', 'Voltage');


%% double axis plot
figure(1);
yyaxis left;
plot(tOUTlow, Z2lowREALfilt/1e3);
set(gca,'fontname','Times New Roman');
xlabel('Time (s)');
xlim([0 120]);
ylabel('Impedance (k\Omega)');
ylim([-250 250]);
set(gca, 'YTick', -250:125:250);

yyaxis right;
plot(tOUTlow, vOUTlowRawfilt*1e3);
ylabel('Voltage (mV)');
ylim([-10 10]);
set(gca, 'YTick', -10:5:10);
% legend('Impedance', 'Voltage');
% axis([0, 120, -10, 15]);

%% sliced up the data
tSlice = (0:tsOUTlow:40);


[cStart, indexStart] = min(abs(tOUTlow-20));
[cEnd, indexEnd] = min(abs(tOUTlow-30));
tIndex1 = (indexStart:indexEnd);
[cStart, indexStart] = min(abs(tOUTlow-50));
[cEnd, indexEnd] = min(abs(tOUTlow-60));
tIndex2 = (indexStart:indexEnd);
[cStart, indexStart] = min(abs(tOUTlow-80));
[cEnd, indexEnd] = min(abs(tOUTlow-90));
tIndex3 = (indexStart:indexEnd);
[cStart, indexStart] = min(abs(tOUTlow-110));
[cEnd, indexEnd] = min(abs(tOUTlow-120));
tIndex4 = (indexStart:indexEnd);

tIndexUsed = horzcat(tIndex1, tIndex2, tIndex3, tIndex4);
indexCount = numel(tIndexUsed);
tSlice = (0:(40/(indexCount-1)):40);

Z2Slice = Z2lowREALfilt(tIndexUsed);

vOUTSlice = vOUTlowRawfilt(tIndexUsed);


%% filter the sliced up data
N = 6;  % butterworth filter order
Cf = 60;  % cutoff frequency
Sf = 1 / timeStep;  % sampling frequency
Wn = Cf / (Sf / 2);  % normalized cutoff frequency
[D, C] = butter(N, Wn, 'low');  % butterworth filtering
Z2SliceFilt = filtfilt(D, C, Z2Slice);  % filtered amplitude
vOUTSliceFilt = filtfilt(D, C, vOUTSlice);


%% thin out the sliced up and filtered data
%pick 1 in every 10 data points
tSliceThin = [];
Z2SliceFiltThin = [];
vOUTSliceFiltThin = [];
j = 1;
for i = 1:1:length(tSlice)
    if mod(i, 100) == 1
        tSliceThin(j) = tSlice(i);
        Z2SliceFiltThin(j) = Z2SliceFilt(i);
        vOUTSliceFiltThin(j) = vOUTSliceFilt(i);
        j = j + 1;
    end
end


%% plot the sliced up and filtered data
figure(2);
yyaxis left;
plot(tSlice, Z2SliceFilt/1e3);
set(gca,'fontname','Times New Roman');
xlabel('Time (s)');
xlim([0 40]);
ylabel('Impedance (k\Omega)');
ylim([-50 200]);
set(gca, 'YTick', -50:50:200);

yyaxis right;
plot(tSlice, vOUTSliceFilt*1e3);
ylabel('Voltage (mV)');
ylim([-3 3]);
set(gca, 'YTick', -3:1:3);

