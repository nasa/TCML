function uninstall_TCML()
% This subroutine uninstalls TCML
error = 0;
TCMLRemovemsg = 'Remove TCML matlab toolbox? Note: Un-Installation will remove MATLAB paths.';
POp = filesep;

switch questdlg(TCMLRemovemsg, 'TCML_Library', 'Yes', 'No', 'No');
    
    % check if Library is in the path
    
    case 'Yes',
        p = path;                               % current path
        CurrDir = pwd;                          % current directory
        % define new paths
        Pth{1} = strcat(pwd,POp,'TCML_Library');
        Pth{2} = strcat(pwd,POp,'TCML_Library',POp,'Support');
        Pth{3} = strcat(pwd,POp,'TCML_Library',POp,'MATLAB_Scripts');
        
        perm = zeros( 1 , length(Pth));  % allocate memory for perm
        
        for i = 1:length(Pth)
            
            perm(i) = ~isempty(strfind(pathdef,strcat(Pth{i},';')));  % determine if path is already defined
            
            
            if perm(i)                               % for each path if defined,  remove it from pathdef
                path(pathdef);
                rmpath(Pth{i});
                SP = savepath;
                if SP==0
                    disp(sprintf(' %s has been removed from the Path structure.',Pth{i}));
                else
                    error = 1;
                    disp(sprintf('Error: %s Has not been removed from the Path structure',Pth{i}));
                end
            else
                disp (sprintf('%s does not exist in the path structure',Pth{i}));
            end
            
        end
        
        
        path(p)
        for i = 1:length(Pth)
            perm(i) = ~isempty(strfind(path,Pth{i}));  % determine if path is already defined
            
            if perm(i)
                eval(['rmpath ',Pth{i}])
            end
        end
        
        if error ==0;
            FileExist = exist(strcat(pwd,POp,'TCML_Library ',POp,'Contents.m'), 'file');
            if FileExist == 2
                cd( 'TCML_Library')
                disp('Removing Contents.m');
                fid = fopen('Contents.m');
                fclose(fid);
                delete('Contents.m');
                eval(['cd ' CurrDir]);
            end
            
            disp('TCML path removal complete.');
        end
    case 'No',
        disp('TCML removal aborted.');
end