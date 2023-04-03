clear all;

%% data mining
% oldFolder = cd('volt_data');
% load 2016jan26_instronCycle125-2_latex_data.mat
% d2 = dataCell;
% ts2 = timeStep;
% cd(oldFolder);
% 
% t2 =(0:ts2:ts2*(length(d2{1,1})-1));
% v2 = d2{1, 1};

%vel_index = zeros(length(v2))';

% for j = 1:length(v2)
%     if v2(j,1) < 0
%         sq2(j,1) = -2.855;
%     else
%         sq2(j,1) = 2.745;
%     end
% end
% 
load('t2.mat');
load('v2.mat');
load('sq2.mat');
dcnvlv2 = v2-sq2;

% for i=1:end
%     if v2[i]>1 && v2[i-1]<1
%         table = (v2(i+30)+v2(i+60)/2)
%     elseif
%         v2(i)>1 && v2(i+1)>1
%         filt(i)=table
%     else
%     end
        


[v2peaks, v2peakLocs] = findpeaks(v2,t2,'Annotate','extents','minpeakdistance',0.003);



%% plotting
%plot(t2,v2,t2,dcnvlv2);
set(gca,'fontname','Times New Roman');
set(gca,'fontsize',16);
plot(t2,dcnvlv2);
% legend('raw','difference');
% title('latex foam with conductive fabric, instron cycling, 0.125-2 Hz, 2016jan28');
xlabel('Time (s)');
ylabel('voltage (V)');
