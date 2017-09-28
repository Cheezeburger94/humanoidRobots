classdef GeneticProg
    properties(Access= private)
        iteratorIndex
        instructionsList
        maxTime = 10; % In seconds
    end
    methods
        function obj = GeneticProg()
            obj.iteratorIndex = 1;
        end
        
        function obj_gp = next(obj_gp)
            % TODO: Iterate next step
            obj_gp.iteratorIndex = obj_gp.iteratorIndex+1;
        end
        
        function obj_gp = clearInstruction(obj_gp)
            obj_gp.instructionsList = [];
        end
        
        function obj_gp = resetInstruction(obj_gp)
            % TODO: Write
        end
    end
    methods(Access = private)
        % Instructions
        function delay(obj_gp,timeGene)
            timeDelay = timeGene*obj_gp.maxTime;
            sleep(timeDelay);
        end
        
        function motorMove(motorHSC,id,pos)
            motorHSC.moveToPosition(id,pos);
        end
        
        function enableTorqueGP(motorHSC,id)
            motorHSC.enableTorque(id);
        end
        
        function disableTorqueGP(motorHSC,id)
            motorHSC.disableTorque(id);
        end
    end
end