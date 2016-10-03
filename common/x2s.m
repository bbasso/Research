function [s,x,params] = x2s(x,params)

%% Error Checking: Did you define the correct number of tasks/agents
if size (x.agent.pos,1) ~= params.n
    disp('ERROR: Incorrect number of agents')
    return
end
if size (x.tasks.pos,1) ~= params.m
    disp('ERROR: Incorrect number of tasks')
    return
end

donetasks = params.donetasks;
donetable = params.donetable;
%% Loop over agents (rows), than tasks (cols) to find range/bearing to tasks
%
for n = 1:params.n
    for m = 1:params.m
        [x.ber(n,m), x.range(n,m)] = cart2pol(x.tasks.pos(m,1)-x.agent.pos(n,1), x.tasks.pos(m,2)-x.agent.pos(n,2));
    end
end

% Saturation: If agent outsite max_range, range = max_range
if any(any(x.range  > params.max_range))
   if params.debug disp('DEBUG: Warning, agent out of range');end
   x.range(find(x.range>params.max_range))=params.max_range;
end

% Calculate costs
% x.tasks.cost = (params.c-1).*x.range./params.max_range + 1; % normalized range
% x.tasks.cost = params.c*x.range./params.max_range + .5;
x.tasks.cost = params.c*x.range./params.max_range;

agent_state = x.agent.state;
% cost_table = round(x.tasks.cost);
cost_table = ceil(x.tasks.cost);

%% Check cost table to see if there are any (newly) done tasks
% If so set their cost to 1 (ie. done)
%
for agent = 1:params.n
    joint_candidates(agent,:) = cost_table(agent,:)==1;
end

donetable = or(donetable,joint_candidates);

candidates = any(joint_candidates);
newdone = find(candidates);
if any(candidates)
    cost_table(:,newdone)=1;
end
% Check (old) donetasks vector for previously done tasks
% Set those tasks' cost to 1
if any(donetasks)
    for agent = 1:params.n;
        cost_table(agent,find(donetasks)) = 1;
    end
end
cost_state = reshape(cost_table',params.m*params.n,1);

%% Finally, merge candidates with donetasks
%
params.donetasks = or(candidates,donetasks);
params.donetable = donetable;
s = subtoind(params.sdim,[agent_state;cost_state]);










