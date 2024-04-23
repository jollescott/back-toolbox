function queue(nw,varargin)
% QUEUE Utility function for queing multiple optimizations in serial.
%   QUEUE(NW,MODEL1,NPOP1,NGEN1,MODEL2,NPOP2,NGEN2,..,..,..) first
%   executes an optimization for MODEL1 with a population count of NPOP1
%   for NGEN1 generations, then an optimization for MODEL2 etc.
%
%   See also optimize.

    % Extract the variable input arguments
    models = varargin(1:3:end);
    populations = varargin(2:3:end);
    generations = varargin(3:3:end);

    % Check that the correct amount of arguments have been given. 
    modelsLength = length(models);
    totalLength = length(models) + length(populations) + length(generations);

    if totalLength == 3 * modelsLength
        % Execute each optimization one at a time.
        for i = 1:modelsLength
            optimize(models{i},populations{i},generations{i},nw);
        end
    else
        error("Models, populations & generations do not match in number");
    end
end

