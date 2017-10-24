%% Main program
clc;
clear all;
% Initializations
hsc_motor = MotorHSC();
%%

% Finite State Machine
state = 1;
while ~state == 0
    switch (state)
        case 1 % Standup robot
            hsc_motor.standUpRobot();
            pause(2);
         
            state = 2;
        case 2 % Search for handle
            hsc_camera = DoorDetector();
            foundHandle = hsc_camera.locateDoor(hsc_camera);
            if foundHandle
                state = 3;
            else
                
                disp('Could not found handle')
                state = 1;
            end
        case 3 % Locate handle
            handlePosition = hsc_camera.locateHandle(hsc_camera)
            state = 4;
        case 4 %Grab door
            try
                grabHandle(hsc_motor,handlePosition);
                state = 5;
            catch ME
                switch ME.message
                    case 'grabHandle: Too far away from handle'
                        state = 6;
                    case 'grabHandle: Complex angles, unable to grab handle'
                        disp('Complex angles')
                        state = 0;
                    case 'grabHandle: Cannot grab handle due to unreachable angles'
                        disp('Bad position :(, exit FSM')
                        state = 0;
                    otherwise
                        disp('Unknown error, stop finite state machine')
                        state = 0;
                end
            end
        case 5 %Go through door
            disp('Ready to open door');
            pause(1);
            openDoor(hsc_motor);
            state = 0;
        case 6 % Move forward if robot too far away
            pause(0.1);
            test(hsc_motor);
            state = 2;
    end
end


%% Quit program
pause;
hsc_motor.disableAllTorque();
pause(1);
hsc_motor.closeConnection();



