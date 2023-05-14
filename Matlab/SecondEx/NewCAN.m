%def ID messages
IDTemp = 300;
IDHum = 400;
IDDew = 500;
IDError = 001;
ErrorFrame = 00000000;
c = 1;
d = 1;
n = 1;
i = 1;
readChId = 1773637;
readKey = '24U05LWD04FXFW34';

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
%Create two CAN channels
canch1 = canChannel('MathWorks','Virtual 1',1);
canch2 = canChannel('MathWorks','Virtual 1',2);

%configBusSpeed(canch1, BUSSPEED);
%canch1.BusSpeed;
%configBusSpeed(canch2, BUSSPEED);
%canch2.BusSpeed;

%Start the two CAN channels
start(canch1)
start(canch2)
%creating our CAN Messages Objects
messageoutDew = canMessage(IDDew, false, 8);
messageoutTemp = canMessage(IDTemp, false, 8);
messageoutError = canMessage(IDError, false, 8);
messageACK = canMessage(IDDew, false, 8);
%send dewdatapoint, wait for ack and send again
while n <= a
    canch1
    if n ~= 1 && n ~= 5
        pause(0.5)
        messageinack = receive(canch1,2);
        if messageinack(1).ID == messageinack(2).ID
            pack(messageoutDew, double(dewPointData(i)), 0, 64, 'LittleEndian');
            messageoutDew.Data;
            transmit(canch1, messageoutDew);
            i = i+1;
        elseif messageinack(2).ID == IDError
            pack(messageoutDew, double(dewPointData(i)), 0, 64, 'LittleEndian');
            messageoutDew.Data;
            transmit(canch1, messageoutDew);
            i = i+1;
            n = n-1;
        end
    elseif n == 5
        pause(0.5)
        messageinack = receive(canch1,2);
            pack(messageoutTemp, 0, 0, 64, 'LittleEndian');
            messageoutTemp.Data;
            transmit(canch1, messageoutTemp);
    else
        pack(messageoutDew, double(dewPointData(i)), 0, 64, 'LittleEndian');
        messageoutDew.Data;
        transmit(canch1, messageoutDew);
        i = i+1;
    end
    
    canch1
    % receive the message
    canch2
    %pause(10)
    pause(0.5)
    if n==1
        messageinDew = receive(canch2,1), 
        canch2
        value(c) = unpack(messageinDew, 0, 64, 'LittleEndian', 'double');
        c = c+1;
        pack(messageACK, 0, 0, 64, 'LittleEndian')
        messageACK.Data;
        transmit(canch2, messageACK);
    elseif n ~= 1
        messageinDeww = receive(canch2, 2);
        if messageinDeww(2).ID == IDDew
            %Unpack a Message
            value(c) = unpack(messageinDeww(2), 0, 64, 'LittleEndian', 'double');
            c = c+1;
            pack(messageACK, 0, 0, 64, 'LittleEndian')
            messageACK.Data;
            transmit(canch2, messageACK);
        elseif messageinDeww(2).ID ~= IDDew
            pack(messageoutError, ErrorFrame,0, 64, 'LittleEndian');
            messageoutError.Data;
            transmit(canch2, messageoutError);
        end
    end
    canch2
    n = n+1
end




