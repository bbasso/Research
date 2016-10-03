function [] = plot_num_label()
% Demo shows how to label lines with numbers.
figure('pos',[560 528 560 420])
y1 = @(x) -1*sin(x); % Functions to plot.
y2 = @(x) 4*sin(x);
y3 = @(x) 8*sin(x);

x2 = 7.1; % Where the label will go.

x = 0:.001:10; % Plot the functions.
plot(x,y1(x),x,y2(x),x,y3(x));
hold on
title('Asin(x)','fonts',16,'fontw','b')
ln = plot(x2,y1(x2),x2,y2(x2),x2,y3(x2)); % Another 'line' for markers. 
set(ln(:),'marker','o','markers',24,'markerf','w','lines','no',...
    'markere','w')
t(1) = text(x2-.325,y1(x2)+.3,'A = 1','col',get(ln(1),'color'),'rot',-18);
t(2) = text(x2-.225,y2(x2)-.7,'A = 4','col',get(ln(2),'color'),'rot',50);
t(3) = text(x2-.15,y3(x2)-.75,'A = 8','col',get(ln(3),'color'),'rot',63);
set(t(:),'fontw','b')
ylim([-9 9])
xlim([0 10])