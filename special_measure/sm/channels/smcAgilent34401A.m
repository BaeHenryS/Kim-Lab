function val = smcAgilent34401A(ico, val, rate)
%Driver for the Keithley 2400 SourceMeter
%channel 1 = voltage manual ramp
%channel 2 = current
global smdata;


%Keithley read command returns five elements separated by commas
%1) Voltage reading 2) Current reading 3) Resistance reading
%4) Timestamp 5) Status Word
%Keithely returns 9.91E37 as NaN for function not enabled

switch ico(2) % channel
    case 1 %voltage
        switch ico(3) %operation
            case 1 %set
                error('Channel not supported');
                
            case 0 %get
                val = query(smdata.inst(ico(1)).data.inst, 'READ?', '%s\n','%f');
                
            otherwise
                error('Operation not supported');
        end
    case 2 %current
        switch ico(3) %operation
            case 0 %get
                val = query(smdata.inst(ico(1)).data.inst, 'MEAS:CURR:DC?', '%s\n', '%f');
                
            otherwise
                error('Operation not supported');
        end
    otherwise
        error('Channel not supported');
end