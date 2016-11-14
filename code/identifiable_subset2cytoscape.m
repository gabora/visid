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
function [id_param id_subset id_variables]= identifiable_subset2cytoscape(Rjac,variables,colin_threshold, fname)
% determines a largest set of non-collinear parameters and exports to a
% text file for Cytoscape. 


id_subset = locally_identifiable_subset(Rjac,colin_threshold);

id_variables = variables(id_subset);


N = size(variables,1);

for i = 1:N
    if ismember(i,id_subset);
        str{i} = 'id param';
    else
        str{i} = 'non-id param';
    end
end

network2file([fname '_ID.txt'],{'Parameter','Identifiability'},variables,str);

id_param = str';