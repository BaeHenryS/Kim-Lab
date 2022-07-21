rawdata = data{1,1};
shifteddata = rawdata-1;
lsbdata = shifteddata / (20 / 1000000);

timestamp = linspace(0,48, 17281);

plot(lsbdata)
title('NUDAC Long Term Plot, 20\muV LSB')
xlabel('Hours')
ylabel('Error (LSB)')

newdata = {timestamp, lsbdata};

filename = 'Keathley2400LongTermPlot_1';

uisave('newdata',filename);
