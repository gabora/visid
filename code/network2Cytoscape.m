%
% This file is part of the `VisId` MATLAB package
%
%  Copyright (c) 2016 - IIM-CSIC
%
%  File author(s): Attila Gabor (gabor.attila87@gmail.com)
%
%  Distributed under the GPLv3 License.
%  See accompanying file LICENSE.txt or copy at
%      http://www.gnu.org/licenses/gpl-3.0.html
%
%  Website: 
% --------------------------------------------------------
function network2Cytoscape(inputs,fname,id_params)
% export the model-network for Cytoscape based on analytic computation of the
% Jacobians. (export states, parameters (identifiable and non-identifiable parameters if given), inpouts and outputs) 

if nargin <3
    id_params = [];
end

% fill the inputs with the default values to avoid non-defined fields
if(isempty(which('AMIGO_Structs_PE.m')))
    fprintf(2,' Network2Cytoscape function requires AMIGO2 Toolbox. AMIGO_Structs_PE() was not found in the MATLAB path.\n\n')
    return
end
evalc('inputs = AMIGO_Structs_PE(inputs)');

% compute symbolic expressions of the Jacobians:
[stS,parS,algS,fsys,falg,dfdx,dfdp,dobsdx,dfdinp]=AMIGO_charmodel2syms(inputs,true,true,true,true);

n_ode = numel(stS);
n_par = numel(parS);


%% Parameteric senstivities of states
% convert Jacobian to numerical matrix.
Jpar= zeros(n_ode,n_par);

for i = 1:n_ode
    for j = 1:n_par
        %fprintf(1,'%d%d\n',i,j);
        if (dfdp(i,j)) == 0  % simplify
            Jpar(i,j) = 0;
        else
            Jpar(i,j) = 1;
        end
    end
end


from = {};
to = {};
type = {};
nInteraction = 0;

% sensitivity interaction
for i = 1:n_ode
    for j = 1:n_par
        if Jpar(i,j) == 1
            nInteraction = nInteraction +1;
            to{nInteraction}  = inputs.model.st_names(i,:);
            from{nInteraction} = inputs.model.par_names(j,:);
            type{nInteraction} = 'ps'; % parmeter to state
        end
    end
end

%% State to state interactions

Jst= zeros(n_ode,n_ode);

for i = 1:n_ode
    for j = 1:n_ode
        if (dfdx(i,j)) == 0  % simplify
            Jst(i,j) = 0;
        else
            Jst(i,j) = 1;
        end
    end
end

% state interactions
for i = 1:n_ode
    for j = 1:n_ode
        if Jst(i,j) == 1
            nInteraction = nInteraction +1;
            to{nInteraction}  = inputs.model.st_names(i,:);
            from{nInteraction} = inputs.model.st_names(j,:);
            type{nInteraction} = 'ss'; % parmeter to state
        end
    end
end


%% State sensitivities wrt Inputs:
n_inp = inputs.model.n_stimulus;

Jinp= zeros(n_ode,n_inp);

for i = 1:n_ode
    for j = 1:n_inp
        if (dfdinp(i,j)) == 0  % simplify
            Jinp(i,j) = 0;
        else
            Jinp(i,j) = 1;
        end
    end
end

% state interactions
for i = 1:n_ode
    for j = 1:n_inp
        if Jinp(i,j) == 1
            nInteraction = nInteraction +1;
            to{nInteraction}  = inputs.model.st_names(i,:);
            from{nInteraction} = inputs.model.stimulus_names(j,:);
            type{nInteraction} = 'si'; % state to input
        end
    end
end



%% State and observables

for iexp = 1:inputs.exps.n_exp
    n_obs = inputs.exps.n_obs{iexp};
    
    Jobs= zeros(n_obs,n_ode);
    
    for i = 1:n_obs
        for j = 1:n_ode
            if (dobsdx{iexp}(i,j)) == 0  % simplify
                Jobs(i,j) = 0;
            else
                Jobs(i,j) = 1;
            end
        end
    end
    
    % state-observables interactions
    for i = 1:n_obs
        for j = 1:n_ode
            if Jobs(i,j) == 1
                nInteraction = nInteraction +1;
                to{nInteraction}  = inputs.exps.obs_names{iexp}(i,:);
                from{nInteraction} = inputs.model.st_names(j,:);
                type{nInteraction} = 'os'; % observables to state
            end
        end
    end
end


network2file([fname, '_network.sif'],{},from,type,to);



%% Node Table
ids = cellstr(char(inputs.model.st_names, inputs.model.par_names));
for i =1:inputs.exps.n_exp
   ids = cellstr(char(ids{:},  inputs.exps.obs_names{i}));
end
if inputs.model.n_stimulus > 0
    ids = vertcat(ids,cellstr(inputs.model.stimulus_names));
end

if isempty(id_params)
    types = vertcat(repmat({'state'},size(inputs.model.st_names,1),1),...
        repmat({'param'},size(inputs.model.par_names,1),1),...
        repmat({'obs'},size(char(inputs.exps.obs_names{:}),1),1),...
        repmat({'input'},size(inputs.model.stimulus_names,1),1));
else
    % network contains all parameters from par_names, but identifiability
    % analysis is confied to id_global_theta. 
    [tf,loc] = ismember ( cellstr(inputs.PEsol.id_global_theta),cellstr(inputs.model.par_names));
    
    id_all_params = repmat({'non-estim param'},size(inputs.model.par_names,1),1);
    
    id_all_params(loc) = id_params;
    
    
    types = vertcat(repmat({'state'},size(inputs.model.st_names,1),1),...
        id_all_params,...
        repmat({'obs'},size(char(inputs.exps.obs_names{:}),1),1),...
        repmat({'input'},size(inputs.model.stimulus_names,1),1));
end
% ids = vertcat('name',ids);
% types = vertcat('type',types);

network2file([fname, '_node_table.txt'],{'name','type'},ids,types);

end

