% Modified from StochOp LGP
% Comment starting with "HR:" is specific for the humanoid robot project

function newChromosomePairStruct = DoubleCross(chromosome1, chromosome2)

numberOfInstructions1 = length(chromosome1) / 3;
numberOfInstructions2 = length(chromosome2) / 3;

crossoverPoint = zeros(2);
crossoverPoint(1, 1) = ceil(rand*(numberOfInstructions1 - 2));
crossoverPoint(1, 2) = crossoverPoint(1, 1) + ceil((numberOfInstructions1 - crossoverPoint(1, 1) - 1)*rand);
crossoverPoint(2, 1) = ceil(rand*(numberOfInstructions2 - 2));
crossoverPoint(2, 2) = crossoverPoint(2, 1) + ceil((numberOfInstructions2 - crossoverPoint(2, 1) - 1)*rand);

% 1: 3p1 | 3p1+1 : 3p2 | 3p1 +1 : end
firstPart1 = chromosome1(1:crossoverPoint(1, 1)*3);
middlePart1 = chromosome1(crossoverPoint(1, 1)*3+1:crossoverPoint(1, 2)*3);
lastPart1 = chromosome1(crossoverPoint(1, 2)*3+1:end);

firstPart2 = chromosome2(1:crossoverPoint(2, 1)*3);
middlePart2 = chromosome2(crossoverPoint(2, 1)*3+1:crossoverPoint(2, 2)*3);
lastPart2 = chromosome2(crossoverPoint(2, 2)*3+1:end);

newChromosome1 = [firstPart1, middlePart2, lastPart1];
newChromosome2 = [firstPart2, middlePart1, lastPart2];

newIndividual1 = struct('Chromosome', newChromosome1);
newIndividual2 = struct('Chromosome', newChromosome2);

newChromosomePairStruct = [newIndividual1, newIndividual2];

end