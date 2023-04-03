%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   June 12, 2020
%   Resistance vs Strain for Line Gap Samples
%   Jakob Thygerson
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear, clc, close all

strain = [3.33333E-05
0.1001
0.200011111
0.300204762
0.4004
0.500666667
0.600666667
0.700766667];

L1 = [15590.60227
13768.46584
12580.76082
11316.39183
9673.414855
7654.39451
5548.502249
4027.242214]./1000;

L2 = [10361.88604
9171.44767
8232.067685
7499.563702
6655.521517
5580.646873
4362.371831
3220.694715]./1000;

L3 = [10363.29657
8741.679425
7586.214881
6935.808875
6151.655671
5183.325144
4084.64955
3033.160889]./1000;


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
ylabel('Resistance (MOhm)')
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

%fit line
plot(strain,fit,'r')
