classdef qlearner < learner
% Derived class
    properties
        e % no default value
        gamma % no default value
        lambda % no default value
        episilon % no default value
        alpha % no default value
    end
    methods
        function obj = qlearner(params,agent)
            obj.type = 'Q';
            obj.n = 1;
            obj.worldsize = params.worldsize;
            obj.episodes = params.episodes;
            % Agent Parameters
            obj.agent.vel = params.agent_vel;
            obj.agent.goalstate = params.agent_goalstate;
            obj.agent.pfail = params.agent_pfail;
            obj.agent.nS = [];
            obj.agent.nA = [];
            % Learning parameters
            obj.alpha = params.alpha;
            obj.episilon = params.episilon;
            obj.gamma = params.gamma;
            obj.lambda = params.lambda;
            if strcmp(agent, 'simpleagent')
                obj.agent.nS = params.worldsize;
                obj.agent.nA = params.nA;
                obj.agent = simpleagent(obj.agent);
                obj.e = zeros(params.nS,params.nA);
                obj.Q = zeros(params.nS,params.nA);
                obj.policy = ones(params.nS,1);
            elseif strcmp(agent, 'gridagent')
                obj.agent.nS = params.worldsize^2;
                obj.agent.nA = params.nA;
                obj.agent = gridagent(obj.agent);
                obj.e = zeros(params.worldsize^2,params.nA);
                obj.Q = zeros(params.worldsize^2,params.nA);
                obj.policy = ones(params.worldsize^2,1);
            end
            
        end
        
        function [l rundata] = learn(l)
            nS = l.agent.nS;
            nA = l.agent.nA;
            goal = l.agent.goalstate;
            episodes = l.episodes;
            UQ = [];
            nstepsQ = [];
            lcurve = [];

            for ep = 1:episodes
                clear s t act V policy delta e
                t=1; 
                s(1) = randint(1,1,[1 l.agent.nS]);
                act(1) = l.select_action(s(1));
                l.e = zeros(nS,nA);
                while s(t)~=goal
                    s(t+1) = l.take_action(s(t),act(t));
                    act(t+1) = l.select_action(s(t+1));
                    l = l.update_valfun(s(t),s(t+1),act(t),act(t+1));
                    if s(t)==goal
                        disp(['Episode ',num2str(ep),' ended in ',num2str(t), ' steps...thank you for playing'])
                    end
                    t = t+1; %time inside each episode
                    l.n = l.n+1; %iterations
                end
                lcurve = [lcurve;ep,l.n,t];

                if(mod(ep,25) == 1)
                    [v policy] = max(l.Q,[],2);
                    H = 10*ceil(1/(1-l.gamma));
                    UQ = [UQ policy_evaluation(l.agent.mdp, policy, H)];
                    nstepsQ = [nstepsQ l.n];
                    grid_visualize_policy_and_cost(l.worldsize,policy,l.agent.mdp.r);
                end
            end
            rundata.UQ = UQ;
            rundata.nstepsQ = nstepsQ;
            rundata.lcurve = lcurve;
        end

        function act = select_action(obj,s)
            nA = obj.agent.nA;
            if (obj.episilon > rand) && (any(obj.Q(s,:)));
                 [V, act] = max(obj.Q(s,:));
            else
                act = randint(1,1,[1 nA]);
            end
        end

        function sp = take_action(obj,s,a)
            sp = obj.agent.move(s,a);
        end

        function obj = update_valfun(obj,s,sp,a,ap)
            Q = obj.Q;
            r = obj.agent.mdp.r;
            nA = obj.agent.nA;
            nS = obj.agent.nS;
            [V astar] = max(Q(sp,:));
            delta = r(sp) + obj.gamma*Q(sp,astar) - Q(s,a);
            obj.e(s,a) = obj.e(s,a) + 1;
%             alpha = obj.alpha;
            alpha = 100/(100+obj.n);
            for i = 1:nS
                for j = 1:nA
                    obj.Q(i,j) = obj.Q(i,j) + alpha*delta*obj.e(i,j);
                    if astar == ap
                        obj.e(i,j) = obj.gamma*obj.lambda*obj.e(i,j);
                    else
                        obj.e(i,j) = 0;
                    end
                end
            end
        end
    end
end


    
    