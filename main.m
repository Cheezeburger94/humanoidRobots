%% Main program
clc;
clear all;

% Initializations
hsc_motor = MotorHSC()

% Finite State Machine
state = 1;
while ~state==0
   switch(state)
       case 1 % Standup robot
           hsc_motor.standUpRobot();
           pause(1);
           state = 0;
       case 2 %search for door
   end
end


% Quit program
hsc_motor.disableAllTorque();
pause(1);
hsc_motor.closeConnection();

 