%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the modification of the AMIGO implementation of benchmark B2     
%
% for the modifications read the code below. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



b2_amigo;
% record random seed:
inputs.randstate = sum(100*clock);
rand('state',inputs.randstate);
randn('state',inputs.randstate);

%=======================================
% PATHS RELATED DATA 
%=======================================
inputs.pathd.results_folder	= 'b2';
inputs.pathd.short_name		= 'b2';
%========== Extra =========
inputs.model.AMIGOjac = 0;
inputs.model.AMIGOsensrhs=1;    % use the sens right hand sides
                                
inputs.PEsol.PEcostjac_type = 'llk';  % compute the Jacobian based on sens. 

%=======================================
% OPTIMIZATION settings
%=======================================
inputs.nlpsol.eSS.local.solver = 'nl2sol';
inputs.nlpsol.eSS.local.finish = 'nl2sol';
