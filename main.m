%% Main program
clc;
clear all;

% Initializations
hsc_motor = MotorHSC();
hsc_camera = DoorDetector();
%hsc_motor.moveToPosition(1, 0)
%hsc_motor.moveToPosition(2, (0)/1023)

% Finite State Machine
state = 1;
while ~state == 0
    switch (state)
        case 1 % Standup robot
            hsc_motor.standUpRobot();
            pause(2);
            state = 2;
        case 2 % Search for handle
            foundHandle = hsc_camera.locateDoor(hsc_camera);
            if foundHandle
                state = 3;
            else
                disp('Could not found handle')
                state = 0;
            end
        case 3 % Locate handle
            handlePosition = hsc_camera.locateHandle(hsc_camera)
            state = 4;
        case 4 %Grab door
            grabHandle(hsc_motor,handlePosition);
            state = 0;
        case 5 %Go through door
    end
end


%% Quit program
hsc_motor.disableAllTorque();
pause(1);
hsc_motor.closeConnection();

