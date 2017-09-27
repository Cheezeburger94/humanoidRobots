classdef DoorDetector
    properties
        img = 0;
        handleCoords = 0;
        doorHandle = 0;
    end
    
    methods(Static)
        function obj = DoorDetector()
            %Constructor
        end
        
        function conclusion = locateDoor()
            %conclusion: success or failure
            %locally save all available door info
        end
        
        function handlePos = locateHandle()
            %handle coords relative to camera
        end
        
        function angle = getDoorAngle()
            %angle of robot approach
        end
        
    end
    
end