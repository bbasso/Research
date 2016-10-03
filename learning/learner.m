classdef learner
    properties
        type
        Q
        policy
        agent
        n
        episodes
        worldsize
    end
    methods (Abstract)
        action = select_action(obj,state)
        newstate = take_action(obj,state,action)
        update_valfun(obj,state,new_state,action,new_action)
        [obj rundata] = learn(obj)
    end
    methods
        % define a learn method Q = learn()
        % regular member functions go here
    end
    methods (Static)
        % functions that acces protected class data here
    end
end