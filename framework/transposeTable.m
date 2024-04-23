function table = transposeTable(table)
%   TRANSPOSETABLE  Switches rows and columns for a given table.
%   TABLE = TRANSPOSETABLE(TABLE) Switches the rows and columns for the
%   given TABLE table and returns the modified table.

% Convert original table to array
tableArray = table2array(table);
% Create table from tranposed array.
transposedTable = array2table(tableArray.');
% Switch row and column/variable names.
transposedTable.Properties.RowNames = table.Properties.VariableNames;
table = transposedTable;
end

