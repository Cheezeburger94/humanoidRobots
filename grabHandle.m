function grabHandle(hsc_motor,handlePosition)

% Physical constants
L1 = 6.8; % [cm] Robot upper arm length
L2 = 8; % [cm] Robot lower arm length
armReach = 15;
shoulderDisplacement = 7.2;

% Handle coordinates
x = handlePosition(2) - shoulderDisplacement; % Compensate for eye to shoulder displacement
y = handlePosition(1);

if y > armReach
   error('grabHandle: Too far away from handle') 
end

% Prepare right arm and shoulder
hsc_motor.moveToPosition(3,0.5);
pause(1);
hsc_motor.moveToPosition(1,1);
pause(1);

% Inverse kinematics
angle2 = acos((x^2+y^2-L1^2-L2^2)/(2*L1*L2));
angle1 = atan((-(L2*sin(angle2))*x + (L1+L2*cos(angle2))*y)/((L2*sin(angle2))*y + (L1+L2*cos(angle2))*x));

% Maximum angle robot angles
angle1_min = -90/180 * pi;
angle1_max = 105/180 * pi;

angle2_min = 0/180*pi;
angle2_max = 102.6/180*pi;

if (~imag(angle1)==0)||(~imag(angle2)==0)
   error('grabHandle: Complex angles, unable to grab handle') 
end

if (angle1 < angle1_min || angle1 > angle1_max || angle2 < angle2_min || angle2> angle2_max)
   error('grabHandle: Cannot grab handle due to unreachable angles'); 
end

% Rescale angles
angle1Rescaled =  1 - (angle1-angle1_min)/(angle1_max - angle1_min);
angle2Rescaled =  1 - (angle2-angle2_min)/(angle2_max - angle2_min);

% Move robot arm
hsc_motor.moveToPosition(5, angle2Rescaled);
pause(1);
hsc_motor.moveToPosition(3, angle1Rescaled);

end