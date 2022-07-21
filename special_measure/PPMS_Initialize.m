global PPMS;

% Assembly File generation from DLL
AssemblyFile = NET.addAssembly('c:\QDInstrument_LabVIEW\QDInstrument.dll');

%Creation and Initialization of Instance for Instrument Type
PPMS.HandleInstrumentType = AssemblyFile.AssemblyHandle.GetType('QuantumDesign.QDInstrument.QDInstrumentBase+QDInstrumentType');
PPMS.InstrumentType = System.Activator.CreateInstance(HandleInstrumentType);
PPMS.InstrumentType = QuantumDesign.QDInstrument.QDInstrumentType.PPMS;

% Creation of Instance to communicate with the PPMS
PPMS.Instrument = QuantumDesign.QDInstrument.QDInstrumentFactory.GetQDInstrument(QuantumDesign.QDInstrument.QDInstrumentType.PPMS, false, '127.0.0.1');

%Creating Instance to store temperature status
PPMS.handleTemperatureStatus = AssemblyFile.AssemblyHandle.GetType('QuantumDesign.QDInstrument.QDInstrumentBase+TemperatureStatus');
PPMS.TemperatureStatus = System.Activator.CreateInstance(handleTemperatureStatus);

%Creating Instance to store Field status
PPMS.handleFieldStatus = AssemblyFile.AssemblyHandle.GetType('QuantumDesign.QDInstrument.QDInstrumentBase+FieldStatus');
PPMS.FieldStatus = System.Activator.CreateInstance(handleFieldStatus);

%Creating Instance to store FieldApproach
%PPMS.handleFieldApproach = AssemblyFile.AssemblyHandle.GetType('QuantumDesign.QDInstrument.QDInstrumentBase+FieldApproach');
%PPMS.FieldApproach = System.Activator.CreateInstance(PPMS.handleFieldApproach);
PPMS.FieldApproach = QuantumDesign.QDInstrument.FieldApproach.Linear;

%Creating Instance to store TemperatureApproach
%PPMS.handleTemperatureApproach = AssemblyFile.AssemblyHandle.GetType('QuantumDesign.QDInstrument.QDInstrumentBase+TemperatureApproach');
%PPMS.TemperatureApproach = System.Activator.CreateInstance(handleTemperatureApproach);
PPMS.TemperatureApproach = QuantumDesign.QDInstrument.TemperatureApproach.FastSettle;

%Creating Instance to store FieldApproach
%PPMS.handleFieldApproach = AssemblyFile.AssemblyHandle.GetType('QuantumDesign.QDInstrument.QDInstrumentBase+FieldApproach');
%PPMS.FieldMode = System.Activator.CreateInstance(PPMS.handleFieldApproach);
PPMS.FieldMode = QuantumDesign.QDInstrument.FieldMode.Driven;

