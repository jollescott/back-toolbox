function comsolModel = loadAndApply(id, init)
% LOADANDAPPLY  Loads a previously saved result and applies the parameters
% to a model instance of the Model associated with the result.
%   COMSOLMODEL = LOADANDAPPLY(ID,INIT) Loads the previously saved result
%   with id ID and returns a comsol model handle COMSOLMODEL with the saved
%   parameters applied. If INIT flag is set then the model init overload
%   will be invoked with COMSOLMODEL as argument.
%   
%   See also loadResultById.

    arguments
        id {mustBeNumeric}
        init {mustBeNumericOrLogical} = true
    end

    % Load the previosuly saved result
    [model, x, ~] = loadResultById(id);

    % Load comsol model.
    comsolModel = mphload(model.comsolmodel);
    
    if init
        % Run model init logic if flag is set (important for inlet fork
        % models since it sets the appropriate fitness function)
        model.init(comsolModel);
    end

    % Apply the model parameters.
    model.applyParams(x, comsolModel);
end

