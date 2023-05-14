function generateMsgsDb()
% generateMsgsDb Creates and transmits CAN messages for demo purposes.
%
%   generateMsgsDb periodically transmits multiple CAN messages at various
%   periodic rates with changing message data.
%

% Copyright 2008-2010 The MathWorks, Inc.

    % Access the database file.
    db = canDatabase('demoVNT_CANdbFiles.dbc');

    % Create the messages to send using the canMessage function.
    msgTxSunroof = canMessage(db, 'SunroofControlMsg'); 
    msgTxWindows = canMessage(db, 'WindowControlMsg');
    msgTxDoors = canMessage(db, 'DoorControlMsg');
    msgTxTrans = canMessage(db, 'TransmissionMsg');
    msgTxEngine = canMessage(db, 'EngineMsg');

    % Create a CAN channel on which to transmit.
    txCh = canChannel('MathWorks', 'Virtual 1', 1);

    % Register each message on the channel at a specified periodic rate.
    transmitPeriodic(txCh, msgTxSunroof, 'On', 0.500);
    transmitPeriodic(txCh, msgTxWindows, 'On', 0.250);
    transmitPeriodic(txCh, msgTxDoors, 'On', 0.125);
    transmitPeriodic(txCh, msgTxTrans, 'On', 0.050);
    transmitPeriodic(txCh, msgTxEngine, 'On', 0.025);
    
    % Start the CAN channel.
    start(txCh);
    
    % Run for several seconds incrementing the message data regularly.
    for ii = 1:50
        % Set new signal data.
        msgTxSunroof.Signals.OpenState = 1;
        msgTxWindows.Signals.DriverDoorWindow = 60 + (rand * 10);
        msgTxWindows.Signals.PassengerDoorWindow = 60 + (rand * 10);
        msgTxDoors.Signals.PassengerDoorLock = rand;
        msgTxDoors.Signals.DriverDoorLock = rand;
        msgTxTrans.Signals.Gear = 4 + rand;
        msgTxEngine.Signals.VehicleSpeed = 50 + (rand * 5);
        msgTxEngine.Signals.EngineRPM = 3500 + (rand * 250);
    
        % Wait for a time period.
        pause(0.100);
    end

    % Stop the CAN channel.
    stop(txCh);
end