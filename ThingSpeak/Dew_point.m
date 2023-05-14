
readChId = XXXXXXX
readKey = 'xXXXXXXXXXXXXXXXX';

[dewPointData,timeStamps] = thingSpeakRead(readChId,'fields',[1,2,3],...
    'NumPoints',20,'ReadKey',readKey);

    plot(timeStamps,dewPointData);
xlabel('TimeStamps');
ylabel('Measured Values');
title('Dew Point Measurement');
legend({'Temperature','Humidity','Dew Point'});
grid on;