classdef gridagent < agent
% Derived class
    properties
        mdp % no default value
        pfail % no default value
        discount % no default value
    end
    methods
        function obj = gridagent(params)
            obj.vel = params.vel;
            obj.goalstate = params.goalstate;
            obj.pfail = params.pfail;
            obj.nS = params.nS;
            obj.nA = params.nA;
            discount = 1;
            obj.mdp = construct_grid_mdp_no_reward((obj.nS)^.5, obj.pfail, discount);
            [obj.mdp.r, obj.mdp.F, obj.mdp.nF, obj.mdp.w] = construct_goal_feature_reward_for_grid_mdp(obj.mdp, obj.goalstate, 1);
        end

        function sp = move(obj,s,a)
            % Execute action, observe (stochastic) outcome:
            r = rand;
            nz = nonzeros(obj.mdp.P{a}(s,:));
            states = find(obj.mdp.P{a}(s,:));
            bin = nz(1);
            if length(nz) > 1
                for j = 2:length(nz)
                    bin(j) = nz(j) + bin(j-1);
                end
                for k = 1:length(nz)
                    if r < bin(k)
                        break
                    end
                end
            else
                k=1;
            end
            sp = states(k);
        end
    end
end


    
    