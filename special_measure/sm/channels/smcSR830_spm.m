function [val, rate] = smcSR830_spm(ic, val, rate, ctrl)
% [val, rate] = smcSR830(ic, val, rate, ctrl)
% ctrl: sync (each sample triggered)
%       trig external trigger starts acq.
% 1: X, 2: Y, 3: R, 4: Theta, 5: freq, 6: ref amplitude
% 7:10: AUX input 1-4, 11:14: Aux output 1:4
% 15,16: stored data, length determined by datadim
% 17: sensitivity 
% 18: overload 

global smdata;
        
cmds = {'OUTP 1', 'OUTP 2', 'OUTP 3', 'OUTP 4', 'FREQ', 'SLVL', 'OAUX 1', 'OAUX 2',...
'OAUX 3','OAUX 4', 'AUXV 1', 'AUXV 2', 'AUXV 3', 'AUXV 4','','','SENS', 'OFLT', 'SYNC'};

switch ic(2) % Channel
    case {15, 16} % Stored data, length determined by datadim
        switch ic(3)
            case 0  % get              
                npts = smdata.inst(ic(1)).datadim(ic(2), 1);
                while 1
                    navail = query(smdata.inst(ic(1)).data.inst, 'SPTS?', '%s\n', '%d');
                    if navail >= npts + smdata.inst(ic(1)).data.currsamp
                        break;
                    else
                        pause(0.8 * (npts + smdata.inst(ic(1)).data.currsamp - navail) ...
                            * smdata.inst(ic(1)).data.sampint);
                    end
                end                
%                 fprintf(smdata.inst(ic(1)).data.inst, 'TRCB? %d, %d, %d', ...
%                     [ic(2)-14, smdata.inst(ic(1)).data.currsamp+[0, npts]]);
                fprintf(smdata.inst(ic(1)).data.inst, 'TRCL? %d, %d, %d', ...
                    [ic(2)-14, smdata.inst(ic(1)).data.currsamp+[0, npts]]);
                pause(0.1);
%                 val = fread(smdata.inst(ic(1)).data.inst, npts, 'single');
                % TRCL returns 32 bit integer.
                % First byte is zero. Second byte is exponent. Final two
                % bytes are mantissa
                % Formula to recover numerical value is:
                % value = mantissa*2^(exp-124).
                % SR830 gives the mantissa in 16 bit twos complement
                output_int = fread(smdata.inst(ic(1)).data.inst, npts, 'uint32');
                output = dec2bin(output_int,32);
                % Calculate the mantissa with two's complement
                val = twoscomp16(output(:,17:32)).*2.^(bin2dec(output(:,1:16))-124);
                pause(0.1);
%                 smdata.inst(ic(1)).data.currsamp =  smdata.inst(ic(1)).data.currsamp + npts;                
            case 3
                if ~strcmp(smdata.inst(ic(1)).data.state,'triggered')
                    fprintf(smdata.inst(ic(1)).data.inst, 'STRT');
                    smdata.inst(ic(1)).data.state = 'triggered';
                end
            case 4
                if ~strcmp(smdata.inst(ic(1)).data.state,'armed')
                    fprintf(smdata.inst(ic(1)).data.inst, 'REST');
                    smdata.inst(ic(1)).data.currsamp = 0;
                    smdata.inst(ic(1)).data.state = 'armed';
                    pause(.1); %needed to give instrument time before next trigger, anything much shorter leads to delays.                
                end
            case 5
                if exist('ctrl','var') && strfind(ctrl, 'sync')
                    n = 14;
                else
                    n = round(log2(rate)) + 4;
                    rate = 2^-(4-n);
                    if n < 0 || n > 13
                        error('Samplerate not supported by SR830');
                    end
                end
                fprintf(smdata.inst(ic(1)).data.inst, 'REST; SEND 1; TSTR 1; SRAT %i', n);
                pause(.1);
                smdata.inst(ic(1)).data.currsamp = 0;
                smdata.inst(ic(1)).data.sampint = 1/rate;
                smdata.inst(ic(1)).datadim(15:16, 1) = val;
                smdata.inst(ic(1)).data.state = 'reset';
            otherwise
                error('Operation not supported');                
        end
    otherwise
        switch ic(3) % action
            case 1 % set
                if ic(2)==17
                    val = SR830sensindex(val);
                elseif ic(2)==18
                    val = SR830tauindex(val);
                end
                fprintf(smdata.inst(ic(1)).data.inst, sprintf('%s %f', cmds{ic(2)}, val));
            case 0 % get
                val = query(smdata.inst(ic(1)).data.inst, sprintf('%s? %s',cmds{ic(2)}(1:4), cmds{ic(2)}(5:end)), '%s\n', '%f');
                if ic(2)==17
                    val = SR830sensvalue(val);
                elseif ic(2)==18
                    val = SR830tauvalue(val);
                end
            otherwise
                error('Operation not supported');
        end
end

function val = SR830sensvalue(sensindex)
% converts an index to the corresponding sensitivity value for the SR830 lockin.
x = [2e-9 5e-9 10e-9];
sensvals = [x 1e1*x 1e2*x 1e3*x 1e4*x 1e5*x 1e6*x 1e7*x 1e8*x 1e9*x];
val = sensvals(sensindex+1);

function sensindex = SR830sensindex(sensval)
% converts a sensitivity to a corresponding index that can be sent to the
% SR830 lockin.  rounds up (sens = 240 will become 500)
x = [2e-9 5e-9 10e-9];
sensvals = [x 1e1*x 1e2*x 1e3*x 1e4*x 1e5*x 1e6*x 1e7*x 1e8*x 1e9*x];
sensindex = find(sensvals >= sensval,1)-1;

function val = SR830tauvalue(tauindex)
% converts an index to the corresponding sensitivity value for the SR830 lockin.
x = [10e-6 30e-6];
tauvals = [x 1e1*x 1e2*x 1e3*x 1e4*x 1e5*x 1e6*x 1e7*x 1e8*x 1e9*x];
val = tauvals(tauindex+1);

function tauindex = SR830tauindex(tauval)
% converts a time constant to a corresponding index that can be sent to the
% SR830 lockin.  rounds up (tau = 240 will become 300)
x = [10e-6 30e-6];
tauvals = [x 1e1*x 1e2*x 1e3*x 1e4*x 1e5*x 1e6*x 1e7*x 1e8*x 1e9*x];
tauindex = find(tauvals >= tauval,1)-1;

function output = twoscomp16(input16)
% Gets the 16-bit two's complement of an integer input
% Needed for conversion in the TRCL command format
% input16 should be a 16 bit binary string array
mask = ['1' repmat('0', 1, 15)];
nvals = length(input16);
output = bin2dec(reshape(sprintf(repmat('%i', nvals, 16)', ...
    int8(logical(input16'-'0')' & repmat(~logical(mask(:)'-'0'),nvals,1))), nvals, 16)) ...
    - bin2dec(reshape(sprintf(repmat('%i', nvals, 16)', ...
    int8(logical(input16'-'0')' & repmat(logical(mask(:)'-'0'),nvals,1))), nvals, 16));