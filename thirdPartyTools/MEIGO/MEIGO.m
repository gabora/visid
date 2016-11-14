function [Results]=MEIGO(problem,opts,algorithm,varargin)

algorithm=upper(algorithm);

if strmatch(algorithm,'VNS')
    Results=rvnds_hamming(problem,opts,varargin{:});
elseif strmatch(algorithm,'ESS')
    Results=ess_kernel(problem,opts,varargin{:});
elseif strmatch(algorithm,'MULTISTART')
    Results=ssm_multistart(problem,opts,varargin{:});
else
    fprintf('The method defined in "algorithm" is not valid \n');
    fprintf('Define a valid method (VNS or eSS) and rerun \n');
    Results=[];
end
