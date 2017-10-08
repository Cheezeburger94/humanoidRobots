% Modified from StochOp LGP
% Comment starting with "HR:" is specific for the humanoid robot project

function chromosome = InitializeLGPChromosome(numberOfOperators, numberOfMotors, minNumberOfInstructions, maxNumberOfInstructions)

range = maxNumberOfInstructions - minNumberOfInstructions;
numberOfInstructions = fix(range*rand) + minNumberOfInstructions;
%numberOfOperands = numberOfVariables + numberOfConstants;
chromosome = [];

for i = 1:numberOfInstructions
    gene1 = ceil(numberOfOperators*rand); % HR: Motor function
    gene2 = ceil(numberOfMotors*rand); % HR: Motor ID
    gene3 = rand; % HR: Value 0-1
    
    chromosome = [chromosome, gene1, gene2, gene3];
end

end