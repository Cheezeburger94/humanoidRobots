% Modified from StochOp LGP
% Comment starting with "HR:" is specific for the humanoid robot project

clc;
clf;
clear all;

numberOfGenerations = 500;

selectionParameter = 0.8;
tournamentSize = 5;
crossoverProbability = 0.9;
mutationProbabilityStart = 0.8; % HR: Might stay constant

%functionData = LoadFunctionData;
%numberOfPoints = size(functionData,1);
%X = functionData(:,1);
%Y = functionData(:,2);

%minConstant = 0;
%maxConstant = 9;
numberOfMotors = 18;
numberOfValues = 1; % HR: Might not be needed
numberOfOperators = 4;
minNumberOfInstructions = 5;
maxNumberOfInstructions = 20;
populationSize = 100;
%constantRegisters = [-1, 1, 3];

mutationProbability = mutationProbabilityStart;
bestFitnessEver = 0;

%Initialize population
population = [];
% outputs = zeros(numberOfPoints,1); %HR: Was the old type of result (mathematical function)
for i = 1:populationSize
    chromosome = InitializeLGPChromosome(numberOfOperators, numberOfMotors, minNumberOfInstructions, maxNumberOfInstructions);
    individual = struct('Chromosome',chromosome);
    population = [population individual];
end

waitBar = waitbar(0, 'Searching');
for iGeneration = 1:numberOfGenerations
    
    % Update parameters, but not in the beginning   
    % HR: This might not be used
    if iGeneration > 100
        mutationProbability = mutationProbability*5/6;
        crossoverProbability = crossoverProbability*5/6;
        if crossoverProbability < 0.4
            crossoverProbability = 0.4;
        end
        if mutationProbability < 0.03
            mutationProbability = 0.03;
        end
    end

    % Evaluate chromosomes
    fitnessInGeneration = zeros(populationSize, 1);
    for iIndividual = 1:populationSize

        chromosome = population(iIndividual).Chromosome;
        
        %HR: Decoding and fitness need to be completely new
%         for k = 1:numberOfPoints
%             variableRegisters = zeros(1,numberOfMotors);
%             variableRegisters(1) = X(k);      
%             outputs(k) = ExecuteInstructions(chromosome, variableRegisters, constantRegisters);
%         end
%         while length(unique(outputs)) == 1 % Output is a constant function, redo chromosome
%             chromosome = InitializeLGPChromosome(numberOfOperators, numberOfConstants, numberOfMotors, minNumberOfInstructions, maxNumberOfInstructions);
%             population(iIndividual).Chromosome = chromosome;
%             
%             for k = 1:numberOfPoints
%                 variableRegisters = zeros(1,numberOfMotors);
%                 variableRegisters(1) = X(k);      
%                 outputs(k) = ExecuteInstructions(chromosome, variableRegisters, constantRegisters);
%             end           
%         end
%         
%         errorPart = 0;
%         for k = 1:numberOfPoints
%             errorPart = errorPart + (outputs(k)-Y(k))^2;
%         end
%         e = sqrt(errorPart/numberOfPoints);
%         fitnessInGeneration(iIndividual) = 1/e;
        
        if fitnessInGeneration(iIndividual) > bestFitnessEver
            bestFitnessEver = fitnessInGeneration(iIndividual);
            bestChromosomeEver = chromosome;
%             bestOutputs = outputs;
%             plot(X, Y, X, outputs);
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
            newChromosomePairStructs = DoubleCross(chromosome1,chromosome2);
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
        mutatedChromosome = MutateLGP(chromosome, numberOfMotors, numberOfConstants, numberOfOperators, mutationProbability);
        newPopulation(i).Chromosome = mutatedChromosome;
    end
    
    % Elitism
    newPopulation(1).Chromosome = bestChromosomeEver;
    
    population = newPopulation;
    
    waitbar(iGeneration/numberOfGenerations);
end % End of generation
close(waitBar);

    % HR: We need a new "conclusion"
% plot(X, Y, X, bestOutputs);
% disp(['Best fitness ever: ' num2str(bestFitnessEver)]);
% disp(['Corresponding error: ' num2str(1/bestFitnessEver)]);
% 
% % Find the function given by the best chromosome
% expression = ExecuteInstructionsAnalytic(bestChromosomeEver, constantRegisters);
% disp('Corresponding expression:');
% disp(simplify(expression));