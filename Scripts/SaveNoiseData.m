
Noise20220721_1.x_100k = x_100k;
Noise20220721_1.x_195 = x_195;

Noise20220721_1.dacv0_100k_1v_001 = dacv0_100k_1v_001;
Noise20220721_1.dacv0_100k_1v_002 = dacv0_100k_1v_002;

Noise20220721_1.dacv0_195_1v_001 = dacv0_195_1v_001;
Noise20220721_1.dacv0_195_1v_002 = dacv0_195_1v_002;



Noise20220721_1.yoko_100k_1v_001 = yoko_100k_1v_001;
Noise20220721_1.yoko_100k_1v_002 = yoko_100k_1v_002;

Noise20220721_1.yoko_195_1v_001 = yoko_195_1v_001;
Noise20220721_1.yoko_195_1v_002 = yoko_195_1v_002;


Noise20220721_1.keithley_100k_1v_001 = keithley_100k_1v_001;
Noise20220721_1.keithley_100k_1v_002 = keithley_100k_1v_002;

Noise20220721_1.keithley_195_1v_001 = keithley_195_1v_001;
Noise20220721_1.keithley_195_1v_002 = keithley_195_1v_002;

Noise20220721_1.comments = char('Noise Measured at 20220721_2000 at the Electronics Bench at Kim Lab.', ...
    'Used the BNC cable labeled: Noise01. Nobody at the lab except me when taking the measurements', ...
    'Measure: PSD, Display: Log Mag, Units: Volts RMS, Window: Uniform.', ...
    'Took measurement from 0 - 100 kHz, and 0 - 195 Hz', ...
    'Clicked Auto Range and Auto Scale each time the measurement was taken', ...
    'Turned on Averaging with 1000 Number Averages, in Linear Average Mode, RMS Average Type', ...
    'Data Point at 0 Redacted for Better Illustration');

uisave('Noise20220721_1','Noise20220721_1.mat');



