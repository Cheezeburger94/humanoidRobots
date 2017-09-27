%% Main program
clc;
clear all;

hsc_motor = MotorHSC()

%enableTorque(hsc_motor,1)
%hsc_motor.moveToGoalPosition(hsc_motor,1,500)
%
%hsc_motor.readPresentPosition(hsc_motor,1)
hsc_motor.enableTorque(hsc_motor,2)

hsc_motor.closeConnection(hsc_motor);