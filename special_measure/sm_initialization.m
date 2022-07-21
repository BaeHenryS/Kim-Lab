function sm_initialization()
    global smaux
    global smdata
    global smscan
    

    smaux.datadir = uigetdir('C:\Documents and Settings\spm\My Documents\MX 400 Data','Select Data Directory');

    [pptFile,pptPath] = uiputfile('*.ppt','Append to Presentation');
    if pptFile ~= 0
        smaux.pptsavefile=fullfile(pptPath,pptFile);   
    else
        pptsavefile = '';
    end

    if ~isfield(smaux,'run')
        smaux.run=1;
    end

smaux.initialized=1;


[smdataFile,smdataPath] = uigetfile('*.mat','Select Rack File');
    if smdataFile
        S=load(fullfile(smdataPath,smdataFile));
        smdata=S.smdata;
    end

end