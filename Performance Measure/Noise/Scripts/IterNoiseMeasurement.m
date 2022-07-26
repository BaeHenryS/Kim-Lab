for i = -10:10
    j = i + 11;
    smset("Yoko", i)
    pause(1)
    fprintf(smdata.inst(18).data.inst, 'ARNG 0');
    pause(2)
    fprintf(smdata.inst(18).data.inst, 'ARNG 1');
    pause(7)
    fprintf(smdata.inst(18).data.inst, 'AUTS -1');
    pause(1)
    fprintf(smdata.inst(18).data.inst, 'ARNG');
    pause(1)
    fprintf(smdata.inst(18).data.inst, 'STRT');
    pause(10)
    yoko_100k_v_001(:,j) = NoiseMeasurement(4);
end

