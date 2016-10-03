function [r, F, nF, w] = construct_random_feature_reward_for_grid_mdp(mdp, nF, w)

%% assign costs

%% use state features for costs:
for a=1:mdp.nA
	F{a} = zeros(nF, mdp.nS);
end

for s=1:mdp.nS
	for f=1:nF
		fval = rand;
		for a = 1:mdp.nA
			F{a}(f,s) = fval;
		end
	end
end

mdp.F = F;
mdp.nF = nF;

r = discrete_mdp_w_2_c(w, mdp);


