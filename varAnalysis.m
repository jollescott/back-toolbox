function varAnalysis(id)
% VARANALYSIS   Perform variability analysis on a saved optimization result.
%
%   VARANALYSIS(ID) runs variability analysis on result with id from
%   results.csv and saves it in analysis.csv.

% Load model name, parameter values & fitness score from results.csv.
[model, x, fit] = loadResultById(id);

% Load comsol model.
comsolmodel = mphload(model.comsolmodel);
model.init(comsolmodel);

% Determine parameter count.
n = sum(~isnan(x));

% Pre-allocate array
results = zeros(1,n);

% Analyze each parameter individually.
for i=1:n
    % Copy the parameter value array.
    cx1 = x;
    cx2 = x;

    % Vary the current parameter.
    cx1(i) = cx1(i)*1.05;
    cx2(i) = cx2(i)*0.95;

    % Fit the model to the changed parameter.
    y1 = model.fit(cx1,comsolmodel);
    y2 = model.fit(cx2,comsolmodel);
    y = (y1+y2)/2;

    % Save the procentual diff. in fitness score.
    results(i) = ((y-fit)/fit)*100;
end

% Calculate average & max
average = mean(results,2);
maxim = max(results);

% Load the old table and resize for new parameter count
oldtable = readtable('tables/analysis.csv');
[oldtable, results] = resizeTable(oldtable, results);

% Save the new result.
vars = [id average maxim results];
tableHeaders = ["Id"  "Mean" "Max" repmat("P", 1, length(results)) + (1:length(results)) ];
tableTypes = ["string" "double" "double" repmat("double",1,length(results))];

newTable = appendTable(oldtable,vars,tableTypes,tableHeaders);
writetable(newTable, 'tables/analysis.csv');

transposedTable = transposeTable(newTable);
writetable(transposedTable, 'tables/analysis_transposed.csv','WriteRowNames',true);

end