% clear all;
clc;

filename = 'materials database 2015Apr28.xlsx';
sheet = 'data';
num = xlsread(filename,sheet);

figure
set(gca,'fontname','Times New Roman');
hold on
set(gca,'XDir','Reverse')
set(gca,'XScale','log');
set(gca,'YScale','log');
scatter(num(:,3),num(:,1),'^');%,'.r');

labels = cellstr( num2str([1:10]') );  %' # labels correspond to their order

text(num(:,3), num(:,1), labels, 'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','right')

scatter(num(:,7), num(:,5),'o');%,'.b');

labels = cellstr( num2str([1:10]') );  %' # labels correspond to their order

text(num(:,7), num(:,5), labels, 'VerticalAlignment','top', ...
                             'HorizontalAlignment','right')


scatter(num(:,11), num(:,9),'x');%,'.g');

labels = cellstr( num2str([1:10]') );  %' # labels correspond to their order

text(num(:,11), num(:,9), labels, 'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','left')


axis([.1, 10000000000, 0.0001, 1]);
% title('Voltage vs. Conductivity, 3 Base Polymers');
xlabel('Conductivity (S)');
ylabel('Voltage (V)');
legend('Polyurethane','Silicone','Latex');