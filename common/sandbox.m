clear all
close all

t1 = 0
t2 = 0

[X,Y] = meshgrid(-5:.1:5,-5:.1:5);
Z = (X-t1).^2+(Y-t2).^2;
[C,h] = contour(X,Y,Z,[1:5].^2);
% set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
clabel(C,'DisplayName','booyah')
set(h,'DisplayName','booyah')
colormap cool;

axis equal
grid on
