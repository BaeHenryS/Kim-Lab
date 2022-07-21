function sr770data = smsr770(channel)
    
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

data = {x{1,1},y{1,1}};


%uisave('data','SR770')

time = datestr(now, 'yyyy_mm_dd_HH_MM_SS');
filename = sprintf('SR770Data_%s.mat',time);

uisave('data',filename);


plot(data{1,1}, data{1,2})
sr770data = data;




