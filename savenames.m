function names = savenames(traindir)
% Speaker Recognition: Training Stage
%
% Input:
%       traindir : string name/path of directory contains all train sound files
%       n        : number of train files in traindir
%
% Output:
%       code     : trained VQ codebooks, code{i} for i-th speaker
%
% Note:
%       Sound files in traindir is supposed to be: 
%                       s1.wav, s2.wav, ..., sn.wav

path=traindir; %'C:\'; % ruta si es la actual  poner path=pwd
ext='.wav'; % extension si no se desea filtrar por extension poner ext=''
 
ar=ls(path);
for j=1:size(ar,1)
    cn=ar(j,:);
    [~,~,ex]=fileparts(cn);
    if(j>2)
        if (and(~isfolder(fullfile(path,cn)),or(strcmpi(strtrim(ex),ext),isempty(ext))))
            disp(cn)       
            names{j-2}=cn;
        end
    end
end
