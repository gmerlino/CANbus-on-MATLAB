%Open DBC-Files
db = canDatabase("demoVNT_CANdbFiles.dbc");
db.Messages
%message info
messageInfo(db, "EngineMSG");
messageInfo(db);
%view signal Information
signalInfo(db, "EngineMsg", "EngineRPM");
%signalInfo(db, "EngineMSg", "")
signalInfo(db, "EngineMsg");
%create Message Using Database Deinitions
msgEngineInfo = canMessage(db, "EngineMsg");
%view Signal Information
msgEngineInfo.Signals;
%change Signal Information
msgEngineInfo.Signals.EngineRPM = 5000;
msgEngineInfo.Signals;
msgEngineInfo.Signals.VehicleSpeed = 63;
msgEngineInfo.Signals;
%Receive Messages 
rxCh = canChannel("MathWorks", "Virtual 1", 2);
rxCh.Database = db;
%start channel
start(rxCh);
generateMsgsDb();
rxMsg = receive(rxCh, Inf, "OutputFormat", "timetable")
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
head(allMsgEngine)

%plot Physical Signal Values
signalTimetable = canSignalTimetable(rxMsg, "EngineMsg");
head(signalTimetable)

%plot the values of signal VehicleSpeed
plot(signalTimetable.Time, signalTimetable.VehicleSpeed)
title("Vehicle Speed from EngineMsg", "FontWeight", "bold")
xlabel("Timestamp")
ylabel("Vehicle Speed")

%close the DBC-file
clear db
