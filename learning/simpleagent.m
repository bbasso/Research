classdef simpleagent < agent
% Derived class
    properties

    end
    methods
        function obj = simpleagent(params)
            obj.vel = params.vel;
            obj.goalstate = params.goalstate;
            obj.nS = params.nS;
            obj.nA = params.nA;
            obj.r = zeros(1,obj.nS);
            obj.r(obj.nS) = 1;
        end

        function sp = move(obj,s,a)
            if (a==1) && (s~=1) && (s~=obj.goalstate)
                sp = s-1;
            elseif (a==1) && (s==1)
                sp = s;
            elseif (a==2) && (s~=obj.goalstate)
                sp = s+1;
            elseif (s==obj.goalstate)
                sp = s;
            end
        end
    end
end


    
    