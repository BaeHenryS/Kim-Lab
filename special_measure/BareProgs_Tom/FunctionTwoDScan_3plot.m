function FunctionTwoDScan_3plot(ScanNumber,xScan,yStep,Ref,FlagRef,z,ScanVec,StepVec,timeConstant,Directory,filename)

clc

%%% Making database and figures

xDim = length(ScanVec{1});
yDim = length(StepVec{1});

dataZ1 = zeros(yDim,xDim);  % row,col
dataZ2 = zeros(yDim,xDim);  % row,col
dataZ3 = zeros(yDim,xDim);

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
pause(0.5)

%%% Scanning

rInd = 1;
xInd = 1;

for StepIdy = [1:yDim] %%% Step loop
    
    %%% Scan vector
    tmpVecZ1 = [];
    tmpVecZ2 = [];
    tmpVecZ3 = [];
    
    
    %%% Init Step
    
    tmpStepVec = [];
    for i=1:nS2
        tmpStepVec = [tmpStepVec StepVec{i}(StepIdy)];
    end
    
    %%% Step
    
    smset(yStep, tmpStepVec)
    pause(1)
    
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
        pause(timeConstant)
        
        TmpZ1 = smget(z{1});
        TmpZ2 = smget(z{2});
        TmpZ3 = smget(z{3});
        
        tmpVecZ1 = [tmpVecZ1 TmpZ1{1}];
        tmpVecZ2 = [tmpVecZ2 TmpZ2{1}];
        tmpVecZ3 = [tmpVecZ3 TmpZ3{1}];
        
        %%% plot current scan
        if mod(ScanIdx,10)==0
            
            subplot(231)
            p1 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ1); grid on;
            xlabel(xScan);
            ylabel(z{1});
            title(['current scan'])
            
            subplot(232)
            p2 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ2); grid on;
            xlabel(xScan);
            ylabel(z{2});
            title(['current scan'])
            
            subplot(233)
            p3 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ3); grid on;
            xlabel(xScan);
            ylabel(z{3});
            title(['current scan'])
        end
        
    end
    
    %%% saving line scan
    dataZ1(StepIdy,:)= tmpVecZ1;
    dataZ2(StepIdy,:)= tmpVecZ2;
    dataZ3(StepIdy,:)= tmpVecZ3; 
    
    %%% plot scan
    ha = subplot(234)
    s1 = imagesc(ScanVec{1},StepVec{1}(1:StepIdy),dataZ1(1:StepIdy,:)); colorbar;
    xlabel(xScan);
    ylabel(yStep);
    title([z{1} ' - 2D scan'])
    set(ha, 'YDir','normal')
    
    ha = subplot(235)
    s2 = imagesc(ScanVec{1},StepVec{1}(1:StepIdy),dataZ2(1:StepIdy,:)); colorbar;
    xlabel(xScan);
    ylabel(yStep);
    title([z{2} ' - 2D scan'])
    set(ha, 'YDir','normal')
    
    ha = subplot(236)
    s2 = imagesc(ScanVec{1},StepVec{1}(1:StepIdy),dataZ3(1:StepIdy,:)); colorbar;
    xlabel(xScan);
    ylabel(yStep);
    title([z{3} ' - 2D scan'])
    set(ha, 'YDir','normal')
    
    save([filename '.mat'],'xScan','yStep','ScanVec','StepVec','z','dataZ1','dataZ2','dataZ3');
end

savefig(h,[filename '.fig']);
save([filename '.mat'],'xScan','yStep','ScanVec','StepVec','z','dataZ1','dataZ2','dataZ3');

