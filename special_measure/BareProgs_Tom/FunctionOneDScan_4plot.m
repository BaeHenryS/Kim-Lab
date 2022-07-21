function FunctionOneDScan_4plot(ScanNumber,xScan,z,ScanVec,timeConstant,Directory,filename)

clc

%%% Making database and figures

xDim = length(ScanVec{1});

dataZ1 = zeros(1,xDim);  % row,col
dataZ2 = zeros(1,xDim);  % row,col
dataZ3 = zeros(1,xDim);
dataZ4 = zeros(1,xDim);

h  = figure(101);

%%% Initalizing voltages

[mS1 nS1] = size(ScanVec);

IntScanVec = [];
for i=1:nS1
    IntScanVec = [IntScanVec ScanVec{i}(1)];
end

smset(xScan,IntScanVec);
pause(2)

%%% Scanning

tmpVecZ1 = [];
tmpVecZ2 = [];
tmpVecZ3 = [];
tmpVecZ4 = [];

for ScanIdx = [1:xDim] %%% Scan loop
    
    tmpScanVec = [];
    for i=1:nS1
        tmpScanVec = [tmpScanVec ScanVec{i}(ScanIdx)];
    end
    
    smset(xScan,tmpScanVec);
    pause(timeConstant)
    
    TmpZ1 = smget(z{1});
    TmpZ2 = smget(z{2});
    TmpZ3 = smget(z{3});
    TmpZ4 = smget(z{4});
    
    tmpVecZ1 = [tmpVecZ1 TmpZ1{1}];
    tmpVecZ2 = [tmpVecZ2 TmpZ2{1}];
    tmpVecZ3 = [tmpVecZ3 TmpZ3{1}];
    tmpVecZ4 = [tmpVecZ4 TmpZ4{1}];
    
    %%% plot current scan
    if mod(ScanIdx,1)==0
        
        subplot(141)
        p1 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ1); grid on;
        xlabel(xScan);
        ylabel(z{1});
        
        subplot(142)
        p2 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ2); grid on;
        xlabel(xScan);
        ylabel(z{2});
        
        subplot(143)
        p3 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ3); grid on;
        xlabel(xScan);
        ylabel(z{3});
        
        subplot(144)
        p4 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ4); grid on;
        xlabel(xScan);
        ylabel(z{4});
    end
    
end

dataZ1 = tmpVecZ1;  % row,col
dataZ2 = tmpVecZ2;  % row,col
dataZ3 = tmpVecZ3;  % row,col
dataZ4 = tmpVecZ4;  % row,col

savefig(h,[filename '.fig']);
save([filename '.mat'],'xScan','ScanVec','z','dataZ1','dataZ2','dataZ3','dataZ4');

