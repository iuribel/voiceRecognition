function names = savenames(traindir)

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
