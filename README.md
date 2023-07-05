# DAC Project Setup

This documents how to set up the DAC and other instruments on Special Measure.

#  1. SR770

This section documents using the SR770 with Special Measure.

## 1.1: Channel and Instrument Setup
To load the SR770 into your own channel file: 
1. Load Special Measure Folder in MATLAB
2.  Load the channel 
	-	Type`smguichannels` 
	-	Click **Open Rack**
	-	Open `DACrack.mat`
3. Save the Instrument and Channel
		`sr770inst = smdata.inst(18)`
		 `sr770chan = smdata.channels(4)`
4. Type`smguichannels` and load your own rack
5. Add the SR770 to the Rack
`smdata.inst(19) = sr770inst`
`smdata.channels(5) = sr770chan`
	(Remember to change the numbers to the appropriate empty slot in the instrument)

> **Make sure to**:
> - Correctly set GPIB Primary Address:
> Ex:  `smdata.inst(18).data.inst=gpib('NI',0,10)`
> - The Buffer Size is Greater than 800
> `smdata.inst(18).data.inst.inputBufferSize = 8192`
>(Again, switch 18 with the appropriate instrument number.)

## 1.2: Getting Data Using Special Measure

Entering `smguichannels`, there are currently three channels on the SR770. 
1. MEAS - Changes the Measurement Type
2. SPEC - Gets the y-value of the displayed graph in Float. 
3. SPEB - Gets the y-value of the displayed graph (in Binary Value. In most cases, use SPEC above)
4. BVAL - Gets the x-value of the displayed graph

Currently, there is a MATLAB function, `smsr770.m` automatically pulls currently displayed data into a plot and creates a `.mat` data file. Put this inside the `sm` folder and run
`smsr770(ChannelNumber)` with the appropriate channel number. 

# 2. DAC

## Setup in Special Measure

Using the DAC requires Python. Most installations are okay. Here are the steps to make it work with Anaconda:

1. Install Anaconda
2. Open Anaconda Navigator
3. Create a new environment
4. Enable package: `pyserial`

Now to setting up MATLAB:
- Go to to MATLAB and type:

`pyenv("Version","C:\Users\APPROPRIATE_FILE_PATH\python.exe")`

- Check that everything is good by typing `pyenv`

- Make sure that the execution mode is "OutofProcess" by typing:
`pyenv("ExecutionMode", "OutOfProcess")`

- Now take the `dacset.py` file into the system path of python. To check the locations, type:
`py.sys.path`

- Restart MATLAB and check that the Python file has been loaded by typing:
`py.importlib.import_module('dacset');`

- If there aren't any errors, we are set on the Python MATLAB link. 
- Move the `smcNUDAC.m` to the `./sm/channels`folder. 

Now a similar process to load the DAC "instrument" and channel:
1.  Load the channel 
	-	Type`smguichannels` 
	-	Click **Open Rack**
	-	Open `DACrack.mat`
2. Save the Instrument and Channel
		`NUDACinst = smdata.inst(19)`
		 `NUDACchan = smdata.channels(5)`
4. Type`smguichannels` and load your own rack
5. Add the SR770 to the Rack
`smdata.inst(19) = sr770inst`
`smdata.channels(5) = sr770chan`
	(Here, remember to change the numbers to the appropriate empty slot in the instrument)


> Note on using the DAC on smgui: 
> **!!** Make sure that the **step time** is 0 which makes the **point rate** is Inf. The **Wait**, **Start**, **Step** should be adjusted instead. 




