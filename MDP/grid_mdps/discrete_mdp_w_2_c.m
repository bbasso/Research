function [c] = discrete_mdp_w_2_c(w, mdp)

for a=1:mdp.nA
	c(:,a) = (w'*mdp.F{a})';
end


