function test2(testdir,code1,names1, names2)
% Speaker Recognition: Testing Stage
%
% Input:
%       testdir : string name of directory contains all test sound files
%       n       : number of test files in testdir
%       code    : codebooks of all trained speakers
%
% Note:
%       Sound files in testdir is supposed to be: 
%               s1.wav, s2.wav, ..., sn.wav
%
% Example:
%       >> test('C:\data\test\', 8, code);

path=testdir; %'C:\'; % ruta si es la actual  poner path=pwd
ext='.wav'; % extension si no se desea filtrar por extension poner ext=''
 
ar=ls(path);
for j=1:size(ar,1)
    cn=ar(j,:);
    [~,~,ex]=fileparts(cn);
 
    if (and(~isfolder(fullfile(path,cn)),or(strcmpi(strtrim(ex),ext),isempty(ext))))
        %disp(fullfile(path,cn))
        if(j>2)
            filename = fullfile(path,cn);     
            [s, fs] = audioread(filename);      
            
            v = mfcc(s, fs);            % Compute MFCC's
           
            distmin = inf;
            k1 = '';
            for l = 1:length(code1)      % each trained codebook, compute distortion
                            
                d = distance(v, code1{l}); %cambiar 1 por l 
                dist = sum(min(d,[],2)) / size(d,1);
              
                if dist < distmin
                    distmin = dist;
                    k1 = names1{l};
                end      
            end
       
        msg = sprintf('Speaker %s matches with speaker %s', names2{j-2}, k1);
        disp(msg);
        end
    end
end