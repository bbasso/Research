classdef agent
    properties
        vel % no default value
        goalstate % no default value
        nS
        nA
        r
    end
    methods (Abstract)
        newstate = move(obj,state,action)
    end
    methods
        % regular member functions go here
    end
    methods (Static)
        % functions that acces protected class data here
    end
end