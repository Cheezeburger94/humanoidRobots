%% Simulation-software communication class
classdef SSC
    properties
        vrep;
        clientID;
        % Handles
        namesJoints = ["Joint1","Joint2","Joint3","Joint4","Joint5","Joint6","Joint7","Joint8","Joint9","Joint10","Joint11","Joint12","Joint13","Joint14","Joint15","Joint16","Joint17","Joint18"];
        namesBodyParts = ["Bioloid","Shoulder_R","Shoulder_L","UpperArm_R","UpperArm_L","LowerArm_R","LowerArm_L","UpperHip_R","UpperHip_L","LowerHip_R","LowerHip_L"]
        handlesJoints = [];
        handlesBodyParts  = [];
        % Initial positions
        initPos_bodyParts = zeros(19,3);
        initPos_joints = zeros(18,3);
        % Initial orientation
        initOrientation_bodyParts = zeros(19,3);
        initOrientation_joints = zeros(18,3);
    end
    methods
        function obj = SSC()
            obj.vrep=remApi('remoteApi');
            obj.vrep.simxFinish(-1); % just in case, close all opened connections
            obj.clientID=obj.vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
            if(obj.clientID>-1)
                % Pause scene
                obj.vrep.simxPauseSimulation(obj.clientID,obj.vrep.simx_opmode_oneshot);
                obj.vrep.simxPauseCommunication(obj.clientID,1);
                for i=1:18
                    i
                    % Get handles
                    [~,tmpHandle] = obj.vrep.simxGetObjectHandle(obj.clientID,char(obj.namesJoints(i)),obj.vrep.simx_opmode_oneshot);
                    disp('hej')
                    obj.handlesJoints = [obj.handlesJoints; tmpHandle];
                    [~,tmpHandle] = obj.vrep.simxGetObjectHandle(obj.clientID,obj.namesBodyParts(i),obj.vrep.simx_opmode_oneshot);
                    obj.handlesBodyParts = [obj.handlesBodyParts; tmpHandle];
                    % Get initial positions and orientations
                    [~,obj.initPos_bodyParts(i,:)] = obj.vrep.simxGetObjectPosition(obj.clientID,obj.handlesBodyParts(i),-1,obj.vrep.simx_opmode_oneshot);
                    [~,obj.initPos_joints(i,:)] = obj.vrep.simxGetObjectPosition(obj.clientID,obj.handlesJoints(i),-1,obj.vrep.simx_opmode_oneshot);
                    % Initial orientation
                    [~,obj.initOrientation_bodyParts(i,:)] = obj.vrep.simxGetObjectOrientation(obj.clientID,obj.handlesBodyParts(i),-1,obj.vrep.simx_opmode_oneshot);
                    [~,obj.initOrientation_joints(i,:)] = obj.vrep.simxGetObjectOrientation(obj.clientID,obj.handlesJoints(i),-1,obj.vrep.simx_opmode_oneshot);
                end
                
                % Last body part
                [~,tmpHandle] = obj.vrep.simxGetObjectHandle(obj.clientID,obj.namesBodyParts(19),obj.vrep.simx_opmode_oneshot);
                obj.handlesBodyParts = [obj.handlesBodyParts; tmpHandle];
                [~,obj.initPos_bodyParts(19,:)] = obj.vrep.simxGetObjectPosition(obj.clientID,obj.handlesBodyParts(19),-1,obj.vrep.simx_opmode_oneshot);
                [~,obj.initOrientation_bodyParts(19,:)] = obj.vrep.simxGetObjectOrientation(obj.clientID,obj.handlesBodyParts(19),-1,obj.vrep.simx_opmode_oneshot);
                
                obj.vrep.simxPauseCommunication(clientID,0);
                
            else
                error('SSC:Failed to connect to V-REP!')
            end
        end
        
        function getBodyPosition()
            %
        end
        
        function getBodyOrientation()
            
        end
        
        function checkFloorCollision()
            % Return true if collision with floor has occured
            % Does not count feet
        end
        
        function checkDoorFrameCollision()
            
        end
    end
end