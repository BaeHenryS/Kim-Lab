for i = -10:10
    j = i + 11;
    smset("NUDAC", i)
    pause(1)
    fprintf(smdata.inst(18).data.inst, 'ARNG');
    pause(5)
    fprintf(smdata.inst(18).data.inst, 'AUTS -1');
    pause(1)
    fprintf(smdata.inst(18).data.inst, 'STRT');
    pause(10)
    dacv0_100k_v(:,j) = NoiseMeasurement(4);

