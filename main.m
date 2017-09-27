%% Main program
clc;
clear all;

hsc_motor = MotorHSC()

%enableTorque(hsc_motor,1)
hsc_motor.moveToPosition(hsc_motor,7,0.6)
hsc_motor.moveToPosition(hsc_motor,8,0.6)
%
hsc_motor.readPosition(hsc_motor,8)

hsc_motor.closeConnection(hsc_motor);