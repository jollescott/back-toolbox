function resultGeom(id, compare)
% RESULTGEOM    Plot the model geometry of a previously saved result.
%   RESULTGEOM(ID,COMPARE) plots the geometry of a previouslt saved result
%   with ID in the database. Setting the COMPARE flag will display the
%   geometry in a new figure.
%
%   See also loadAndApply, mphgeom.
    arguments
        id (1,1) {mustBeNumeric}
        compare (1,1) {mustBeNumericOrLogical} = false
    end

    if compare 
        % Create a new figure if we want to compare results.
        figure
    end

    % Load the previously saved result.
    comsolModel = loadAndApply(id);
    % Plot the geometry.
    mphgeom(comsolModel);

    xlabel('x [mm]');
    ylabel('y [mm]');
end

