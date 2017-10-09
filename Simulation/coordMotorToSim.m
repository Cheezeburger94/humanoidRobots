%% Transforms motor coordinates into simulation joint coordinates
function coord = coordMotorToSim(motorCoord,motorID)

% Calibration matricies
motorMin = [0,1023,135,888,162,512,205,512,381,454,205,424,205,512,420,258,313,295];
motorMax = [512,512,512,512,512,840,512,818,570,643,600,818,512,810,665,600,755,700];
simMin = [-135,-135,105,-135,102,0,45,45,38,17,90,-26,-90,0,-26,45,-58,-79];
simMax = [0,0,0,0,0,-96,-45,-45,-17,-38,-26,90,0,-90,45,26,71,55];

coord = zeros(1,length(motorCoord));

for i=1:length(motorCoord)
    jointID = motorID(i);
    alpha = (motorCoord(jointID)-motorMin(jointID))/(motorMax(jointID)-motorMin(jointID));
    coord(i) = simMin(jointID) + (simMax(jointID)-simMin(jointID))*alpha;
end

end