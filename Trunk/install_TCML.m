function install_TCML()
% This subroutine installs TCML

% TCMLver and date must remain in the listed form for the ver command to work
% properly.
TCMLver = '1.0.0';
TCMLdate = '4Jan-2018';

TSATInstallmsg = 'Install TCML matlab toolbox? Note: Installation will add MATLAB paths';
POp = filesep;

switch questdlg(TSATInstallmsg, 'TCML Library','Temporary Install', 'Install', 'Cancel', 'Cancel');
    case 'Temporary Install'
        InstallType = 'Install';
        PermInstall = 0;
    case 'Install'
        InstallType = 'Install';
        PermInstall = 1;
    case 'Cancel'
        InstallType = 'Cancel';
        PermInstall = 0;
end
% check if TCML_Library is in the path
switch InstallType
    case 'Install',
        p = path;                               % current path
        CurrDir = pwd;                          % current directory
        % define new paths
        Pth{1} = strcat(pwd,POp,'TCML_Library');
        Pth{2} = strcat(pwd,POp,'TCML_Library',POp,'Support');
        Pth{3} = strcat(pwd,POp,'TCML_Library',POp,'MATLAB_Scripts');
        
        perm = zeros( 1 , length(Pth));         % allocate memory for perm
        for i = 1: length(Pth)
            
            perm(i) = isempty(strfind(pathdef,strcat( Pth{i} , ';' )));  % determine if path is already defined
            
            if perm(i)                               % for each path if it is not defined,  define it
                path(pathdef);
                addpath(Pth{i});
                if PermInstall == 1;
                    SP = savepath;
                    if SP==0
                        disp(sprintf(' %s has been saved to the permanent Path structure.',Pth{i}));
                    else
                        error = 1;
                        disp(sprintf('Error: %s has not been added to the permanent Path structure. To use TSAT blocks Install_TSAT.m will need to be run each time MATLAB is opened.',Pth{i}));
                    end
                else
                    disp(sprintf(' %s has been added to the Path structure.',Pth{i}));
                end
            else
                disp (sprintf('%s is already defined in the path structure',Pth{i}));
            end
        end
        
        
        % return to current path.
        path(p);
        for i = 1:length(Pth)
            addpath(Pth{i});
        end
        
        if PermInstall == 1
            cd( 'TCML_Library')
            disp('Building Contents.m file');
            fid = fopen('Contents.m','w');
            fprintf(fid,'%% TCML.\n');
            fprintf(fid,['%% Version',' ',TCMLver,' ',TCMLdate,'\n%%\n%% Files\n']);
            fprintf(fid,'%%   Install_TCML   - This subroutine installs TCML\n');
            fprintf(fid,'%%   Uninstall_TCML - This subroutine uninstalls TCML\n');
            fclose(fid);
            eval(['cd ' CurrDir]);
        end
        
                
	disp('Refreshing Simulink Browser...');
	LB = LibraryBrowser.LibraryBrowser2;
        LB.refresh;
        
        disp('TCML Simulink library installation complete.');

    case 'Cancel',
        disp('TCML installation aborted.');
end

