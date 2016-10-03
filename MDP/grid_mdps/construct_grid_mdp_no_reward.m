function [mdp] = construct_grid_mdp_no_reward(n, q, gamma_in)

% generate an n by n grid MDP, with action failure probability q

mdp.nS = n*n;
mdp.nA = 5;

% transition model:
for i=1:5
	mdp.P{i} = sparse(n*n,n*n);
end

% initial state distribution
mdp.d = ones(n*n,1)/(n*n);


% action 1 = stay in place
% action 2 = north, action 3 = east, action 4 = south, action 5 = west

for start_i=1:n
	for start_j=1:n
		start_idx = grid_ij2idx(start_i,start_j,n);
		result_i(2) = start_i;
		result_j(2) = min(start_j+1,n);
		result_i(3) = min(start_i+1,n);
		result_j(3) = start_j;
		result_i(4) = start_i;
		result_j(4) = max(start_j-1,1);
		result_i(5) = max(start_i-1,1);
		result_j(5) = start_j;

		for k=2:5
			result_idx(k) = grid_ij2idx(result_i(k),result_j(k),n);
		end

		for k=2:5
			for l=2:5
				if(k==l)
					inc_p = 1-q;
				else
					inc_p = q/3;
				end
				mdp.P{k}(start_idx, result_idx(l)) = mdp.P{k}(start_idx, result_idx(l)) + inc_p;
			end
		end

	end
end

for s=1:length(mdp.P{1})
	mdp.P{1}(s,s) = 1;
end




mdp.gamma = gamma_in;











