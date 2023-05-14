# IoT-Project

## Introduction

CAN bus is the acronym for Controller Area Network. In order to understand how this standard works, suppose your car is like a human body and CAN bus is the nervous system which allows to enable communication between different parts of the body. Communication happens between different CAN bus ‘nodes', which also act as ‘Electronic control units’ (ECUs). The CAN bus was developed by BOSCH as a multi-master message broadcast system.
The goal was making cars more reliable and safer in order to allow robust serial communication.

The CAN protocol has great popularity in industrial automation, automotive-truck applications and in small quantities in the medical field.

## Table of contents

* [Project](#project)
* [Technologies](#technologies)
* [Knowledge Required](#knowledge-required)
* [Documentation](#Documentation)
* [Simple CAN](#Simple-CAN)
* [New CAN](#New-CAN)
* [DBC-File](#Dbc-File)
* [Kvaser Example](#Kvaser-Example)

## Project

Some examples will be discussed later to better understand the functioning of the CAN protocol by analyzing some of its characteristics, such as a detailed study of the transported data by the CAN frames, the acknowledge and also sniffing of achieved packages starting from already known data.

Here is a bullet list of the examples that will be analyzed:

* Data collection from public channel (temperature and humidity)
* Calculation of the dew point and data analysis
* Reading the quantities from ThingSpeak to MATLAB
* Transmission, reception and tracking of values by simulating a CANbus network through MathWorks Virtual Channels
* Creation DBC-File using Kvase Database Editor
* Simulate a communication through the Virtual Channel by using a real Database CAN

## Technologies

Project is created with:
* Matlab: R2022a
* [ThingSpeak][1]
* [Simulink][3]
* [Vehicle Network Toolbox][15]
* [Kvaser Database Editor 3][18]
	
## Knowledge Required

* [MatLab][2]
* [Simulink][3]
* [CANbus][16]
* [ThingSpeak][1]
* [Kvaser Database Editor][15]

## Documentation
All examples are contained within the [documentation][35].

The first chapter talks about the CAN bus in general:
* A simple introduction
* CAN Standard
* CAN Definition
* CAN bus protocol characteristic
* how to sniff CAN bus data

The third chapter talks about ThingSpeak:
* Introduction
* Channel Creation
* Collect and Analyze Data

The fourth chapter talks about Matlab:
* Vehicle Network Toolbox
* Create CAN bus channel
* Simple CAN

The fifth chapter talks about the 'New CAN' example.

The sixth chapter talks about the 'DBC-File' example.

The last one talks about 'kvaser' example.


## Simple CAN
The examples that are shown have the purpose of providing a concrete representation of the CAN protocol.

In the first example it is simulated the functioning of the CAN protocol at a high level, specifically it has been tried to simulate CAN Communication between devices, the device 1 has transmitted all the DewPointMeasurement collected by the sensor at once trough the MathWorks Virtual Channel 1 and the second device has received all the data through the MathWorks Virtual Channel 2 and then it has stored all the data in a vector. All the data sent are traceble by CAN Explorer.

All about this first example is contained in chapter [Third & Fourth][35].

The First Example Code's is shown in
[CANbus Code][10].

This following is a list of all the steps we are going to perform:
* First of all we are going acquire data using Thingspeak in order to simulate the collection of data carried out by a sensor
* We are going to pack data sensor in a CAN frame to be sent through the CAN bus
* We are going to simulate a CANbus protocol through Matlab
* We are going to use CAN Explorer to analyze CANframes and CANbus protocol

### ThingSpeak

ThingSpeak is an IoT analytics platform service that allows you to aggregate, visualize, and analyze live data streams in the cloud.
With MATLAB analytics inside ThingSpeak, you can write and execute MATLAB code to perform preprocessing, visualizations, and analyses. ThingSpeak enables engineers and scientists to prototype and build IoT systems without setting up servers or developing web software.[1]

All about ThingSpeak is contained in chapter [Third][35].

#### -- Get Started

The first step shows how to create a new channel to collect analyzed data. You read data from the public ThingSpeak channel 12397 - Weather Station, and write it into your new channel.

[CreateChannel][4].

Now your channel is available for future use by clicking Channels > My Channels.

#### -- Analyze Your data

This step shows how to read temperature and humidity data from [ThingSpeak channel 12397][6]

[Analyze data Code][5].

#### -- Visualize Dew Point Measurement

Use the MATLAB Visualizations app to visualize the measured dew point data, temperature, and humidity from your [Dew Point Measurement channel][6].

Go to Apps > MATLAB Visualizations, and click New to create a visualization.

Alternately, you can click MATLAB Visualization in your Dew Point Measurement channel view.

[Visualize Dew Point Code][7].

[Plot Dew Point Measurement][14].

### MatLab

Using [Vehicle Network Toolbox][15] is possible to perform a CAN communication.
This step shows you how to simulate a [CANbus][8] through [MathWorks Virtual Channels][9].

All about matlab and function is contained in chapter [Fourth][35].

### Simulink

[Simulink®][3] is a block diagram environment for multidomain simulation and Model-Based Design. It supports system-level design, simulation, automatic code generation, continuous test and verification of embedded systems. Simulink provides a graphical editor, customizable block libraries and solvers for both modeling and simulating dynamic systems. It is integrated with MATLAB®, enabling you to incorporate MATLAB algorithms into models and export simulation results to MATLAB for further analysis.

### CAN Explorer

The [CAN Explorer][19] app allows you to acquire and visualize CAN data, filtering on specified signals and messages.
In this example it is configured for monitoring data sent by device 1 using MathWorks Virtual Channel1.

### Output
[CanExp][28] is the first example's demonstration.
In this Matlab files is contained the DewPointMeasurement sent through the Matwork Virtual Channel.

[VIDEO][36] shows a demonstration of the DewPoint Measures sent through the channel during the time.

## New CAN

In this new example we are goig to create a script through Matlab which allow us to represent the acknowledgment of the CAN bus. Mathlab and [MathWorks Virtual Channel][9] don't give us the possibility to use any property of interest of the CAN protocol, so we are goig to try by our own to focus on some characteristic as the acknowledgment.

As we already said in the CAN bus chapter communicate with messages, each nodes of the system receives all the messages sent on the bus, gives the acknowledge and also decides if the message should be immediately discarded or not, so in this example the device 1 sends the new DewPointData only after it has received the ACK message from the device 2. We have a two way communication from the nodes, but if the ack is not sent using the appropriate field, hence we are goig to simulate it using the ID.

we have also introduced the error frame, which is transmitted when a node detects an error in a message according with the many protocol errors defined by CAN Standard, this means that also in this case we didn't use the correctly error frame object, MathWork don't allow us, thus we need to use a specific Data Message for error frame.

All about this second example is contained in chapter [Fifth][35].

The Second Example Code's is shown in
[NewCANbus Code][20].

### CAN Explorer
[CanExp][29] is the first example's demonstration.
In this Matlab files it is contained the DewPointMeasurement sent through the Matwork Virtual Channel.

[VIDEO][37] shows a demonstration of the new implementation.

## DBC-File

The information required for extracting CAN bus signals is contained in a standardized file format. The most common format is called [CAN databases][21]. 
It contain:
* All the CAN messages objects
* The offset
* The scale factor
All this parameters gives information about the comunication and are covered in the next examples.

### Example
In this example are going to see a new example in order to better understand what a DBC File is and how to read it.
Also this example has been performed using Matlab.

It's possible to use a DBC-File already present in Matlab [examples folder][22]. Include this DBC-file in your matlab project folder.

Now we are going to simulate a real communication through the Virtual Channel, using real CAN Message objects contained in the DBC File example. The messages are generated using a specific [function][23] given by Matlab, analyzed within CAN Explorer and shown.

All about this third example is contained in chapter [Sixth][35].

The DBC-File Example Code's is shown in
[DBC-Can][24].

### CAN Explorer
[CanExp][30] is the first example's demonstration.
In this Matlab files is contained the CanMessages sent through the Matwork Virtual Channel using the DBC-File.

[VIDEO][38] shows a demonstration of the new implementation.

[EnginePlot][31] shown the value sent through the Channel.

## Kvaser Example

[Kvaser Database Editor][18] allows to edit or create a [DBC-File][25], in this case the goal is to create a DBC that contains an EngineMSg and a DewPointMeasureMsg.

| DBC-Msg | Signal1 | Signal2 |
| --- | --- | --- |
| EngineMsg | EngineRPM | VehicleSpeed |
| DewPointMsg | Temperature | DewPoint |


### Example

In this example it will be shown how to create your own DBC-File and perform the same example seen in [DBC-File](#Dbc-File).

It is possible to simulate a real communication through the Virtual Channel, using a real Database CAN created by means of the Kvaser Database Editor, it contains CAN Message objects EngineMsg and DewPointMsg. The first is composed of EngineRpm signal and VehicleSpeed signal, while the second is composed of Temperature signal and DewPoint singal as it is shown in the table.

The messages are generated using a specific [function][27] given by Matlab, analyzed within CAN Explorer and shown a real communication among different devices.

All about this second example is contained in [the last chapter][35].

The Second Example Code's is shown in
[Kvaser Code][26].

### CAN Explorer

[CanExp][32] is the second example's demonstration.
In this Matlab files is contained the CanMessages sent through the Matwork Virtual Channel using the DBC-File.

[DewPointPlot][33] shown the values sent through the Channel.

[VehicleSpeed][34] shown the values sent through the Channel.

[VIDEO][39] shows a demonstration of the new implementation.




[1]: https://it.mathworks.com/help/thingspeak/       "ThingSpeak"
[2]: https://it.mathworks.com/products/matlab.html  "MatLab"
[3]: https://it.mathworks.com/help/simulink/   "Simulink"
[4]: https://it.mathworks.com/help/thingspeak/collect-data-in-a-new-channel.html  "CreateCh"
[5]: https://github.com/gmerlino/CANbus-on-MATLAB/blob/main/ThingSpeak/Dew_Point_Calculation.m "DPC"
[6]: https://it.mathworks.com/help/thingspeak/analyze-your-data.html "analyze data"
[7]: https://github.com/gmerlino/CANbus-on-MATLAB/blob/main/ThingSpeak/Dew_point.m "DP"
[8]: https://it.mathworks.com/help/vnt/ug/can-communication-session.html "CANbus"
[9]: https://it.mathworks.com/help/vnt/ug/mathworks-virtual-channels.html "MatVCh"
[10]: Matlab/FirstEx/CAN.m "CANcode"
[11]: https://it.mathworks.com/help/simulink/ug/load-data-using-the-from-workspace-block.html "FromWorkspace"
[12]: https://github.com/gmerlino/CANbus-on-MATLAB/blob/main/Simulink/termo.slx "Output"
[13]: https://github.com/gmerlino/CANbus-on-MATLAB/blob/main/Video/Iot_pr.mp4 "Video"
[14]: https://github.com/gmerlino/CANbus-on-MATLAB/blob/main/ThingSpeak/Dew_Point_Measurement.png "ImDewPM"
[15]: https://it.mathworks.com/products/vehicle-network.html "VNT"
[16]: https://github.com/gmerlino/CANbus-on-MATLAB/blob/main/Documentation/CANbus.pdf
[17]: https://github.com/gmerlino/CANbus-on-MATLAB/blob/main/Documentation/Guide_code.pdf
[18]: https://www.kvaser.com/software/7330130980334/V2/UG_98033_kvaser_database_editor_userguide.pdf "kva"
[19]: https://it.mathworks.com/help/vnt/ug/canexplorer-app.html?searchHighlight=can%20explorer&s_tid=srchtitle_can%20explorer_1 "CANEXP"
[20]: Matlab/SecondEx/NewCAN.m "Code2"
[21]: https://docs.fileformat.com/database/dbc/#:~:text=DBC%20Example-,What%20is%20a%20DBC%20file%3F,or%20in%20human%20readable%20form. "CANDB"
[22]: Matlab/DbcFirstEX/demoVNT_CANdbFiles.dbc "demodb"
[23]: Matlab/DbcFirstEX/generateMsgsDb.m "GMSG"
[24]: Matlab/DbcFirstEX/dbc_CAN.m "NEWCan"
[25]: Matlab/KvaserDbc/ProvaDBCF.dbc "db"
[26]: Matlab/KvaserDbc/KvDBC.m 
[27]: Matlab/KvaserDbc/generateMsgsDb2.m
[28]: Matlab/FirstEx/output/canexp.mat
[29]: Matlab/SecondEx/Output/canexp.mat
[30]: Matlab/DbcFirstEX/Output/canexp.mat
[31]: Matlab/DbcFirstEX/Output/ENgineplot.png
[32]: Matlab/KvaserDbc/Output/matlab.mat
[33]: Matlab/KvaserDbc/Output/plotdew.png
[34]: Matlab/KvaserDbc/Output/plotspeed.png
[35]: Documentation/IOT2.0.pdf
[36]: Video/First_EX.mp4
[37]: Video/Second_EX.mp4
[38]: Video/Third_EX.mp4
[39]: Video/Fourth_EX.mp4
