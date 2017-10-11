%% Main program
clc;
clear all;

% Initializations
hsc_motor = MotorHSC()
hsc_motor.moveToPosition(1, 0/1023)
hsc_motor.moveToPosition(2, (0)/1023)

%%
% Finite State Machine
state = 1;
while ~state == 0
    switch (state)
        case 1 % Standup robot
            hsc_motor.standUpRobot();
            pause(1);
            state = 0;
        case 2 %search for door
            
        case 3 %Grab door
            
        case 4 %Go through door
    end
end


%% Quit program
hsc_motor.disableAllTorque();
pause(1);
hsc_motor.closeConnection();

