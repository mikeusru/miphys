function calcInterspikeInterval

[f,p] = uigetfile('MultiSelect','on');

if ischar(f)
    f = {f};
    %     fName = fullfile(p,f);
    %     S = load(fName);
    %     fieldName = (fieldnames(S));
    %     yphysStruct = S.(fieldName{1});
end
peakInterval = cell(length(f),1);
figure; hAx = axes; hold on;
snum = 0;
for i=1:length(f)
    fName = fullfile(p,f{i});
    S = load(fName);
    fieldName = (fieldnames(S));
    yphysStruct = S.(fieldName{1});
    [peakInterval{i}, spikeNumber] = calcInterval(yphysStruct);
    snum = snum + spikeNumber;
end

peakInterval = [peakInterval{:}];
figure; histogram(peakInterval);
xlabel('Interspike interval (ms)');
ylabel('#spikes');
% outputData = [{'File'},{'InterspikeInterval'};f',peakInterval];
% outputData = cell2dataset(outputData);
[f2,p2] = uiputfile('InterSpikeIntervals.xlsx');
fprintf('%s%d%s\n', 'Found ', snum, ' Spikes');
xlswrite(fullfile(p2,f2),peakInterval');

function [peakInterval, spikeNumber] = calcInterval(yphysStruct)

spikeData = yphysStruct.data(:,2);
x = yphysStruct.data(:,1);
% pks = findpeaks(spikeData);

findpeaks(spikeData,x,'MinPeakWidth',1,'MinPeakHeight',0);
[~,locs] = findpeaks(spikeData,x,'MinPeakWidth',1,'MinPeakHeight',0);
% smoothSpikeData = sgolayfilt(spikeData,7,21);

peakInterval = diff(locs)';
spikeNumber = length(locs);
% figure;
% histogram(peakInterval,10);