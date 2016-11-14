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
function pairwiseCI2cytoscape(pairs,ci_pairs,variables,fname)
% export the highly collinear pairs to cytoscape
%pairwiseCI2Cytoscape(hcgrps{2},hci{2},variables,[cytoscapeFolder 'hcgrps'])



from=cell(size(pairs,1),1);
to = cell(size(pairs,1),1);
type=cell(size(pairs,1),1);
CI_str=cell(size(pairs,1),1);
edge_name=cell(size(pairs,1),1);

for i = 1:size(pairs,1)
            CI_str{i} =sprintf('%g',ci_pairs(i));
            edge_name{i} = sprintf('%s (pp) %s',variables{pairs(i,1)},variables{pairs(i,2)});
            from{i} = sprintf('%s',variables{pairs(i,1)});
            to{i} = sprintf('%s',variables{pairs(i,2)});
            type{i} = sprintf('pp');
end

network2file([fname '_HCI_pairwise_edgeTable.txt'],{'edgename','CI'},edge_name,CI_str);
network2file([fname '_HCI_pairwise.sif'],{},from,type,to);