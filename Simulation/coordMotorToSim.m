%% Transforms motor coordinates into simulation joint coordinates
function coord = coordMotorToSim(motorCoord,motorID)

% Calibration matricies
addpath('..')
[motorMax, motorMin] = motorPositions();
[simMax, simMin] = simulationPositions();

coord = zeros(1,length(motorCoord));

for i=1:length(motorCoord)
    jointID = motorID(i);
    alpha = (motorCoord(jointID)-motorMin(jointID))/(motorMax(jointID)-motorMin(jointID));
    coord(i) = simMin(jointID) + (simMax(jointID)-simMin(jointID))*alpha;
end

end