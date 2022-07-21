function FunctionTwoDScan_4plot(ScanNumber,xScan,yStep,Ref,FlagRef,z,ScanVec,StepVec,timeConstant,Directory,filename)

clc

%%% Making database and figures

xDim = length(ScanVec{1});
yDim = length(StepVec{1});

dataZ1 = zeros(yDim,xDim);  % row,col
dataZ2 = zeros(yDim,xDim);  % row,col
dataZ3 = zeros(yDim,xDim);
dataZ4 = zeros(yDim,xDim);

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
    tmpVecZ4 = [];
    
    
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
        
        if ScanIdx==1
            pause(30)
        else
            pause(timeConstant)
        end
        
        TmpZ1 = smget(z{1});
        TmpZ2 = smget(z{2});
        TmpZ3 = smget(z{3});
        TmpZ4 = smget(z{4});
        
        tmpVecZ1 = [tmpVecZ1 TmpZ1{1}];
        tmpVecZ2 = [tmpVecZ2 TmpZ2{1}];
        tmpVecZ3 = [tmpVecZ3 TmpZ3{1}];
        tmpVecZ4 = [tmpVecZ4 TmpZ4{1}];
        
        %%% plot current scan
        if mod(ScanIdx,10)==0
            
            subplot(241)
            p1 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ1); grid on;
            xlabel(xScan);
            ylabel(z{1});
            title(['current scan'])
            
            subplot(242)
            p2 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ2); grid on;
            xlabel(xScan);
            ylabel(z{2});
            title(['current scan'])
            
            subplot(243)
            p3 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ3); grid on;
            xlabel(xScan);
            ylabel(z{3});
            title(['current scan'])
            
            subplot(244)
            p4 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ4); grid on;
            xlabel(xScan);
            ylabel(z{4});
            title(['current scan'])
        end
        
    end
    
    %%% saving line scan
    dataZ1(StepIdy,:)= tmpVecZ1;
    dataZ2(StepIdy,:)= tmpVecZ2;
    dataZ3(StepIdy,:)= tmpVecZ3; 
    dataZ4(StepIdy,:)= tmpVecZ4;
    
    %%% plot scan
    ha = subplot(245)
    s1 = imagesc(ScanVec{1},StepVec{1}(1:StepIdy),dataZ1(1:StepIdy,:)); colorbar;
    xlabel(xScan);
    ylabel(yStep);
    title([z{1} ' - 2D scan'])
    set(ha, 'YDir','normal')
    
    ha = subplot(246)
    s2 = imagesc(ScanVec{1},StepVec{1}(1:StepIdy),dataZ2(1:StepIdy,:)); colorbar;
    xlabel(xScan);
    ylabel(yStep);
    title([z{2} ' - 2D scan'])
    set(ha, 'YDir','normal')
    
    ha = subplot(247)
    s3 = imagesc(ScanVec{1},StepVec{1}(1:StepIdy),dataZ3(1:StepIdy,:)); colorbar;
    xlabel(xScan);
    ylabel(yStep);
    title([z{3} ' - 2D scan'])
    set(ha, 'YDir','normal')
    
    ha = subplot(248)
    s4 = imagesc(ScanVec{1},StepVec{1}(1:StepIdy),dataZ4(1:StepIdy,:)); colorbar;
    xlabel(xScan);
    ylabel(yStep);
    title([z{4} ' - 2D scan'])
    set(ha, 'YDir','normal')
    
    save([filename '.mat'],'xScan','yStep','ScanVec','StepVec','z','dataZ1','dataZ2','dataZ3','dataZ4');
end

savefig(h,[filename '.fig']);
save([filename '.mat'],'xScan','yStep','ScanVec','StepVec','z','dataZ1','dataZ2','dataZ3','dataZ4');

