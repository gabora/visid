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
function pair_tripletCI2cytoscape(hcgrp2,hci2,hcgrp3,hci3,variables,fname)
% write Cytoscape network file from thepair and triplet collinear parameters.
 




for i = 1:size(hcgrp3,1)
    from{3*(i-1)+1} = variables{hcgrp3(i,1)};
    to{3*(i-1)+1} = variables{hcgrp3(i,2)};
    type{3*(i-1)+1} = 'pp3';
    edge_name{3*(i-1)+1} = sprintf('%s (pp3) %s',variables{hcgrp3(i,1)},variables{hcgrp3(i,2)});
    CI_str{3*(i-1)+1} = sprintf('%.8g',hci3(i));
    
    from{3*(i-1)+2} = variables{hcgrp3(i,1)};
    to{3*(i-1)+2} = variables{hcgrp3(i,3)};
    type{3*(i-1)+2} = 'pp3';
    edge_name{3*(i-1)+2} = sprintf('%s (pp3) %s',variables{hcgrp3(i,1)},variables{hcgrp3(i,3)});
    CI_str{3*(i-1)+2} = sprintf('%.8g',hci3(i));
    
    from{3*(i-1)+3} = variables{hcgrp3(i,2)};
    to{3*(i-1)+3} = variables{hcgrp3(i,3)};
    type{3*(i-1)+3} = 'pp3';
    edge_name{3*(i-1)+3} = sprintf('%s (pp3) %s',variables{hcgrp3(i,2)},variables{hcgrp3(i,3)});
    CI_str{3*(i-1)+3} = sprintf('%.8g',hci3(i));
end

N3 = length(CI_str);

for i = 1:size(hcgrp2,1)
            CI_str{N3+i} =sprintf('%g',hci2(i));
            edge_name{N3+i} = sprintf('%s (pp) %s',variables{hcgrp2(i,1)},variables{hcgrp2(i,2)});
            from{N3+i} = sprintf('%s',variables{hcgrp2(i,1)});
            to{N3+i} = sprintf('%s',variables{hcgrp2(i,2)});
            type{N3+i} = sprintf('pp');
end



network2file([fname '_HCI_2_3_edgeTable.txt'],{'edgename','CI'},edge_name,CI_str);
network2file([fname '_HCI_2_3.sif'],{},from,type,to);