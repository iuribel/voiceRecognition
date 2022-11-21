function code = train2(traindir)
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

k = 16;                         % number of centroids required

path=traindir; %'C:\'; % ruta si es la actual  poner path=pwd
ext='.wav'; % extension si no se desea filtrar por extension poner ext=''
 
ar=ls(path);
for j=1:size(ar,1)
    cn=ar(j,:);
    [~,~,ex]=fileparts(cn);
 
    if (and(~isfolder(fullfile(path,cn)),or(strcmpi(strtrim(ex),ext),isempty(ext))))
        disp(fullfile(path,cn))

        if(j>2)
 
            filename = fullfile(path,cn);
            
            
       
            [s, fs] = audioread(filename);
            
            v = mfcc(s, fs);            % Compute MFCC's
           
            
           
            code{j-2} = vqCodeBook(v, k);      % Train VQ codebook
            
        end
    end
end
