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
function [hcgrps, hci] = highCollinearityUptoKgroup(S,K,Clim)
%highCollinearityUptoKgroup(S,k,c) calculates highly correlated groups up
%to group of K parameters based on the columns of S.
% S is an n*m dimensional matrix containing the s_i, i=1:n vectors
% K is the  number of element of the largest subset
% Clim is a collinearity factor threshold. If the collinearity factor of a
% subset exeeds the specified threshold value, then we dont compute sets
% that has this subset of parameters.

if nargin < 4
    print_flag = 2;
end

n = size(S,2);
n_idx = 1:n;


hcgrps{K} = [];
hci{K}=[];
for igroup = 2:K
    [g3, ci3] = collinearityK(S,igroup,Clim);
    
    tmp3 = g3(ci3>Clim,:);
    ci3 = ci3(ci3>Clim);
    % remove the cases if a lower dimensional subset already highly
    % correlated
    
    for i = 1:size(tmp3,1)
        for k = 1:igroup-1
            for j = 1:size(hcgrps{k},1)
                if  isempty(setdiff( hcgrps{k}(j,:),tmp3(i,:)))
                    tmp3(i,:) = zeros(1,igroup);
                    ci3(i) = 0;
                    break;
                end
            end
        end
    end
    real3 = 0;
    for i = 1:size(tmp3,1)
        if sum(tmp3(i,:))
            real3 = real3 +1;
            hcgrps{igroup}(real3,: ) = tmp3(i,:);
            hci{igroup}(real3) = ci3(i);
        end
    end

    
    
    
end

