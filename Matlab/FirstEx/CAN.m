%define ID for CANbus comunication
IDTemp = 300;   
IDHum = 400;
IDDew = 500;
c = 1;
d = 1;

%See ReadME and Thingspeak folder
readChId = XXXXXXX;  %Add your channel ID
readKey = 'XXXXXXXXXXXXXXXX'; %add Read API Key of your channel
%take data from my channel on thingspeak: 
%field 1: Temperature
%field 3: Dew Point
[dewPointData,timeStamps] = thingSpeakRead(readChId,'fields',3,...
    'NumPoints',20,'ReadKey',readKey);
[Temp,timeStamps] = thingSpeakRead(readChId,'fields',1,...
    'NumPoints',20,'ReadKey',readKey);


a = length(dewPointData);
b = length(Temp);
value = zeros(1,a);
value2 = zeros(1,b);


info = canChannelList;
BUSSPEED = 250000;

%hannel initialization: one for transmission(1) and one for reception(2).
canch1 = canChannel('MathWorks','Virtual 1',1);
canch2 = canChannel('MathWorks','Virtual 1',2);

%Busspeed of each channel
configBusSpeed(canch1, BUSSPEED);
canch1.BusSpeed;
configBusSpeed(canch2, BUSSPEED);

%start comunication channel
start(canch1);
start(canch2);

%Message creation according to the ID
messageout = canMessage(IDDew, false, 8);
messageout2 = canMessage(IDTemp, false, 8);

%Sending messages through the channell
for i = 1:a
    %Pack messages
    pack(messageout, double(dewPointData(i)), 0, 64, 'LittleEndian');
    messageout.Data;
    pack(messageout2, double(Temp(i)), 0, 64, 'LittleEndian');
    messageout2.Data;
    %transmit the messages trough channel1
    transmit(canch1, messageout);
    transmit(canch1, messageout2);
    canch1;  %Remove the semicolon to show the channel status
end


for j = 1:(a+b)
    canch2; %Remove the semicolon to show the channel status
    % receive the message trough the channel2
    messagein = receive(canch2,1);
    canch2;
    if messagein.ID == IDDew
        %Unpack a Message
        value(c) = unpack(messagein, 0, 64, 'LittleEndian', 'double')
        c = c+1;
    elseif messagein.ID == IDTemp
        value2(d)= unpack(messagein, 0, 64, 'LittleEndian', 'double')
        d = d +1;
    end

end

stop(canch1);
canch1
stop(canch2);
canch2

clear canch1;
clear canch2;

clear messageout;
clear messagein;

%Load Data into Simulink Using the From Workspace Block: "https://it.mathworks.com/help/simulink/ug/load-data-using-the-from-workspace-block.html ".
sampleTime = 5;
numSteps = 20;
time = sampleTime*(0:numSteps-1);
time = time';
secs = seconds(time);
%two variable
simin = timetable(secs, value');
simin2 = timetable(secs, value2');
%See Simulink folder


