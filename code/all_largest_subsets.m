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
function [largest_subsets largest_ci] = all_largest_subsets(nx,ci_threshold)
% find all the largest identifiable subsets with collinearity less than a
% threshold value.
% ci_threshold = 30;
% We compute collinearities of sets with increasing size.

set_size = 2;
[combi2 ci2] = collinearityK(nx,set_size,ci_threshold,0);


base_set = combi2(ci2<ci_threshold,:);

% increase size
npar = size(nx,2);
extended_set = [];
isets = 0;
ttot = tic;
for setsize = 3:npar
    fprintf('testing setsize: %d \n',setsize);
    tit = tic;
    extended_set = zeros(ceil(size(base_set,1)*npar/2),setsize);
    c3 = zeros(ceil(size(base_set,1)*npar/2),1);
    for i = 1:size(base_set,1)
        tmp_set = zeros(1,setsize);
        tmp_set(1:end-1) = base_set(i,:);
        for j = base_set(i,end)+1 : npar
            tmp_set(1,end) = j;
            c = collinearity_index(nx(:,tmp_set));
            if c < ci_threshold
                isets = isets+1;
                extended_set(isets,:) =  tmp_set;
                c3(isets) = c;
            end
        end
    end
    toc(tit)
    if isets == 0
        % no subset with acceptable col.indx. was found
        % return the previous interation results
        largest_subsets = base_set;
        largest_ci = c2;
        break;
    else
    base_set = extended_set(1:isets,:);
    c2 = c3(1:isets,:);
    largest_subsets = base_set;
    largest_ci = c2;
    
    extended_set = [];
    c3 = [];
    isets = 0;
    end
    
end
toc(ttot)

