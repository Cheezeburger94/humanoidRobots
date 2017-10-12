%% Simulation-software communication class
classdef SSC
    properties
        vrep;
        clientID;
        % Handles
        namesJoints = ["Joint1","Joint2","Joint3","Joint4","Joint5","Joint6","Joint7","Joint8","Joint9","Joint10","Joint11","Joint12","Joint13","Joint14","Joint15","Joint16","Joint17","Joint18"];
        namesBodyParts = ["Bioloid","Shoulder_R","Shoulder_L","UpperArm_R","UpperArm_L","LowerArm_R","LowerArm_L","UpperHip_R","UpperHip_L","LowerHip_R","LowerHip_L"]
        handle_Bioloid;
        handle_Shoulder_R;
        handle_Shoulder_L;
        handle_UpperArm_R;
        handle_UpperArm_L;
        handle_LowerArm_R;
        handle_LowerArm_L;
        handle_UpperHip_R;
        handle_UpperHip_L;
        handle_LowerHip_R;
        handle_LowerHip_L;
        handle_UpperLeg_R;
        handle_UpperLeg_L;
        handle_LowerLeg_R;
        handle_LowerLeg_L;
        handle_Ankle_R;
        handle_Ankle_L;
        handle_Foot_R;
        handle_Foot_L;
        % Initial positions
        initPos_bodyParts = zeros(3,18);
        initPos_joints = zeros(3,18);
        % Initial orientation
        initOr_bodyParts = zeros(3,18);
        initOr_joints = zeros(3,18);
    end
    methods
        function obj = SSC()
            obj.vrep=remApi('remoteApi');
            obj.vrep.simxFinish(-1); % just in case, close all opened connections
            obj.clientID=obj.vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
            if(clientID>-1)
                % Pause scene
                obj.vrep.simxPauseCommunication(clientID,1);
                % Set all handles

                % Set initial positions for body parts
                
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