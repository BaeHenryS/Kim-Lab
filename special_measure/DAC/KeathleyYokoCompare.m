xaxis = finaldata.xaxis;

ykeathley = finaldata.keathley;

yyoko = finaldata.yoko;

ydac = newdata{1,2};
ydac = ydac + 34.526600000001070;

ydac = ydac(1:8641,:);

plot(xaxis, ykeathley, xaxis, yyoko, xaxis, ydac)
legend('Keathley', 'Yoko', 'DAC')


combineddata.x = xaxis;
combineddata.ykeathley = ykeathley;
combineddata.yyoko = yyoko;
combineddata.ydac = ydac;

uisave('combineddata','LongTerm_Trial1_Final.mat');


