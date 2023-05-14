%You read data from the public ThingSpeak channel 12397 - Weather Station, and write it into your new channel.
readChId = 12397;
%Add your channel ID AND Write API Key. See readme.
writeChId = XXXXXXX;
writeKey = 'XXXXXXXXXXXXXXXX';

%Read the humidity and temperature from the public WeatherStation channel Fields 3 and 4
[temp,time] = thingSpeakRead(readChId,'Fields',4,'NumPoints',20);
humidity = thingSpeakRead(readChId,'Fields',3,'NumPoints',20);

%Convert the temperature from Fahrenheit to Celsius.
tempC = (5/9)*(temp-32);

%Specify the constants for water vapor (b) and barometric pressure (c).
b = 17.62;
c= 243.5;
%Calculate the dew point in Celsius.
gamma = log(humidity/100) + b*tempC./(c+tempC);
dewPoint = c*gamma./(b-gamma)

%Write data to your channel.
thingSpeakWrite(writeChId,[temp,humidity,dewPoint],'Fields',[1,2,3],...
'TimeStamps',time,'Writekey',writeKey);
