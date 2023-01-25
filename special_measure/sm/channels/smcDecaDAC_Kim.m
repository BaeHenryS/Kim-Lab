function val = smcDecaDAC_Kim(ic, val, rate)
% 1-12 = channel 0 - 11

global smdata;


% Implementing the Voltage Send:
% Instrument: smdata.inst(ic(1))
% Channel 
switch ic(3)
    case 1
        fprintf("Hi")
    case 0
       
        range = smdata.inst(ic(1)).data.rng(floor((ic(2)-1)/2)+1);
        fprintf(string(val))
        fprintf(string(range))
        if val > range || val < -range
            voltageBin = 0;
        else
            voltageBin = floor((val + range)/(2 * range) * 65535);
            if voltageBin < 0
                voltageBin = 0;
            elseif voltageBin > 65535
                voltageBin = 65535;
            end
            
        end
        fprintf(string(voltageBin))
        fprintf('B %1d;C %1d;M 3;D %5d;', floor((ic(2)-1)/2), mod(ic(2), 2), voltageBin)
        
        writeline(smdata.inst(ic(1)).data.inst, sprintf('B %1d;C %1d;M 3;D %5d;', floor((ic(2)-1)/2), mod(ic(2), 2), voltageBin))
        fprintf("Hello")
end
        
