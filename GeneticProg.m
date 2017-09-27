classdef GeneticProg
    properties
        iteratorIndex
        instructionsList
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
end