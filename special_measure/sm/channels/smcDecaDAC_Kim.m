<<<<<<< HEAD
function val = smcDecaDAC4(ic, val, rate)
% With ramp support and new trigger scheme. Odd channels are ramped.
% Improved error treatment compared to smcdecaDAC3.m
global smdata;


if smdata.inst(ic(1)).channels(ic(2), 1) == 'S'
    
    switch ic(3) %Get Or Set
        case 1 %Set
            query(smdata.inst(ic(1)).data.inst, 'X0;'); % clear buffer to avoid overflows
            if val > 0
                pause(.02); % seems to help avoiding early triggers.           
                fprintf(smdata.inst(ic(1)).data.inst, '%s', sprintf('X%d;', val));
            end
            %Get
            
            % suppress terminator which would stop the script
            smdata.inst(ic(1)).data.scriptaddr = val;
            %if val==0
            %    query(smdata.inst(ic(1)).data.inst, ''); % send terminator and read response
            %    %smflush(ic(1));
            %end
            val = 0;

        case 0
            val = smdata.inst(ic(1)).data.scriptaddr;
    end
    return;
end


rng = smdata.inst(ic(1)).data.rng(floor((ic(2)-1)/2)+1, :);


switch ic(3)
    case 1

        val = round((val - rng(1))/ diff(rng) * 65535);
        val = max(min(val, 65535), 0);
                
        if mod(ic(2)-1, 2) % ramp
            rate2 = int32(abs(rate / diff(rng)) * 2^32 * 1e-6 * smdata.inst(ic(1)).data.update(floor((ic(2)+1)/2)));
                
            curr = dacread(smdata.inst(ic(1)).data.inst, ...
                sprintf('B%1d;C%1d;d;', floor((ic(2)-1)/8), floor(mod(ic(2)-1, 8)/2)), '%*7c%d');

            if curr < val
                if rate > 0
                    dacwrite(smdata.inst(ic(1)).data.inst, sprintf('G8;U%05d;S%011d;G0;', val, rate2));
                else
                    dacwrite(smdata.inst(ic(1)).data.inst, sprintf('G%02d;U%05d;S%011d;', ...
                        smdata.inst(ic(1)).data.trigmode, val, rate2));
                end
            else
                if rate > 0
                    dacwrite(smdata.inst(ic(1)).data.inst, sprintf('G8;L%05d;S%011d;G0;', val, -rate2));
                else
                    dacwrite(smdata.inst(ic(1)).data.inst, sprintf('G%02d;L%05d;S%011d;', ...
                        smdata.inst(ic(1)).data.trigmode, val, -rate2));
                end
            end
            val = abs(val-curr) * 2^16 * 1e-6 * smdata.inst(ic(1)).data.update(floor((ic(2)+1)/2)) / double(rate2); 
            
        else
            dacwrite(smdata.inst(ic(1)).data.inst, ...
                    sprintf('B%1d;C%1d;D%05d;', floor((ic(2)-1)/8), floor(mod(ic(2)-1, 8)/2), val));
            val = 0;
        end


    case 0      
        val = dacread(smdata.inst(ic(1)).data.inst, ...
            sprintf('B%1d;C%1d;d;', floor((ic(2)-1)/8), floor(mod(ic(2)-1, 8)/2)), '%*7c%d');
        val = val*diff(rng)/65535 + rng(1);
        
    case 3        
        dacwrite(smdata.inst(ic(1)).data.inst, sprintf('B%1d;C%1d;G0;', floor((ic(2)-1)/8), floor(mod(ic(2)-1, 8)/2)));
        
    otherwise
        error('Operation not supported');

end
        
function dacwrite(inst, str)
try
    query(inst, str);
catch
    fprintf('WARNING: error in DAC communication. Flushing buffer.\n');
    while inst.BytesAvailable > 0
        fprintf(fscanf(inst));
    end
end

function val = dacread(inst, str, format)
if nargin < 3
    format = '%s';
end

i = 1;
while i < 10
    try
        val = query(inst, str, '%s\n', format);
        i = 10;
    catch
        fprintf('WARNING: error in DAC communication. Flushing buffer and repeating.\n');
        while inst.BytesAvailable > 0
            fprintf(fscanf(inst))
        end

        i = i+1;
        if i == 10
            error('Failed 10 times reading from DAC')
        end
    end
end
=======
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
        
>>>>>>> 69f74633621a0072ed3a03368dbde7bd0bc9ad0f
