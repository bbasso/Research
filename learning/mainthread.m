% Main approximator test thread
clear all
close all
clc

dir = 'C:\Users\BrandonNew\Documents\MATLAB\Research\learning';
if strcmp(dir,pwd) ~= 1
    cd(dir);
    pwd
end

addpath ../MDP
addpath ../MDP/grid_mdps

% Agent Init
params.worldsize = 10;
params.nA = 5;
params.agent_vel = 1;
params.agent_goalstate = 5;
params.agent_pfail = .01;

% Learning initialization
params.episodes = 200;
params.alpha = .9;
params.episilon = .5;
params.gamma = .99;
params.lambda = 0;


% Function Approximation initialization
order = 2;
theta = zeros(1,order);

%%

% lambda =  linspace(0,1,5);
% lambda = params.lambda;
lambda = [0,0.5,1]
for i = 1:length(lambda)
    clear l
    close all
    params.lambda = lambda(i);
    l = qlearner(params,'gridagent')
%     l = sarsalearner(params,'gridagent')
    [ll rd(i)] = l.learn()
    leg{i} = ['\lambda=',num2str(lambda(i))];
end

%% Ploting
close all

b = 1/(5)*ones(1,5);
a = 1;

%%% Utility %%%
figure;
for j = 1:length(lambda)
    plot(rd(j).nstepsQ, rd(j).UQ, 'LineWidth',2);
    hold all
end
title([l.type,' learner Utility']);
xlabel('Iterations');
ylabel('Utility');
legend(leg)

% TODO: just added a column to rd.lcurve - sort out how to use it below

%%% Learning Curve %%%
figure
for j = 1:length(lambda)
%     xdata = rd(j).lcurve(:,2);
    xdata = (1:params.episodes)'
    ydata = rd(j).lcurve(:,3);
    yfilt = filter(b,a,ydata);
    P = polyfit(xdata,ydata,2);
    yfit = polyval(P,xdata);
    yexp = fit(xdata,ydata,'exp1');
    
    subplot(2,2,1)
    plot(xdata,yfilt,'LineWidth',2);
    hold all
    legend(leg)
    
    subplot(2,2,2)
    plot(xdata,yfit,'LineWidth',2);
    hold all
    legend(leg)
    
    subplot(2,2,3)
    plot(yexp,xdata,ydata)
    hold all
    legend(leg)
    
    subplot(2,2,4)
    plot(xdata,ydata,'-')
    hold all
    legend(leg)
end
grid on
title([l.type,' Learning Curve']);
xlabel('Iterations');
ylabel('Episode Length');
legend(leg)
