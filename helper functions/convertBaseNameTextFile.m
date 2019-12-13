function newStruct = convertBaseNameTextFile(path)
% filename = 'TestFiles/BaseName027.txt';
fid = fopen(path);
C = textscan(fid, '%s %s', 'delimiter', '=');
fclose(fid);

newStruct = struct;
remainingCells = {};

for i = 1:length(C{1})
    if ~isempty(C{2}{i})
        newStruct.(C{1}{i}) = stringToNumberIfNumber(C{2}{i});
    else
        remainingCells(end+1,1) = C{1}(i);
    end
end

dataInd = find(~cellfun(@isempty, strfind(remainingCells,'Data')));
newStruct.data1 = cell2mat(textscan(remainingCells{dataInd+1}, '%f32', 'delimiter', ','));
newStruct.data2 = cell2mat(textscan(remainingCells{dataInd+2}, '%f32', 'delimiter', ','));

t = [1/newStruct.outputRate:1/newStruct.outputRate:length(newStruct.data1)/newStruct.outputRate]';
newStruct.data1 = [t, newStruct.data1];
newStruct.data2 = [t, newStruct.data2];


function output = stringToNumberIfNumber(str)
output = str;
if ~isempty(str2num(str))
    output = str2num(str);
end
