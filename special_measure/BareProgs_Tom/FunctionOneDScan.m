function FunctionOneDScan(ScanNumber,xScan,z,ScanVec,timeConstant,Directory,filename)

clc

%%% Making database and figures

xDim = length(ScanVec{1});

dataZ1 = zeros(1,xDim);  % row,col
dataZ2 = zeros(1,xDim);  % row,col

h  = figure(101);

%%% Initalizing voltages

[mS1 nS1] = size(ScanVec);

IntScanVec = [];
for i=1:nS1
    IntScanVec = [IntScanVec ScanVec{i}(1)];
end
IntStepVec = [];


smset(xScan,IntScanVec);
pause(1)

%%% Scanning

tmpVecZ1 = [];
tmpVecZ2 = [];

for ScanIdx = [1:xDim] %%% Scan loop
    
    tmpScanVec = [];
    for i=1:nS1
        tmpScanVec = [tmpScanVec ScanVec{i}(ScanIdx)];
    end
    
    smset(xScan,tmpScanVec);
    pause(timeConstant)
    
    
    TmpZ1 = smget({z{1}});pause(0.2);
    tmpVecZ1 = [tmpVecZ1 TmpZ1{1}];
    
    TmpZ2 = smget({z{2}});pause(0.2);
    tmpVecZ2 = [tmpVecZ2 TmpZ2{1}];
    
    subplot(121)
    p1 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ1); grid on;
    xlabel(xScan);
    ylabel(z{1});
    
    subplot(122)
    p2 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ2); grid on;
    xlabel(xScan);
    ylabel(z{2});
    
    
end
dataZ1 = tmpVecZ1;  % row,col
dataZ2 = tmpVecZ2;  % row,col

savefig(h,[filename '.fig']);
save([filename '.mat'],'xScan','ScanVec','z','dataZ1','dataZ2');

