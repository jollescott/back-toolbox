function [table, x] = resizeTable(table, x)
% RESIZETABLE   Resizes the parameter column group to either add new
% columns if the new result has more parameters or pad the new result with 
% "" to match the current column count.
%   [TABLE,X] = RESIZETABLE(TABLE,X) Takes the original table TABLE and
%   parameter vector X, returns a modified TABLE with added parameter
%   columns or modified parameter X vector padded with whitespace.

% Load old table headers
oldHeaders = table.Properties.VariableNames;

% Find the table parameter count difference
% "nRep = orignal table width - new result parameter count - origignal table
% parameter count"
nRep = width(table) - length(x) - find(oldHeaders == "P1") + 1;

if (nRep < 0)
    % More parameters in new results. Fill in old table with NaN
    for i = 1:abs(nRep)
        % Generate new column name P1, P2, P3, PN, PN+i
        hName = "P" + (i + nRep + length(x));
        % Generate new NaN column for the old results.
        table.(hName) = NaN(height(table), 1);
    end
else
    % Less parameters than max in new results. Pad with whitespace.
    x = [x repmat("", 1, nRep)];
end

end