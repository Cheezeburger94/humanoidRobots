function population = LoadPopulation(folderName, problemId, saveId, misc)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here


population = []

fileName = '';
if strcmp(misc, '')
    fileName = strcat(folderName, '/population.p', num2str(problemId), ...
        '.s', num2str(saveId), '.data');
else
    fileName = strcat(folderName, '/population.p', num2str(problemId), ...
        '.s', num2str(saveId), '.', misc, '.data');
end

population = CustomLoadPopulation(fileName);

end