function SavePopulation(population, folderName, problemId, saveId, misc)

%SavePopulation Summary of this function goes here
%   Detailed explanation goes here


fileName = '';
if strcmp(misc, '')
    fileName = strcat(folderName, '/population.p', num2str(problemId), ...
        '.s', num2str(saveId), '.data');
else
    fileName = strcat(folderName, '/population.p', num2str(problemId), ...
        '.s', num2str(saveId), '.', misc, '.data');
end
tmpFileName = strcat(fileName, '.tmp');

disp('saving file to:')
disp(fileName)

%Copy the last file to the current file
try
    copyfile(fileName, tmpFileName, 'f')
end

fileID = fopen(fileName, 'w');

for i = 1:length(population)
    chromosome = population(i).Chromosome;
    
    fprintf(fileID, num2str(chromosome(1)));
    for index = 2:length(chromosome)
        fprintf(fileID, strcat(' ', num2str(chromosome(index))));
        fwrite(fileID, ' ');
    end
    fprintf(fileID, '\n');
end

fclose(fileID);


if exist(tmpFileName, 'file') == 2
    delete(tmpFileName);
end


end

