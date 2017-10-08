function population = LoadPopulation(fileName)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here


population = []


disp('Loading population from:')
disp(fileName)

fileID = fopen(fileName, 'r');
while true
    line = fgetl(fileID);
    if line == -1
        break;
    end
    individual = struct('Chromosome', str2num(line));
    population = [population, individual];
end

end

