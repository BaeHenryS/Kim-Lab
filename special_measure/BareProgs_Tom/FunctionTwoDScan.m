function FunctionTwoDScan(ScanNumber,xScan,yStep,Ref,FlagRef,z,ScanVec,StepVec,timeConstant,Directory,filename)

%%% Making database and figures

xDim = length(ScanVec{1});
yDim = length(StepVec{1});

dataZ1 = zeros(yDim,xDim);  % row,col
dataZ2 = zeros(yDim,xDim);  % row,col

h  = figure(101);

%%% Initalizing voltages

[mS1 nS1] = size(ScanVec);
[mS2 nS2] = size(StepVec);

IntScanVec = [];
for i=1:nS1
    
    if FlagRef(i)==0
        IntScanVec = [IntScanVec ScanVec{i}(1)];
    else
        IntScanVec = [IntScanVec ScanVec{i}(1)+Ref(1)];
    end
    
end

IntStepVec = [];
for i=1:nS2
    IntStepVec = [IntStepVec StepVec{i}(1)];
end

smset(xScan,IntScanVec);
smset(yStep,IntStepVec);
pause(10)

%%% Scanning

rInd = 1;
xInd = 1;

for StepIdy = [1:yDim] %%% Step loop
    
    %%% Scan vector
    tmpVecZ1 = [];
    tmpVecZ2 = [];
    
    %%% Init Step
    
    tmpStepVec = [];
    for i=1:nS2
        tmpStepVec = [tmpStepVec StepVec{i}(StepIdy)];
    end
    
    %%% Step
    clc
    StepIdy
    tmpStepVec(1)
    smset(yStep, tmpStepVec)
    pause(5)
    
    for ScanIdx = [1:xDim] %%% Scan loop
        
        tmpScanVec = [];
        for i=1:nS1
            
            if FlagRef(i)==0
                tmpScanVec = [tmpScanVec ScanVec{i}(ScanIdx)];
            else
                tmpScanVec = [tmpScanVec ScanVec{i}(ScanIdx)+Ref(StepIdy)];
            end
            
        end
        
        smset(xScan,tmpScanVec);
        if ScanIdx==1
            pause(10)
        else
            pause(timeConstant)
        end
        
        TmpZ1 = smget(z{1});
        TmpZ2 = smget(z{2});
        
        tmpVecZ1 = [tmpVecZ1 TmpZ1{1}];
        tmpVecZ2 = [tmpVecZ2 TmpZ2{1}];
        
        %%% plot current scan
        if mod(ScanIdx,10)==0
            
            subplot(221)
            p1 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ1); grid on;
            xlabel(xScan);
            ylabel(z{1});
            title(['current scan'])
            
            subplot(222)
            p2 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ2); grid on;
            xlabel(xScan);
            ylabel(z{2});
            title(['current scan'])
        end
        
    end
    
    %%% saving line scan
    dataZ1(StepIdy,:)= tmpVecZ1;
    dataZ2(StepIdy,:)= tmpVecZ2;
    
    %%% plot scan
    ha = subplot(223)
    s1 = imagesc(ScanVec{1},StepVec{1}(1:StepIdy),dataZ1(1:StepIdy,:)); colorbar;
    xlabel(xScan);
    ylabel(yStep);
    title([z{1} ' - 2D scan'])
    set(ha, 'YDir','normal')
    
    ha = subplot(224)
    s2 = imagesc(ScanVec{1},StepVec{1}(1:StepIdy),dataZ2(1:StepIdy,:)); colorbar;
    xlabel(xScan);
    ylabel(yStep);
    title([z{2} ' - 2D scan'])
    set(ha, 'YDir','normal')
    
    save([filename '.mat'],'xScan','yStep','ScanVec','StepVec','z','dataZ1','dataZ2');
end

savefig(h,[filename '.fig']);
save([filename '.mat'],'xScan','yStep','ScanVec','StepVec','z','dataZ1','dataZ2');

end

