% Modified from StochOp LGP
% Comment starting with "HR:" is specific for the humanoid robot project
% Is right now not used in HR, but might be good for inspiration on how to
% separate the instructions in a chromosome.

function output = ExecuteInstructions(chromosome, variableRegisters, constantRegisters)

numberOfInstructions = length(chromosome) / 4; % HR: 4 was the number of genes in every instruction,
instructions = zeros(numberOfInstructions, 4); % most 4's should be changed to 3 in HR.
operandRegisters = [variableRegisters, constantRegisters];

for i = 1:numberOfInstructions
    for j = 1:4
        instructions(i, j) = chromosome(4*(i - 1)+j);
    end
end

for i = 1:numberOfInstructions
    iDestination = instructions(i, 2);
    iOperand1 = instructions(i, 3);
    iOperand2 = instructions(i, 4);
    
    % Decide operator
    if instructions(i, 1) == 1
        operandRegisters(iDestination) = operandRegisters(iOperand1) + operandRegisters(iOperand2);
    elseif instructions(i, 1) == 2
        operandRegisters(iDestination) = operandRegisters(iOperand1) - operandRegisters(iOperand2);
    elseif instructions(i, 1) == 3
        operandRegisters(iDestination) = operandRegisters(iOperand1) * operandRegisters(iOperand2);
    elseif instructions(i, 1) == 4
        if operandRegisters(iOperand2) == 0
            operandRegisters(iDestination) = max(constantRegisters);
        else
            operandRegisters(iDestination) = operandRegisters(iOperand1) / operandRegisters(iOperand2);
        end
    end
end

output = operandRegisters(1);

end