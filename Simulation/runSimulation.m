%% Initialize V-REP
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


[returnCode]=vrep.simxSetJointTargetPosition(clientID,motor10,100,vrep.simx_opmode_blocking)
pause(5)
end

% Close connection
vrep.simxFinish(-1);

