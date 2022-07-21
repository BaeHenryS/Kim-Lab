clc

%-----------------------------------------------

%%% Initalizing measurement

ScanNumber = 1;

xScan = [{'v1','v2','v3'}];

z = {'LI1','LI4'};

ScanVec  = {
    0.1:0.001:0.2,...
    0.1:0.001:0.2,...
    0.1:0.001:0.2};

Directory = 'C:\Users\yacoby\Dropbox\Harvard\Measurements\Amir Dil\Data\FP5 - FP Graphene\03\';
filename = [Directory sprintf('FP5_FPGraphene_01_%3.0f',ScanNumber)];
%-----------------------------------------------

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

smset(xScan,IntScanVec);
pause(0.5)

%%% Scanning

tmpVecZ1 = [];
tmpVecZ2 = [];

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
        
        subplot(121)
        p1 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ1); grid on;
        xlabel(xScan);
        ylabel(z{1});
        
        subplot(122)
        p2 = plot(ScanVec{1}(1:ScanIdx), tmpVecZ2); grid on;
        xlabel(xScan);
        ylabel(z{2});
    end
    
end

savefig(h,[filename '.fig']);
save([filename '.mat'],'xScan','ScanVec','z','dataZ1','dataZ2');

