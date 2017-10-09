%% Initialize V-REP
clc, clear all;

vrep=remApi('remoteApi');
vrep.simxFinish(-1); % just in case, close all opened connections
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);

if (clientID>-1)
[~,motor1]=vrep.simxGetObjectHandle(clientID,'Joint1',vrep.simx_opmode_blocking);
[~,motor2]=vrep.simxGetObjectHandle(clientID,'Joint2',vrep.simx_opmode_blocking);
[~,motor3]=vrep.simxGetObjectHandle(clientID,'Joint3',vrep.simx_opmode_blocking);
[~,motor4]=vrep.simxGetObjectHandle(clientID,'Joint4',vrep.simx_opmode_blocking);
[~,motor5]=vrep.simxGetObjectHandle(clientID,'Joint5',vrep.simx_opmode_blocking);
[~,motor6]=vrep.simxGetObjectHandle(clientID,'Joint6',vrep.simx_opmode_blocking);
[~,motor7]=vrep.simxGetObjectHandle(clientID,'Joint7',vrep.simx_opmode_blocking);
[~,motor8]=vrep.simxGetObjectHandle(clientID,'Joint8',vrep.simx_opmode_blocking);
[~,motor9]=vrep.simxGetObjectHandle(clientID,'Joint9',vrep.simx_opmode_blocking);
[~,motor10]=vrep.simxGetObjectHandle(clientID,'Joint10',vrep.simx_opmode_blocking);
[~,motor11]=vrep.simxGetObjectHandle(clientID,'Joint11',vrep.simx_opmode_blocking);
[~,motor12]=vrep.simxGetObjectHandle(clientID,'Joint12',vrep.simx_opmode_blocking);
[~,motor13]=vrep.simxGetObjectHandle(clientID,'Joint13',vrep.simx_opmode_blocking);
[~,motor14]=vrep.simxGetObjectHandle(clientID,'Joint14',vrep.simx_opmode_blocking);
[~,motor15]=vrep.simxGetObjectHandle(clientID,'Joint15',vrep.simx_opmode_blocking);
[~,motor16]=vrep.simxGetObjectHandle(clientID,'Joint16',vrep.simx_opmode_blocking);
[~,motor17]=vrep.simxGetObjectHandle(clientID,'Joint17',vrep.simx_opmode_blocking);
[~,motor18]=vrep.simxGetObjectHandle(clientID,'Joint18',vrep.simx_opmode_blocking);



posMotorArray = [334,687,297,723,410,610,356,666,489,532,396,628,279,743,639,385,491,532];
posSimArray = coordMotorToSim(posMotorArray,1:18);



%[~]=vrep.simxSetJointTargetPosition(clientID,motor1,posSimArray(1),vrep.simx_opmode_oneshot);
%pause
%[~]=vrep.simxSetJointTargetPosition(clientID,motor2,posSimArray(2),vrep.simx_opmode_oneshot);
%pause
[~]=vrep.simxSetJointTargetPosition(clientID,motor3,posSimArray(3),vrep.simx_opmode_oneshot);
%pause
%[~]=vrep.simxSetJointTargetPosition(clientID,motor4,posSimArray(4),vrep.simx_opmode_oneshot);
%pause
%[~]=vrep.simxSetJointTargetPosition(clientID,motor5,posSimArray(5),vrep.simx_opmode_oneshot);
%pause
%[~]=vrep.simxSetJointTargetPosition(clientID,motor6,posSimArray(6),vrep.simx_opmode_oneshot);
%[~]=vrep.simxSetJointTargetPosition(clientID,motor7,posSimArray(7),vrep.simx_opmode_blocking);
%[~]=vrep.simxSetJointTargetPosition(clientID,motor8,posSimArray(8),vrep.simx_opmode_blocking);
%[~]=vrep.simxSetJointTargetPosition(clientID,motor9,posSimArray(9),vrep.simx_opmode_blocking);
%[~]=vrep.simxSetJointTargetPosition(clientID,motor10,posSimArray(10),vrep.simx_opmode_blocking);
%[~]=vrep.simxSetJointTargetPosition(clientID,motor11,posSimArray(11),vrep.simx_opmode_blocking);
%[~]=vrep.simxSetJointTargetPosition(clientID,motor12,posSimArray(12),vrep.simx_opmode_blocking);
%[~]=vrep.simxSetJointTargetPosition(clientID,motor13,posSimArray(13),vrep.simx_opmode_blocking);
%[~]=vrep.simxSetJointTargetPosition(clientID,motor14,posSimArray(14),vrep.simx_opmode_blocking);
%[~]=vrep.simxSetJointTargetPosition(clientID,motor15,posSimArray(15),vrep.simx_opmode_blocking);
%[~]=vrep.simxSetJointTargetPosition(clientID,motor16,posSimArray(16),vrep.simx_opmode_blocking);
%[~]=vrep.simxSetJointTargetPosition(clientID,motor17,posSimArray(17),vrep.simx_opmode_blocking);
%[~]=vrep.simxSetJointTargetPosition(clientID,motor18,posSimArray(18),vrep.simx_opmode_blocking);
end

% Close connection
vrep.simxFinish(-1);


%