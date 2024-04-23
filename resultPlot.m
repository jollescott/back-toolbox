function resultPlot(id, fit)
% RESULTPLOT    Displays the plot of the model fitness function for a
% previously saved result.
%   RESULTPLOT(ID,FIT) shows the plot of the model fitness function for a
%   previously saved result with ID. Disabling the FIT flag will show the
%   regular COMSOL model plot figure.

arguments
    id {mustBeNumeric} 
    fit {mustBeNumericOrLogical} = true
end

% Load and apply the parametrization to the Comsol model from a result.
comsolModel = loadAndApply(id,fit);
comsolModel.study('std1').run

if fit
    % Show the fitness function plot data.
    mphplot(comsolModel,'pgFit');
    xlabel('x [mm]');
    ylabel('y [mm]');
else 
    % Show the regular model plot view.
    mphplot(comsolModel);
end

end

