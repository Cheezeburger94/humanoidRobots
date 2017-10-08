function mutatedChromosome = MutateLGP(chromosome, ...
    numberOfMotors, numberOfOperators, ...
    valueRange, ...
    mutations, creepRate)

for ind = 1:3:length(chromosome)
    if mutations(2) < rand
        chromosome(ind) = ceil(numberOfOperators*rand);
    end
end

for ind = 2:3:length(chromosome)
    if mutations(2) < rand
        chromosome(ind) = ceil(numberOfMotors*rand);
    end
end

for ind = 3:3:length(chromosome)
    if mutations(3) < rand
        chromosome(ind) = chromosome(ind) - creepRate / 2 + rand * creepRate;
        if chromosome(ind) < valueRange(1)
            chromosome(ind) = valueRange(1);
        end
        if chromosome(ind) > valueRange(2)
            chromosome(ind) = valueRange(2);
        end
    end
end

mutatedChromosome = chromosome;
end

