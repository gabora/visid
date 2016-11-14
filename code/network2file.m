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
function network2file(fileName,header,varargin)

 fid = fopen(fileName,'w');
%fid = 1;

if ~isempty(header)
fprintf(fid,'%s\t',header{:});
fprintf(fid,'\n');
end
for i = 1:length(varargin{1})
    for j = 1:length(varargin)
        fprintf(fid,'%s\t',varargin{j}{i});
    end
    fprintf(fid,'\n');
end

fclose(fid);
end