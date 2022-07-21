function val = smcSR770(ic, val)
%Driver for the SR770


global smdata;


% Good to know values for further developing drivers here: 
%
% ic(1): Instrument Index
% ic(2): Channel Index, with each channel corresponding to desired value to
% set or get
% ic(3): Value (0 or 1), 0 - GET, 1 - SET
% 

%CURRENT CHANNEL AND WHAT IT DOES:
%%%%%%%%%%%%
% Format:
% #: (COMMAND IN SR) FUNCTIONALITY (MANUAL PAGE)
%%%%%%%%%%%%

% 1: (MEAS) Changes/Gets the measurement type on the current channel (5-6)
%     values: {0: Spectrum, 1: PSD, 2: Time Record, 3: Octave Ana.}


% 2: (SPED)Gets the Raw Data on the Table in Binary (5-23)



cmds = {'MEAS -1', 'SPEC -1','SPEB -1', 'BVAL -1'};


switch ic(2) % Channels
    case 1 % MEAS
        switch ic(3) % Operation (GET or SET)
            case 1 %SET
                
                fprintf(smdata.inst(ic(1)).data.inst, sprintf('%s %d,%d', cmds{ic(2)}, -1, val));
                
            case 0 %GET
                 val = query(smdata.inst(ic(1)).data.inst, sprintf('%s?%s',...
                    cmds{ic(2)}(1:4), cmds{ic(2)}(5:end)), '%s\n', '%f');
              
                
            otherwise
                error('Operation Not Supported!');
        end

     case 2 % SPEC
        switch ic(3) % Operation (GET or SET)
            case 1 %SET
                error("Set Command for SPEC is not supported (Manual Page 5-23)")
            case 0 %GET
                %Queries the data displayed on the screen. The result is a
                %400 * 1 double. Note the '%f,' at the end, reference 5-23
                %for further information.
                val = query(smdata.inst(ic(1)).data.inst, sprintf('%s?%s',...
                    cmds{ic(2)}(1:4), cmds{ic(2)}(5:end)), '%s\n', '%f,');            
            otherwise
                error('Operation Not Supported!');
        end

    case 3 % SPEB
        switch ic(3) % Operation (GET or SET)
            case 1 %SET
                error("Set Command for SPEB is not supported (Manual Page 5-23)");
            case 0 %GET

           % Queues Command to Read Raw Data
             fprintf(smdata.inst(ic(1)).data.inst, sprintf('%s?%s',...
                   cmds{ic(2)}(1:4), cmds{ic(2)}(5:end)));
           % There are 800 data points (Refer to 5-23)
           val = fread(smdata.inst(ic(1)).data.inst, 800, 'int8');
           
           val = SR770SPEBtodec(val);
            otherwise
                error('Channel Not Supported!');
        end
     case 4 % 
        switch ic(3) % Operation (GET or SET)
            case 1 %SET
                error("Set Command for BVAL is not supported (Manual Page 5-23)")
            case 0 %GET

                %%%%%%%%%%%%%%%%%
                %Don't Worry about this part
                % Queues Command to Read Raw Data
                %  fprintf(smdata.inst(ic(1)).data.inst, sprintf('%s?%s',...
                %       cmds{ic(2)}(1:4), cmds{ic(2)}(5:end)));
                % There are 800 data points (Refer to 5-23)
                % val = fread(smdata.inst(ic(1)).data.inst, 800, 'int8');
                %
                %freq0 = query(smdata.inst(ic(1)).data.inst, sprintf('%s?%s %s%d',...
                %cmds{ic(2)}(1:4), cmds{ic(2)}(5:end),",", 0), '%s\n', '%f');
                %
                %freq399 = query(smdata.inst(ic(1)).data.inst, sprintf('%s?%s %s%d',...
                %cmds{ic(2)}(1:4), cmds{ic(2)}(5:end),",", 399), '%s\n', '%f');
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                %Obtain the Start Frequency
                startfreq = query(smdata.inst(ic(1)).data.inst, "STRF?", '%s\n', '%f');
                %Obtain the Center Frequency
                centerfreq = query(smdata.inst(ic(1)).data.inst, "CTRF?", '%s\n', '%f');
                %Create a evenly spaced array based on the start and center
                %frequency
                val = linspace(startfreq, centerfreq * 2 - startfreq, 401);
                val = val(1:400);
            otherwise
                error('Channel Not Supported!');
        end
    case {5,6} %The other Cases to be added Here and below!
        switch ic(3) % Operation (GET or SET)
            case 1 %SET
                
                fprintf(smdata.inst(ic(1)).data.inst, sprintf('%s %d,%d', cmds{ic(2)}, -1, val));
              
            case 0 %GET
                 val = query(smdata.inst(ic(1)).data.inst, sprintf('%s?%s',...
                    cmds{ic(2)}(1:4), cmds{ic(2)}(5:end)), '%s\n', '%f');
              
                
            otherwise
                error('Operation Not Supported!');
        end

    otherwise
        error('Channel Not Supported!');
end


function value = SR770SPEBtodec(initval)
  binraw = dec2bin(initval);

  %Not the most efficient but there's just 800 bytes
  for i = 1:400
     binval(i,:) = strcat(binraw(2*i,:),binraw(2*i-1,:));
  end
  decval = bin2dec(binval);
  convertedval_log = (decval * 3.0103)/512 - 114.3914;


  value = convertedval_log;

