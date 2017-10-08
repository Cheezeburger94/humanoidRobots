% Modified from StochOp LGP
% Comment starting with "HR:" is specific for the humanoid robot project
function TrainLGP()

addpath('DataHandling')
addpath('GenAlg')

% __ Problem Values __

% Filename: population.$problemId$.saveId
% Example: population.1.1.mat
% BestChromosome: best.1.1.mat
folderName = 'datafiles';
problemId = 1;
loadId = 1; % File index to load from
saveId = 1; % File index to save to
partialLoad = true;
resetValues = true;
loading = false;

loadSpecial = false;
specialPopulationFile = 'filename';

numberOfGenerations = 500;

% -- Selection probabilities
selectionParameter = 0.8;
tournamentSize = 5;
crossoverProbability = 0.9;
finalCrossoverProbability = 0.03;

crossoverDecay = 5 / 6;

% -- Mutation values --
motorMutation = 0.8;
finalMotorMutation = 0.04;

valueMutation = 0.6;
finalValueMutation = 0.04;
creepRate = 0.1;

operationMutation = 0.8;
finalOperationMutation = 0.04;

mutationDecay = 5 / 6;

mutations = [motorMutation, valueMutation, operationMutation];
finalMutations = [finalMotorMutation, finalValueMutation, finalOperationMutation];

% -- Simulation properties
numberOfMotors = 18;
valueRange = [0, 1];
numberOfOperators = 2;
populationSize = 100;

% -- Initalization properties
minNumberOfInstructions = 5;
maxNumberOfInstructions = 20;


%Initialize population
population = [];
% outputs = zeros(numberOfPoints,1); %HR: Was the old type of result (mathematical function)

if loadSpecial
    population = CustomLoadPopulation(specialPopulationFile);
elseif loading
    if partialLoad
        population = LoadPopulation(folderName, problemId, saveId, 'partial');
    else
        population = LoadPopulation(folderName, problemId, saveId, '');
    end
else
    for i = 1:populationSize
        chromosome = InitializeLGPChromosome(numberOfOperators, numberOfMotors, ...
            minNumberOfInstructions, ...
            maxNumberOfInstructions);
        individual = struct('Chromosome', chromosome);
        population = [population, individual];
    end
end

bestFitnessEver = 0;
bestChromosomeEver = [];

% _________ START __________


waitBar = waitbar(0, 'Searching');
clean3 = onCleanup(@() close(waitBar));

for iGeneration = 1:numberOfGenerations
    
    % Update parameters, but not in the beginning
    % HR: This might not be used
    if iGeneration > 100
        for i = 1:3
            if mutations(i) > finalMutations(i)
                mutations(i) = mutations(i) * mutationDecay;
            else
                mutations(i) = finalMutations(i);
            end
        end
        
        if crossoverProbability > finalCrossoverProbability
            crossoverProbability = crossoverProbability * crossoverDecay;
        else
            crossoverProbability = finalCrossoverProbability;
        end
    end
    
    % Evaluate chromosomes
    fitnessInGeneration = zeros(populationSize, 1);
    for iIndividual = 1:populationSize
        
        chromosome = population(iIndividual).Chromosome;
        %HR: Decoding and fitness need to be completely new'
        
        % Chris: Should be done in this function which calls the simulation
        fitnessInGeneration(iIndividual) = GetFitnessSimulation(0, chromosome);
        
        if fitnessInGeneration(iIndividual) > bestFitnessEver
            bestFitnessEver = fitnessInGeneration(iIndividual);
            bestChromosomeEver = chromosome;
        end
        
    end
    
    %%%%%% GA %%%%%%
    
    newPopulation = population;
    
    % Selection & crossover
    for i = 1:2:populationSize
        selectedIndex1 = TournamentSelect(fitnessInGeneration, selectionParameter, tournamentSize);
        selectedIndex2 = TournamentSelect(fitnessInGeneration, selectionParameter, tournamentSize);
        chromosome1 = population(selectedIndex1).Chromosome;
        chromosome2 = population(selectedIndex2).Chromosome;
        
        if (rand < crossoverProbability)
            newChromosomePairStructs = DoubleCross(chromosome1, chromosome2);
            newPopulation(i).Chromosome = newChromosomePairStructs(1).Chromosome;
            newPopulation(i+1).Chromosome = newChromosomePairStructs(2).Chromosome;
        else
            newPopulation(i).Chromosome = chromosome1;
            newPopulation(i+1).Chromosome = chromosome2;
        end
    end
    
    % Mutation
    for i = 1:populationSize
        chromosome = newPopulation(i).Chromosome;
        mutatedChromosome = MutateLGP(chromosome, ...
            numberOfMotors, numberOfOperators, ...
            valueRange, ...
            mutations, creepRate);
        newPopulation(i).Chromosome = mutatedChromosome;
    end
    
    % Elitism
    newPopulation(1).Chromosome = bestChromosomeEver;
    
    population = newPopulation;
  
    
    waitbar(iGeneration/numberOfGenerations);
end % End of generation

SaveChromosome(bestChromosomeEver, bestFitnessEver, folderName, problemId, ...
    saveId, '');
SavePopulation(population, folderName, problemId, ...
    saveId, '');


end
% HR: We need a new "conclusion"
% plot(X, Y, X, bestOutputs);
% disp(['Best fitness ever: ' num2str(bestFitnessEver)]);
% disp(['Corresponding error: ' num2str(1/bestFitnessEver)]);
%
% % Find the function given by the best chromosome
% expression = ExecuteInstructionsAnalytic(bestChromosomeEver, constantRegisters);
% disp('Corresponding expression:');
% disp(simplify(expression));