function val = smctest(ic, value, rate)

global smdata;
global dacinit

switch ic(3)
    case 1
        %Checking if Python is installed
        pe = pyenv;
        if isempty(pe.Version)
            disp 'Python not installed! Run the command: pyenv("Version","Your Path to Python")'
        end

        if dacinit ~= 1
            py.importlib.import_module('dacset');
            py.dacset.initialize()
            disp 'Initialized!'
            dacinit = 1;
        end

        
        
        
        py.dacset.setVoltage(value)
        disp(append('Voltage Set to ', string(value) , ' Volts'))

    
    case 0
       % disp(ic)
      %  val = smdata.inst(ic(1)).data.val(ic(2));

        if dacinit ~= 1
            py.importlib.import_module('dacset');
            py.dacset.initialize()
            disp 'Initialized!'
            dacinit = 1;
        end
        val = 1;
        %error('Set the Voltage!')
    otherwise
        error('Operation not supported');
end