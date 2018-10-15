function calcInterspikeInterval_2013MATLAB

%% Set variables here
%Spike Amplitude Threshold (absolute)
spikeThresh = 0;
%Minimum Spike Prominence (relative)
minSpikeProminence = 10;

%%

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
    [peakInterval{i}, spikeNumber] = calcInterval(yphysStruct,spikeThresh,minSpikeProminence);
    snum = snum + spikeNumber;
end

peakInterval = [peakInterval{:}];
figure; hist(peakInterval);
xlabel('Interspike interval (ms)');
ylabel('#spikes');
% outputData = [{'File'},{'InterspikeInterval'};f',peakInterval];
% outputData = cell2dataset(outputData);
fprintf('%s%d%s\n', 'Found ', snum, ' Spikes');
[f2,p2,fi] = uiputfile('InterSpikeIntervals.xlsx');
if fi
    xlswrite(fullfile(p2,f2),peakInterval');
end

function [peakInterval, spikeNumber] = calcInterval(yphysStruct,spikeThresh,minSpikeProminence)

spikeData = yphysStruct.data(:,2);
x = yphysStruct.data(:,1);
% pks = findpeaks(spikeData);

% findpeaks(spikeData,'minpeakdistance',10,'MinPeakHeight',0);
% [pks,locs] = findpeaks(spikeData,'minpeakdistance',10,'MinPeakHeight',4);
[locs,pks] = peakfinder(spikeData,minSpikeProminence,spikeThresh);
plot(x,spikeData);
plot(x(locs),pks,'k^','markerfacecolor',[1 0 0]);
locs = locs*x(1);

% smoothSpikeData = sgolayfilt(spikeData,7,21);

peakInterval = diff(locs)';
spikeNumber = length(locs);
% figure;
% histogram(peakInterval,10);