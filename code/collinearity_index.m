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
function gamma  = collinearity_index(S) 
% calculates the collinearity factor according to Brun et al (2001)

try
s = svd(S);
catch 
    keyboard
end
gamma  = 1/s(end);

