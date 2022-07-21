test1 = dec2bin(ans{1,1});

for i = 1:400
    test2(i,:) = strcat(test1(2*i,:),test1(2*i-1,:));


end

 test3 = bin2dec(test2);

 test4 = (test3 * 3.0103)/512 - 114.3914;
 
 plot(test4)


