classdef DoorDetector < handle
    properties
        img;
        handleCoords;
        doorAngle;
    end
    
    methods(Static)
        function obj = DoorDetector()
            %Constructor
            obj.img = 0;
            obj.handleCoords = [0,0]; % [Forward (cm), Right (cm)]
            obj.doorAngle = 0;
            
            cam = webcam('USB2.0 Camera');
            if size(cam.AvailableResolutions,2) < 5
                disp('Error, please reconnect the camera')
            else
                preview(cam);
                pause;
                obj.img = snapshot(cam);
                clear cam;
            end            
        end
        
        function conclusion = locateDoor(obj)
            %conclusion: success or failure
            im = im2double(obj.img);
            boxMatrix = obj.FindMarkerBoxes(); % Marker positions
            [~,width,~] = size(im);
%             boxMatrix = FindMarkerBoxes(obj.img); % Marker positions
%             [~,width,~] = size(im2double(obj.img));
            
            % Horizontal difference of horizontal marker centers
            horDiff = round(boxMatrix(1,1)+boxMatrix(1,3)/2)-(round(boxMatrix(2,1)+boxMatrix(2,3)/2));
            conclusion = horDiff < 0.1*width; % Considered vertically aligned if diff<10% of width
            
            if(conclusion)
                %Locally save all available door info
                forwardDistance = obj.FindDistance(boxMatrix);
                lateralDistance = obj.FindLateral(boxMatrix, width);
                obj.handleCoords = [forwardDistance, lateralDistance];
                
                %obj.doorAngle = ...; % Might not be used?
            end
        end
        
        function handlePos = locateHandle(obj)
            %handle coords relative to camera
            handlePos = obj.handleCoords;
        end
        
        function angle = getDoorAngle(obj)
            %angle of robot approach
            angle = obj.doorAngle;
        end
        
    end
    
    methods (Access = private)
        
        function boxMatrix = FindMarkerBoxes(obj)
            % Returns a 2,4 matrix of bounding box info.
            % 1st row green, 2nd row pink
            
            nColors = 2;
            boxMatrix = zeros(nColors,4);
            colorInfo = zeros(nColors,3);
            % Green
            colorInfo(1,1) = -33.9313;  % imSelA
            colorInfo(1,2) = 17.4601;   % imSelB
            colorInfo(1,3) = 15.5317;   % distThresh
            % Pink
            colorInfo(2,1) = 46.0078;   % imSelA
            colorInfo(2,2) = -21.5126;  % imSelB
            colorInfo(2,3) = 17.5837;   % distThresh
            
            Im = im2double(obj.img);
            [r, c] = size(Im);
            
            %Convert to LAB color space
            imLAB = rgb2lab(Im);
            
            % Extract L, a* and b* values
            imA = imLAB(:,:,2);
            imB = imLAB(:,:,3);
            
            for i = 1:nColors
                
                imSelA = colorInfo(i,1);
                imSelB = colorInfo(i,2);
                distThresh = colorInfo(i,3);
                
                imMask = zeros(r,c);
                imDist = hypot(imA-imSelA, imB-imSelB);
                imMask(imDist<distThresh) = 1;
                
                bw = (imMask==1);
                imMask = bwareafilt(bw,1); % Keep only the largest cluster
                imgConv = bwconvhull(imMask); % Get nicer borders
                
                boxData=regionprops(imgConv, 'BoundingBox');
                boxVector=round([boxData.BoundingBox]); % [first pixel left, first pixel top, width, height]
                boxMatrix(i,:) = boxVector;
                
            end
        end
        
        function distanceForward = FindDistance(obj, boxMatrix)
            % Input: 2x4 matrix with bounding box info as rows
            
            % Vertical difference of vertical marker centers
            handleSep = round(boxMatrix(1,2)+boxMatrix(1,4)/2)-(round(boxMatrix(2,2)+boxMatrix(2,4)/2));
            
            % Function found by fitting training data
            a =       120.5;%  (66.34, 174.7)
            b =    -0.01361;%  (-0.01954, -0.007677)
            c =       32.67;%  (16.83, 48.51)
            d =   -0.002209;%  (-0.003245, -0.001173)
            
            distanceForward = a*exp(b*handleSep) + c*exp(d*handleSep);
        end
        
        function lateralDist = FindLateral(obj, boxMatrix, imgWidth)
            handleSep = round(boxMatrix(1,2)+boxMatrix(1,4)/2)-(round(boxMatrix(2,2)+boxMatrix(2,4)/2)); % 5 cm
            lateralPixels = round(boxMatrix(1,1)+boxMatrix(1,3)/2)-round(imgWidth/2); % Green pixel distance from middle
            lateralDist = lateralPixels/handleSep*5;
        end
        
    end
    
end