function newTable = appendTable(oldTable,vars,types,headers)
% APPENDTABLE   Appends a new row to a table.
%   NEWTABLE = APPENDTABLE(OLDTABLE, VARS, TYPES, HEADERS) Appends a new
%   row to OLDTABLE and returns the new table as NEWTABLE. VARS is expected
%   to be a vector containing the row values, TYPES a vector of the same
%   length with datatype for each column & HEADERS a vector of the same
%   length with the headers names for the columns.
%
%   See also resultSaver.

% Create a new table row.
newRow = table('Size', [1 width(oldTable)], 'VariableTypes', types, 'VariableNames', headers);
% Assign the new table row data.
newRow(1,:) = num2cell(vars);

% Append the new row to the old table.
newTable = [newRow;oldTable];

end

