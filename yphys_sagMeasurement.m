function ratio = yphys_sagMeasurement(base_time, peak_time, steady_time, repeatCount)
%base_time: [first timepoint, last time point] (in ms)
%peak_time:  [first timepoint, last time point] (in ms)
%steady_time: [first timepoint, last time point] (in ms)
%repeatCount: (Optional) amount of times to run calculation
if nargin<4
    repeatCount=1;
end

for i=1:repeatCount
    peakV = yphys_averageDataPoints(peak_time) - yphys_averageDataPoints(base_time);
    
    steadyV = yphys_averageDataPoints(steady_time) - yphys_averageDataPoints(base_time);
    
    ratio(i) = peakV / steadyV;
    if i~=repeatCount
        yphys_stimScope('Post_Callback');
    end
end