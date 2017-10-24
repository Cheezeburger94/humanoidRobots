function openDoor(hsc_motor)

% Push open dorr
hsc_motor.moveToPosition(5,1);
pause(1);
%Pulldown arm
hsc_motor.moveToPosition(1,0.4);
pause(1);
hsc_motor.moveToPosition(3,0.1);
pause(1);
% Push door with left hand
hsc_motor.moveToPosition(2,1);
pause(1);
hsc_motor.moveToPosition(2,0.4);
% Start walking
test(hsc_motor);
%hsc_motor.walkForward();
pause(1);
% Push door with left hand
hsc_motor.moveToPosition(2,1);
pause(0.5);
hsc_motor.moveToPosition(2,0.5);
pause(0.5);
%hsc_motor.walkForward();
test(hsc_motor);
pause(0.5);
hsc_motor.standUpRobot();
end