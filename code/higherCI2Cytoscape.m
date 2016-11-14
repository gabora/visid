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
function higherCI2Cytoscape(groups,ci,variables,fname)
% Export groups of correlated variables to Cytoscape by creating sif and
% table files.
iedges = 0;
ndummyNode = 0;

from = {};
to = {};
type = {};
edge_name = {};
CI_str = {};
dummy={};

for idim = 1:length(groups)
    
    if isempty(groups{idim})
        continue
    end
    for igroup = 1:size(groups{idim},1)
        if size(groups{idim},2)> 2
            % create a dummy variable to connects more than 2 element groups
            ndummyNode = ndummyNode + 1;
            dummy{ndummyNode} = ['G' ,num2str(ndummyNode)];
            for j = 1:length(groups{idim}(igroup,:))
                iedges = iedges + 1;
                from{iedges} = variables{groups{idim}(igroup,j)};
                to{iedges}  = dummy{ndummyNode};
                type{iedges} = 'pp';
                edge_name{iedges} = sprintf('%s (pp) %s',variables{groups{idim}(igroup,j)},dummy{ndummyNode});
                CI_str{iedges} = sprintf('%.8g',ci{idim}(igroup));
            end
            
            
        elseif size(groups{idim},2) == 2
            % export pairs
            iedges = iedges + 1;
            
            from{iedges} = variables{groups{idim}(igroup,1)};
            to{iedges}  = variables{groups{idim}(igroup,2)};
            type{iedges} = 'pp';
            edge_name{iedges} = sprintf('%s (pp) %s',variables{groups{idim}(igroup,1)},variables{groups{idim}(igroup,2)});
            CI_str{iedges} = sprintf('%.8g',ci{idim}(igroup));
            
        end
    end
    
    
end

nodes = [variables(:); dummy(:)];
[types{1:length(variables)}] = deal('par');
[types{length(variables)+(1:length(dummy))}] =  deal('group_var');
network2file([fname '_HCI_edgeTable.txt'],{'edgename','CI'},edge_name,CI_str);
network2file([fname '_HCI.sif'],{},from,type,to);
network2file([fname '_HCI_nodeTable.txt'],{'name','type'},nodes,types);