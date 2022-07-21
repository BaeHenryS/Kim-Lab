function FunctionOneDScan_6plot(ScanNumber,xScan,z,ScanVec,timeConstant,Directory,filename)

clc

%%% Making database and figures

xDim = length(ScanVec{1});

dataZ1 = zeros(1,xDim);  % row,col
dataZ2 = zeros(1,xDim);  % row,col
dataZ3 = zeros(1,xDim);
dataZ4 = zeros(1,xDim);
dataZ5 = zeros(1,xDim);
dataZ6 = zeros(1,xDim);

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
tmpVecZ5 = [];
tmpVecZ6 = [];

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
    TmpZ5 = smget(z{5});
    TmpZ6 = smget(z{6});
    
    tmpVecZ1 = [tmpVecZ1 TmpZ1{1}];
    tmpVecZ2 = [tmpVecZ2 TmpZ2{1}];
    tmpVecZ3 = [tmpVecZ3 TmpZ3{1}];
    tmpVecZ4 = [tmpVecZ4 TmpZ4{1}];
    tmpVecZ5 = [tmpVecZ5 TmpZ5{1}];
    tmpVecZ6 = [tmpVecZ6 TmpZ6{1}];
   
    
    %%% plot current scan
    if mod(ScanIdx,1)==0
        
        subplot(241)
        p1 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ1); grid on;
        xlabel(xScan);
        ylabel(z{1});
        
        subplot(242)
        p2 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ2); grid on;
        xlabel(xScan);
        ylabel(z{2});
        
        subplot(243)
        p3 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ3); grid on;
        xlabel(xScan);
        ylabel(z{3});
        
        subplot(244)
        p4 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ4); grid on;
        xlabel(xScan);
        ylabel(z{4});

        subplot(245)
        p4 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ5); grid on;
        xlabel(xScan);
        ylabel(z{5});

        subplot(246)
        p4 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ6); grid on;
        xlabel(xScan);
        ylabel(z{6});

    end
    
end

dataZ1 = tmpVecZ1;  % row,col
dataZ2 = tmpVecZ2;  % row,col
dataZ3 = tmpVecZ3;  % row,col
dataZ4 = tmpVecZ4;  % row,col
dataZ5 = tmpVecZ5;
dataZ6 = tmpVecZ6;


savefig(h,[filename '.fig']);
save([filename '.mat'],'xScan','ScanVec','z','dataZ1','dataZ2','dataZ3','dataZ4','dataZ5','dataZ6');

