function [s,x,params,handles] = init_smdp()

params.debug = 0;
params.m = 2; % Number of tasks
unalloc = params.m+1;
params.n = 2; % Number of agents
params.c = 5; % Number of cost levels (remember cost = 1 == donestate)
params.w = 1; % multiplying factor on goalstate reward
% params.p_fail = .01; % probability of not following the desired state-action transition
params.sdim(1:params.n) = params.m+1;
params.sdim(params.n+1:params.n + params.m*params.n) = params.c;
params.adim(1:params.n) = params.m+1;
params.donetasks = zeros(1,params.m);
params.map = imread('Baghdad.bmp');
[params.heli.cdata, params.heli.cmap, params.heli.alpha]  = imread('PT-BlackCopterDoc-01t.png');
[params.task.cdata, params.task.cmap, params.task.alpha]  = imread('PT-freakbaum-01t.png');
handles = 0;

% Build the world
params.worldsize = 2;                                 % 2n x 2n grid centered at 0
params.max_range = 2*2^.5*params.worldsize;           % the board diagonal (the furthest 2 points could be)
x_start.tasks.pos = [-2,-2;2,2];                   % cartesian positions
% x_start.tasks.pos = [-2,-2;2,2;-2,2];
x_start.agent.pos = [0,0;0,-1];                       % cartesian positions
x_start.agent.state = (params.m+1)*ones(params.n,1);  % unallocated

[s(1),x(1),params] = x2s(x_start,params);
% h = draw_world(x(1), params, map,handles);