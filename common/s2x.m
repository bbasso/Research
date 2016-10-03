function [X] = s2x(S,params)

% Converts integer-valued state number to full-blown world state
% Cost table is reshaped cost state, with agents as rows, tasks as columns,
% and third dimension if S is bigger than 1 example

X.X = indtosub(params.sdim,S)';
X.agent_state = X.X(:,1:params.n);
X.cost_state = X.X(:,params.n+1:end);

for i = 1:size(X.cost_state,1)
    X.cost_table(:,:,i) = reshape(X.cost_state(i,:),params.m,params.n)';
end