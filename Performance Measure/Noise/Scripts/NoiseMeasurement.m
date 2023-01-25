function NoiseMeasurement = NoiseMeasurement(channel)
    
global smdata;

if(isempty(channel))
    error("Please Provide a Channel for the SR770")
end
if ~isnumeric(channel)
    channel = smchanlookup(channel);
end

nchan = length(channel);

if(nchan > 1)
    error("Only one channel at the time please!")
end

%Getting the Channel Name
channame = smdata.channels(channel).name;
%Getting the Original instchan
originstchan = vertcat(smdata.channels(channel).instchan);

%Getting the Instrument Number
instrumentnum = originstchan(1,1);

%First Change the Channel to the x-value 
smdata.channels(channel).instchan = [instrumentnum, 4];
x = smget(channame);

%Change the Channel to get the y-value
smdata.channels(channel).instchan = [instrumentnum, 2];
y = smget(channame);



%data = {x{1,1},y{1,1}};



plot(x{1,1},y{1,1})
NoiseMeasurement = y{1,1};