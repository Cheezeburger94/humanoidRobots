function selectedIndex = TournamentSelect(fitnessValues, ...
    selectionParameter, tournamentSize)
% TOURNAMENTSELECT     Perform a tournament selection
%   iSelected = TOURNAMENTSELECT(FITNESSVALUES, SELECTIONPARAMETER, TOURNAMENTSIZE)
%               perform a tournament selection
%
%   FITNESSVALUES: The fitness values
%   SELECTIONPARAMETER: The parameter for selection 0-1, ie the probability
%                       for the better fittness value to win against the
%                       lower one
%   TOURNAMENTSIZE: The amount of fitness values to participate in the
%                   tournament
%
% @Author: Christoffer Dahlen
% @Course: Stocastic Optimization Algorithms
% @Date: 2016-09-14
%
populationSize = length(fitnessValues);

indices = 1:populationSize;
actualTournamentSize = min(tournamentSize, populationSize);

selectedFitness = zeros(1, tournamentSize);
selectedIndices = zeros(1, tournamentSize);

% Pick out random values of fitnesses and indexes without
% chosing one twice
for i = 1:actualTournamentSize
    currentPopSize = length(fitnessValues);
    iTmp1 = 1 + fix(rand*currentPopSize);
    
    selectedFitness(i) = fitnessValues(iTmp1);
    selectedIndices(i) = indices(iTmp1);
    
    fitnessValues(iTmp1) = [];
    indices(iTmp1) = [];
end

% Sort the indicies in order of corresponding fitness
[~, order] = sort(selectedFitness, 'descend');
selectedIndices = selectedIndices(order);

for index = selectedIndices(1:end-1)
    if rand < selectionParameter
        iSelected = index;
        return
    end
    
end

iSelected = selectedIndices(end);
end
