for i = -10:10




smset("NUDAC", 1)

pause(1)
fprintf(smdata.inst(18).data.inst, 'ARNG');
pause(5)
fprintf(smdata.inst(18).data.inst, 'AUTS -1');
pause(1)

fprintf(smdata.inst(18).data.inst, 'STRT');

pause(10)

dacv0_100k_1vb_001 = NoiseMeasurement(4);


pause(1)
fprintf(smdata.inst(18).data.inst, 'ARNG');
pause(5)
fprintf(smdata.inst(18).data.inst, 'AUTS -1');
pause(1)

fprintf(smdata.inst(18).data.inst, 'STRT');
pause(10)

dacv0_100k_1vb_002 = NoiseMeasurement(4);


pause(1)
fprintf(smdata.inst(18).data.inst, 'ARNG');
pause(5)
fprintf(smdata.inst(18).data.inst, 'AUTS -1');
pause(1)

fprintf(smdata.inst(18).data.inst, 'STRT');
pause(10)


dacv0_100k_1vb_003 = NoiseMeasurement(4);
