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
inputs.nlpsol.eSS.local.nl2sol.maxfeval = 300;


%======================================
% RIDGE REGULARIZATION
%======================================
inputs.nlpsol.regularization.ison = 1;
inputs.nlpsol.regularization.method = 'tikhonov';
inputs.nlpsol.regularization.plotflag = 0;
inputs.nlpsol.regularization.tikhonov.gW = eye(numel(inputs.PEsol.global_theta_guess));
inputs.nlpsol.regularization.tikhonov.gx0 = inputs.PEsol.global_theta_min;
inputs.nlpsol.regularization.alphaSet = logspace(10, -5,16);

