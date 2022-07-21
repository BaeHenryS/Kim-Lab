clc

%-----------------------------------------------

%%% Initalizing measurement

ScanNumber = 1;

xScan = [{'v1','v2','v3'}];
yStep = [{'v4','v5','v6'}];

z = {'LI1','LI4'};

ScanVec  = {
    0.1:0.001:0.2,...
    0.1:0.001:0.2,...
    0.1:0.001:0.2};
StepVec  = {
    0.2:0.05:0.3,...
    0.2:0.05:0.3,...
    0.2:0.05:0.3};

Directory = 'C:\Users\yacoby\Dropbox\Harvard\Measurements\Amir Dil\Data\FP5 - FP Graphene\03\';
filename = [Directory sprintf('FP5_FPGraphene_01_%3.0f',ScanNumber)];
%-----------------------------------------------

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
    IntScanVec = [IntScanVec ScanVec{i}(1)];
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
            tmpScanVec = [tmpScanVec ScanVec{i}(ScanIdx)];
        end
        
        smset(xScan,tmpScanVec);
        pause(0.3)
        
        TmpZ1 = smget(z{1});
        TmpZ2 = smget(z{2});
        
        tmpVecZ1 = [tmpVecZ1 TmpZ1{1}];
        tmpVecZ2 = [tmpVecZ2 TmpZ2{1}];
        
        %%% plot current scan
        if mod(ScanIdx,10)==0
            
            subplot(221)
            p1 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ1); grid on;
            xlabel(xScan);
            ylabel(yStep);
            title([z{1} ' - current scan'])
            
            subplot(222)
            p2 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ2); grid on;
            xlabel(xScan);
            ylabel(yStep);
            title([z{2} ' - current scan'])
        end
        
    end
    
    %%% saving line scan
    dataZ1(StepIdy,:)= tmpVecZ1;
    dataZ2(StepIdy,:)= tmpVecZ2;
    
    %%% plot scan
    subplot(223)
    s1 = imagesc(ScanVec{1},StepVec{1},dataZ1); colorbar;
    set(gca,'YDir','reverse')
    xlabel(xScan);
    ylabel(yStep);
    title([z{1} ' - 2D scan'])
    
    subplot(224)
    s2 = imagesc(ScanVec{1},StepVec{1},dataZ2); colorbar;
    set(gca,'YDir','reverse')
    xlabel(xScan);
    ylabel(yStep);
    title([z{2} ' - 2D scan'])
    
    save([filename '.mat'],'xScan','yStep','ScanVec','StepVec','z','dataZ1','dataZ2');
end

savefig(h,[filename '.fig']);
save([filename '.mat'],'xScan','yStep','ScanVec','StepVec','z','dataZ1','dataZ2');

