%For Non-DAC's When going back to -10V
%smset("Yoko", -10)
%pause(250)

for i = -10:10
    j = i + 11;
    %CHANGE THIS DEPENDING ON WHAT DEVICE YOU ARE USING
    smset("NUDAC", i)
    pause(15)
    fprintf(smdata.inst(18).data.inst, 'ARNG 0');
    pause(2)
    fprintf(smdata.inst(18).data.inst, 'ARNG 1');
    pause(7)
    fprintf(smdata.inst(18).data.inst, 'AUTS -1');
    pause(1)
    fprintf(smdata.inst(18).data.inst, 'ARNG');
    pause(1)
    fprintf(smdata.inst(18).data.inst, 'STRT');
    pause(25)
    dac_LTC6655_100k_v_001(:,j) = NoiseMeasurement(4);
end

