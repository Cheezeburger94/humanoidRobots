classdef GeneticProg
    properties(Access = private)
        iteratorIndex
        instructionsList
        maxTime = 10; % In seconds
    end
    methods
        function obj = GeneticProg(instructions)
            obj.iteratorIndex = 0;
            obj.instructionsList = instructions;
        end
        
        function done = next(obj)          
            index = obj.iteratorIndex;
            operation = obj.instructionsList(index+1);
            motorId = obj.instructionsList(index+2);
            value = obj.instructionsList(index+3);
            
            switch operation
                case 1
                    obj.delay(value)
                case 2
                    obj.motorMove(motorId, value)
            end
            obj.setIteratorIndex(index+3);
            if index + 3 >= length(instrutionsList)
                done = 1;
            else
                done = -1;
            end
            
        end
        
        function obj_gp = setInstruction(obj_gp, instructions)
            obj_gp.instructionsList = instructions;
            obj_gp.resetInstruction();
        end
        
        function obj_gp = clearInstruction(obj_gp)
            obj_gp.instructionsList = [];
        end
        
        function obj_gp = resetInstruction(obj_gp)
            obj_gp.iteratorIndex = 0;
        end
        
        function iteratorIndex = getIteratorIndex(obj_gp)
            iteratorIndex = obj_gp.iteratorIndex;
        end
        
        function obj = setIteratorIndex(obj, value)
            obj.iteratorIndex = value;
        end
        
    end
    methods(Access = private)
        % Instructions
        function delay(obj_gp, timeGene)
            timeDelay = timeGene * obj_gp.maxTime;
            sleep(timeDelay);
        end
        
        function motorMove(motorHSC, id, pos)
            motorHSC.moveToPosition(id, pos);
        end
        
    end
end