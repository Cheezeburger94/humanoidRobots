function SaveChromosome(chromosome, fitness, ...
    folderName, problemId, ...
    saveId, misc)
%SavePopulation Summary of this function goes here
%   Detailed explanation goes here

if length(chromosome) == 0
    return
end

fileName = '';
if strcmp(misc, '')
    fileName = strcat(folderName, '/chromosome.p', num2str(problemId), ...
        '.s', num2str(saveId), '.data');
else
    fileName = strcat(folderName, '/chromosome.p', num2str(problemId), ...
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

fprintf(fileID, num2str(chromosome(1)));
for index = 2:length(chromosome)
    fprintf(fileID, strcat(' ', num2str(chromosome(index))));
    fwrite(fileID, ' ');
end
fprintf(fileID, '\n');
fprintf(fileID, num2str(fitness));
fprintf(fileID, '\n');


fclose(fileID);


if exist(tmpFileName, 'file') == 2
    delete(tmpFileName);
end


end

