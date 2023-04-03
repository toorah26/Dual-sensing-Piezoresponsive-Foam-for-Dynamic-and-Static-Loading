%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   June 12, 2020
%   Resistance vs Strain for Through-Thickness Samples
%   Jakob Thygerson
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear, clc, close all

strain = [0
0.1
0.2
0.3
0.4
0.5
0.6
0.7];

L1 = [4230.518458
4235.368894
4598.142142
5107.627637
5669.720174
6503.740199
7056.628253
8726.762769]./1000;

L2 = [4057.164855
3777.630836
4113.840146
4564.307535
5206.957575
5985.465974
7158.090688
9036.616091]./1000;

L3 = [4286.094276
4107.89711
4334.308696
4927.264543
5721.431457
6571.526784
7796.2454
9597.075679]./1000;


g1 = [L1(1),L2(1),L3(1)];
std1 = std(g1);
g2 = [L1(2),L2(2),L3(2)];
std2 = std(g2);
g3 = [L1(3),L2(3),L3(3)];
std3 = std(g3);
g4 = [L1(4),L2(4),L3(4)];
std4 = std(g4);
g5 = [L1(5),L2(5),L3(5)];
std5 = std(g5);
g6 = [L1(6),L2(6),L3(6)];
std6 = std(g6);
g7 = [L1(7),L2(7),L3(7)];
std7 = std(g7);
g8 = [L1(8),L2(8),L3(8)];
std8 = std(g8);

means = [mean(g1) mean(g2) mean(g3) mean(g4) mean(g5) mean(g6) mean(g7) mean(g8)];

m = polyfit(strain',means,1);

fit = m(1).*strain+m(2);

figure, hold on
%title('Resistivity vs Strain for Through-Thickness Samples')
ylabel('Resistivity (MOhm-m)')
xlabel('Strain (mm/mm)')
xlim([-.03,.73])
set(gca,'fontname','Times New Roman');
set(gca,'fontsize',16);

%extreme line
plot([0 0], [min(g1), max(g1)],'--b','LineWidth',1)
plot([0.1 0.1],[min(g2), max(g2)],'--b','LineWidth',1)
plot([0.2 0.2],[min(g3), max(g3)],'--b','LineWidth',1)
plot([0.3 0.3],[min(g4), max(g4)],'--b','LineWidth',1)
plot([0.4 0.4],[min(g5), max(g5)],'--b','LineWidth',1)
plot([0.5 0.5],[min(g6), max(g6)],'--b','LineWidth',1)
plot([0.6 0.6],[min(g7), max(g7)],'--b','LineWidth',1)
plot([0.7 0.7],[min(g8), max(g8)],'--b','LineWidth',1)

%interquartile box
plot([0 0], [mean([max(g1),mean(g1)]), mean([min(g1),mean(g1)])],'-','LineWidth',8,'color',[.45,.65,.8])
plot([0.1 0.1], [mean([max(g2),mean(g2)]), mean([min(g2),mean(g2)])],'-b','LineWidth',8,'color',[.45,.65,.8])
plot([0.2 0.2], [mean([max(g3),mean(g3)]), mean([min(g3),mean(g3)])],'-','LineWidth',8,'color',[.45,.65,.8])
plot([0.3 0.3], [mean([max(g4),mean(g4)]), mean([min(g4),mean(g4)])],'-','LineWidth',8,'color',[.45,.65,.8])
plot([0.4 0.4], [mean([max(g5),mean(g5)]), mean([min(g5),mean(g5)])],'-','LineWidth',8,'color',[.45,.65,.8])
plot([0.5 0.5], [mean([max(g6),mean(g6)]), mean([min(g6),mean(g6)])],'-','LineWidth',8,'color',[.45,.65,.8])
plot([0.6 0.6], [mean([max(g7),mean(g7)]), mean([min(g7),mean(g7)])],'-','LineWidth',8,'color',[.45,.65,.8])
plot([0.7 0.7], [mean([max(g8),mean(g8)]), mean([min(g8),mean(g8)])],'-','LineWidth',8,'color',[.45,.65,.8])

%mean markers
w=0.01; %marker width
plot([0-w, 0+w],[mean(g1),mean(g1)],'-b','LineWidth',1)
plot([.1-w, .1+w],[mean(g2),mean(g2)],'-b','LineWidth',1)
plot([.2-w, .2+w],[mean(g3),mean(g3)],'-b','LineWidth',1)
plot([.3-w, .3+w],[mean(g4),mean(g4)],'-b','LineWidth',1)
plot([.4-w, .4+w],[mean(g5),mean(g5)],'-b','LineWidth',1)
plot([.5-w, .5+w],[mean(g6),mean(g6)],'-b','LineWidth',1)
plot([.6-w, .6+w],[mean(g7),mean(g7)],'-b','LineWidth',1)
plot([.7-w, .7+w],[mean(g8),mean(g8)],'-b','LineWidth',1)



%Extreme markers
%maximums
plot([0-w, 0+w],[max(g1),max(g1)],'-b','LineWidth',1)
plot([.1-w, .1+w],[max(g2),max(g2)],'-b','LineWidth',1)
plot([.2-w, .2+w],[max(g3),max(g3)],'-b','LineWidth',1)
plot([.3-w, .3+w],[max(g4),max(g4)],'-b','LineWidth',1)
plot([.4-w, .4+w],[max(g5),max(g5)],'-b','LineWidth',1)
plot([.5-w, .5+w],[max(g6),max(g6)],'-b','LineWidth',1)
plot([.6-w, .6+w],[max(g7),max(g7)],'-b','LineWidth',1)
plot([.7-w, .7+w],[max(g8),max(g8)],'-b','LineWidth',1)
%minimums
plot([0-w, 0+w],[min(g1),min(g1)],'-b','LineWidth',1)
plot([.1-w, .1+w],[min(g2),min(g2)],'-b','LineWidth',1)
plot([.2-w, .2+w],[min(g3),min(g3)],'-b','LineWidth',1)
plot([.3-w, .3+w],[min(g4),min(g4)],'-b','LineWidth',1)
plot([.4-w, .4+w],[min(g5),min(g5)],'-b','LineWidth',1)
plot([.5-w, .5+w],[min(g6),min(g6)],'-b','LineWidth',1)
plot([.6-w, .6+w],[min(g7),min(g7)],'-b','LineWidth',1)
plot([.7-w, .7+w],[min(g8),min(g8)],'-b','LineWidth',1)

