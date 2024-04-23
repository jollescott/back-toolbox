function resultSaver(model, result)
% RESULTSAVER   Saves a optimization result to the results.csv file.
%   RESULTSAVER(MODEL,RESULT) Saves a new result to the results.csv file
%   for the MODEL class defined by the RESULT struct. RESULT struct is
%   expected to contain a parameter vector 'x', a fitness score 'fitness',
%   a population count 'npop', a generation count 'ngen' and a optimization
%   time in minutes 'time'.
% See also optimize, Model.

% Extract the parameters & fitness score.
x = result.x;
fitness = result.fitness;

% Base level content of results .csv
baseHeaders = ["Id" "Model" "FitnessFunc" "Fitness" "Population" "Generations" "Time" "selectionFcn" "Comment"];
baseTypes = ["double" "string" "string" "double" "double" "double" "double" "string" "string" ];

% Read the previous table
oldTable = readtable('back/results.csv');

% Resize the table to account for a increased parameter account with new
% result.
[oldTable,x] = resizeTable(oldTable, x);

% Build table headers and column types.
tableHeaders = [baseHeaders repmat("P", 1, length(x)) + (1:length(x))];
tableTypes = [baseTypes repmat("double",1,length(x))];

% Values being added.
modelClassName = convertCharsToStrings(class(model));
fitnessFuncName = func2str(model.fitnessFunc);
id = max(oldTable.Id) + 1;
vars = [id modelClassName fitnessFuncName fitness result.npop result.ngen result.time "selectionstochunif" "" x];

% Create new row.
newTable = appendTable(oldTable,vars,tableTypes,tableHeaders);

% Sort and save new table.
newTable = sortrows(newTable, ["FitnessFunc","Fitness"]);
writetable(newTable, 'back/results.csv')

disp("Saved result for id: " + id);

end