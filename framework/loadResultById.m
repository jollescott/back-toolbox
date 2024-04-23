function [model, x, fit] = loadResultById(id)
% LOADRESULTBYID  Loads a previously stored result from 'results.csv'.
%   [MODEL,X,FIT] = LOADRESULTBYID(ID) Loads an initialized Model object,
%   the stored parameter vector X and the stored fitness scored associated
%   with id ID.
%   
%   See also Model.

    % Read the result table from .csv
    results = readtable('back/results.csv');
    % Find the matching row index.
    rowIndex = results.Id == id;
 
    % Read the row data
    row = results(rowIndex, :);
    % Read the fitness score.
    fit = row.Fitness;
    % Extract the headers, find start & end column index for parameters.
    headers = row.Properties.VariableNames;
    paramsStart = find(headers == "P1");
    paramsEnd = width(row);

    % Extract the model and fitness function names.
    modelName = row.Model{1,1};
    fitnessFunc = row.FitnessFunc{1,1};

    % Initialize a new instance of the Model object.
    model = eval(modelName);
    % Create function handle from fitness function name.
    model.fitnessFunc = str2func(fitnessFunc);
    
    % Extract the parameter vector
    x = table2array(row(1, paramsStart:paramsEnd));
end