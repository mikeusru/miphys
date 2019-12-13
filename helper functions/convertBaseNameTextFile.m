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
x = cell2mat(textscan(remainingCells{dataInd+1}, '%f32', 'delimiter', ','));
y = cell2mat(textscan(remainingCells{dataInd+2}, '%f32', 'delimiter', ','));

newStruct.data = [x,y];

function output = stringToNumberIfNumber(str)
output = str;
if ~isempty(str2num(str))
    output = str2num(str);
end
