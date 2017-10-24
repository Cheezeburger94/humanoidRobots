function playSequence(motor_hsc,waitTimes,motorPoses,ifNoArms)

if ifNoArms == 1
   startIt = 7;
else
    startIt = 1;
end

for i=1:length(waitTimes)
    for j=startIt:18
        goalPos = motorPoses(i,j);
        motor_hsc.moveToPositionMotorCoord(j,goalPos);
    end
    pause(waitTimes(i));
end

end