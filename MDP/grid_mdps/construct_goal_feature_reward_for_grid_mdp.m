function [r, F, nF, w] = construct_goal_feature_reward_for_grid_mdp(mdp, goal_states, w)

%% assign costs

mdp.nF = length(goal_states);
mdp.w = w;

%% use state features for costs:
for a=1:mdp.nA
	F{a} = zeros(mdp.nF, mdp.nS);
end

for f=1:mdp.nF
	s = goal_states(f);
	for a = 1:mdp.nA
			F{a}(f,s) = 1;
	end
end


w = w;

mdp.F = F;
r = discrete_mdp_w_2_c(mdp.w, mdp);

nF = mdp.nF;



