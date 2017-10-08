function [chromosome, fitness] = LoadChromosome(fileName)
%LOADCHROMOSOME Summary of this function goes here
%   Detailed explanation goes here
disp('Loading chromosome from:')
disp(fileName)

fileID = fopen(fileName, 'r');

chromosome = str2num(fgetl(fileID));
fitness = str2num(fgetl(fileID));

end

