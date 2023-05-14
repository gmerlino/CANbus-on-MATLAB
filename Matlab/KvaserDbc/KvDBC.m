db = canDatabase("ProvaDBCF.dbc")
db.Messages;
%message info
messageInfo(db, "EngineMsg");
messageInfo(db, "DewPointMsg");
messageInfo(db);

%view signal Information
signalInfo(db, "EngineMsg", "EngineRPM");
signalInfo(db, "DewPointMsg", "DewPoint");
signalInfo(db, "EngineMsg");
signalInfo(db, "DewPointMsg");
%create Message Using Database Deinitions
msgEngineInfo = canMessage(db, "EngineMsg");
msgEngineInfo2 = canMessage(db, "DewPointMsg");
%view Signal Information
msgEngineInfo.Signals;
msgEngineInfo2.Signals;
%change Signal Information
msgEngineInfo.Signals.EngineRPM = 5000
msgEngineInfo.Signals;
msgEngineInfo.Signals.VehicleSpeed = 63
msgEngineInfo.Signals

msgEngineInfo2.Signals.Temperature = 18;
msgEngineInfo2.Signals;
msgEngineInfo2.Signals.DewPoint = 63;
msgEngineInfo2.Signals;

%Receive Messages 
rxCh = canChannel("MathWorks", "Virtual 1", 2);
rxCh.Database = db;

%start channel
start(rxCh);
generateMsgsDb2();
rxMsg = receive(rxCh, Inf, "OutputFormat", "timetable");

%View the first few rowa of received messages
head(rxMsg);

%stop the channel
stop(rxCh);
clear rxCh

%examine a Received Message
rxMsg(10, :);
rxMsg.Signals(10);

%extract All Instances of a Specified Message
allMsgEngine = rxMsg(strcmpi("EngineMsg", rxMsg.Name), :);
head(allMsgEngine);

%plot Physical Signal Values
signalTimetable = canSignalTimetable(rxMsg, "EngineMsg");
head(signalTimetable);
signalTimetable2 = canSignalTimetable(rxMsg, "DewPointMsg");

%plot the values of signal VehicleSpeed
figure(1)
plot(signalTimetable2.Time, signalTimetable2.DewPoint)
title("DewPoint from DewPOintMsg", "FontWeight", "bold")
xlabel("Timestamp")
ylabel("DewPoint")

figure(2)
plot(signalTimetable.Time, signalTimetable.VehicleSpeed)
title("Vehicle Speed from EngineMsg", "FontWeight", "bold")
xlabel("Timestamp")
ylabel("Vehicle Speed")
%close the DBC-file
clear db

