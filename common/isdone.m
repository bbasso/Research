function L = isdone(S,params)

% Returns a logical vector for for done tasks
% Rows are examples, columns are tasks
% In cost table, rows are agents, columns are tasks, third dim is example #


X = s2x(S,params);
cost_table = X.cost_table;
examples = size(X.cost_table,3);

% Loop over the number of examples given (3rd dim of cost table)
for n = 1:examples
    % Loop over agents
    for agent = 1:params.n
        joint_candidates(agent,:) = cost_table(agent,:,n)==1;
    end
    candidates(n,:) = any(joint_candidates);
end

L = logical(candidates);
