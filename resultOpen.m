function resultOpen(id)
% RESULTOPEN    Opens COMSOL Multiphysics and loads a model with an applied
% parametrization from a previously saved result.
%   RESULTOPEN(ID) opens model pointed to from the Model subclass of the
%   result with ID and applies the parametrization stored as part of the
%   result.
    comsolModel = loadAndApply(id);
    mphlaunch(comsolModel);
end

