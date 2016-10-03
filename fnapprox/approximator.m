classdef approximator < handle
% Abstract class for creating general function approximators
% Subclasses: linear, nolinear
% Would like to include td(), kanerva, gaussian processes
    properties (SetAccess = protected, GetAccess = protected)
        %protected class data
    end
    properties %public
        fun
        params
        evalpts
    end
    methods (Abstract)
        updateParams(params)
        values = evalFun(fun,params,evalpts)
    end
    methods
        %regular member functions go here
    end
    methods (Static)
        % functions that acces protected class data here
    end
end