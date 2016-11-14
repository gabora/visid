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
function [all_combination ci] = collinearityK(S,K,Clim,print_flag)
%collinearityK(S,k,c) calculates the collinearity index of all subsets of the columns S.
% S is an n*m dimensional matrix containing the s_i, i=1:n vectors
% K is the  number of element of the subsets
% Clim is a collinearity factor threshold. If the collinearity factor of a
% subset exeeds the specified threshold value, then we dont compute sets
% that has this subset of parameters.

if nargin < 4
    print_flag = 2;
end

n = size(S,2);
n_idx = 1:n;
tabulist = [];


all_combination = combnk(n_idx,K);
n_comb = size(all_combination,1);

ci = zeros(n_comb,1);

for i = 1:n_comb
    subset_indx = all_combination(i,:);
    
    %         if check_tabulist(tabulist,subset_indx)
    %             continue;
    %         end
    
    St = S(:,subset_indx);
    ci(i) = collinearity_index(St);
    
    if print_flag == 1
        if ci(i)>Clim
            %             tabulist = add_to_tabu(tabulist, subset_indx);
            fprintf('*')
        end
        fprintf('%d\t', subset_indx)
        fprintf('%g\t', ci(i))
        fprintf('\n')
    elseif print_flag == 0 && mod(i,100)==0
        fprintf('\t%d%%...\n',round(i/n_comb*100))
    end
end


end

function tabulist = add_to_tabu(tabulist, subset_indx)
if isempty(tabulist)
    tabulist = subset_indx;
    return;
end

[nt mt] = size(tabulist);
ls = numel(subset_indx);

if ls > mt
    T = nan(mt+1, ls);
    T(1:nt,1:mt) = tabulist;
    T(nt+1,:) = subset_indx;
    tabulist = T;
else
    tabulist = [tabulist; subset_indx];
end
end

function skip = check_tabulist(tabulist,subset_indx)


for i = 1:size(tabulist,1)
    l = tabulist(i,~isnan(tabulist(i,:)));
    M = ismember(l,subset_indx);
    
    if ~isempty(M) && all(M)
        skip = true;
        return;
    end
end
skip = false;

end
