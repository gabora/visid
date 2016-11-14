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
% maximum identifiable parameter selection with MEIGO
function [id_subset] = locally_identifiable_subset(Rjac_rel,collinearity_threshold)

% load relative sensitivity:
% load b2_for_subset


if nargin<2 || isempty(collinearity_threshold)
    collinearity_threshold = 20;
end
%
parameter_order = 1:size(Rjac_rel,2);

%%
% Importance Indices by mean square sensitivity
for i = 1:size(Rjac_rel,2)
    msqrS(i) = norm(Rjac_rel(:,i)); 
end

% rank the parameters by importance
[t,prank_msqrS] = sort(msqrS,'descend');

% find a threshold value: 0.01% of the max
threshold_index = find(t<t(1)*1e-4,1);
if isempty(threshold_index)
    threshold_index = numel(t);
end

% select sensitivities of parameters with relevant influence on outputs:
S  =  Rjac_rel(:,prank_msqrS(1:threshold_index));


optimized_parameters = parameter_order(prank_msqrS(1:threshold_index));
non_optimized_parameters = parameter_order(prank_msqrS(threshold_index+1:end));

% note that the parameters are also ordered according to their msqrS

%%
% norm the columns
nS = S;
for i=1:threshold_index
    nS(:,i) = S(:,i)/norm(S(:,i));
end

%% QR
% initialize the sensitivity matrix with Rank-revealing QR factorization:
if(isempty(which('rrqr.m')))
    error('locally_identifiable_subset function requires the Rank-Revealing QR decomposition. rrqr() was not found in the MATLAB path.')
end
[Q,R,p,r] = rrqr(nS);

% MATLAB QR:
% [Q,R,E] = qr(nS);
% t = 1:size(E,1);
% p = t*E;
% reorder the sensitivity matrix such that the first columns are preferred
ranked_nS =nS(:,p);
[~, invp] = sort(p);
optimized_parameters = optimized_parameters(p);


subsetguess = 1;
for i = 1:size(ranked_nS,2)
    colin = 1/min(svd(ranked_nS(:,1:i)));
    if colin > collinearity_threshold
        subsetguess = i-1;
        colin = 1/min(svd(ranked_nS(:,1:i-1)));
        fprintf('initial guess:\n')
        fprintf('n subset: %d\n',subsetguess)
        fprintf('colinearity: %g\n',colin)
        break
    end
end

%% Binary optim


nvar = numel(optimized_parameters);

problem.f=@objective;           
problem.x_L= zeros(1,nvar);
problem.x_U= ones(1,nvar);
problem.x_0= [ones(1,subsetguess) zeros(1,nvar-subsetguess)]; 
opts.maxeval=20000; 
opts.maxtime = 600;
problem.bin_var = nvar;
col_threshold = collinearity_threshold;

if(isempty(which('MEIGO.m')))
    error('locally_identifiable_subset function requires the MEIGO Toolbox. MEIGO() was not found in the MATLAB path.')
end
[Results] = MEIGO(problem,opts,'VNS',ranked_nS,col_threshold);

% s
id_subset = optimized_parameters(logical(Results.xbest));


% check the solution:

nelement = sum(Results.xbest);

opt_collinearity = 1/min(svd(ranked_nS(:,logical(Results.xbest))));
        fprintf('optimal value:\n')
        fprintf('n subset: %d\n',nelement)
        fprintf('colinearity: %g\n',opt_collinearity)
 

end

function obj = objective(x, S,col_threshold)
% minimize the number of non-selected variables and add penalty for
% colinearity

% number of non-selected:
n_unselected = sum(x<0.5);

% collinearity:
s = svd(S(:,logical(x)));
collinearity  = 1/min(s);

% linear penalty until the threshold. 
penalty = 0.5*collinearity/col_threshold;
% quadratic penalty from the threshold. 
if collinearity > col_threshold
    penalty = penalty + (collinearity-col_threshold)^2;
end
    
obj = n_unselected + penalty;


end


