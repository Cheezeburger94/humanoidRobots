function fitness = GetFitnessSimulation(simId, chromosome, SSC)


Rxm = -100;
RxM = 100;
Rym = -100;
RyM = 100;
Rzm = -100
RzM = 


%Acceptable Angle range
A1 = 10;
DA1 = 10;
A2 = 10;
DA2 = 10;
A3 = 0;
DA3 = 10;


A1m = A1 - DA1;
A1M = A1 + DA1;
A2m = A2 - DA2;
A2M = A2 + DA2;
A3m = A3 - DA3;
A3M = A3 + DA3;

%Robot Movement Range




genProg = GeneticProg(chromosome, SSC);

fitnessMod = 0;

i = 0;
while genProg.next()
    
    i = i+ 1;
    if ~genProg.wasWaiting() && i < 10
        continue
    end
    i = 0;
    
    [x, y, z] = SSC.getBodyPosition();
    [T1, T2, T3] = SSC.getBodyOrientation();

    %Check if the robot has the correct orientation
    if (A1m < T1 || T1 < A1M || ...
        A2m < T2 || T2 < A2M || ...
        A3m < T3 || T3 < A3M)
        fitnessMod = -1000;
        break;        
    end
    
    if (SSC.checkFloorCollision())
        fitnessMod = -500;
        break
    end
    
    
    if (SSC.checkDoorFrameCollision())
        fitnessMod = -100;
        break
    end
    
    if (SSC.checkDoorCollision())
        fitnessMod = -50;
        break;
    end

    
    %Check if the robot is outside the accepable space
    if (Rxm < x || x < RxM  || ...
        Rym< y || y < RyM || ...
        Rzm < z || z < RzM)
        fitnessMod = -10;
        break;
    end
    

    
end

fitness = x + fitnessMod;
end