function varargout = miphys(varargin)
% MIPHYS MATLAB code for miphys.fig
%      MIPHYS, by itself, creates a new MIPHYS or raises the existing
%      singleton*.
%
%      H = MIPHYS returns the handle to a new MIPHYS or the handle to
%      the existing singleton*.
%
%      MIPHYS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MIPHYS.M with the given input arguments.
%
%      MIPHYS('Property','Value',...) creates a new MIPHYS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before miphys_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to miphys_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help miphys

% Last Modified by GUIDE v2.5 04-Oct-2017 12:51:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @miphys_OpeningFcn, ...
                   'gui_OutputFcn',  @miphys_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before miphys is made visible.
function miphys_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to miphys (see VARARGIN)

% Choose default command line output for miphys
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes miphys wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = miphys_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sagMeasurementPB.
function sagMeasurementPB_Callback(hObject, eventdata, handles)
% hObject    handle to sagMeasurementPB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in calcSpikeIntervalPB.
function calcSpikeIntervalPB_Callback(hObject, eventdata, handles)
% hObject    handle to calcSpikeIntervalPB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
calcInterspikeInterval_2013MATLAB;

% --- Executes on button press in selectPeakPB.
function selectPeakPB_Callback(hObject, eventdata, handles)
% hObject    handle to selectPeakPB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ax,allLines] = findFig;
rect = getrect(ax);
%save for repeated use
set(hObject,'UserData',rect);
calcPeak(allLines, rect, handles);

function calcPeak(allLines, rect, handles)
xAll = [];
yAll = [];
for i = 1:length(allLines)
    xAll = [xAll, get(allLines(i),'XData')];
    yAll = [yAll, get(allLines(i),'YData')];
end
% vert = posToVert(rect,true);
% in = inpolygon(xAll,yAll,vert(:,1),vert(:,2));
xRange = [rect(1),rect(3) + rect(1)];
in = xAll > xRange(1) & xAll < xRange(2);
% x = xAll(in); 
y = yAll(in);
[~,ind] = max(y);
% x = x(ind); 
y = y(ind);
% hold(ax,'on');
% dt = str2double(get(handles.dtED,'String'));
% [~,ind2] = min(abs(xAll - (x+dt)));
% x2 = xAll(ind2); y2 = yAll(ind2);
% scatter([x,x2],[y,y2],'parent',ax);
% hold(ax,'off');
t = str2double(get(handles.dtED,'String'));
[~,ind2] = min(abs(xAll - t));
x2 = xAll(ind2); y2 = yAll(ind2);
set(handles.peakTX,'String',num2str(y));
set(handles.steadyTX,'String',num2str(y2));

function [ax,allLines] = findFig()
f = findobj('tag','yphys_plot');
ax = findall(f,'type','axes');
allLines = get(ax,'children');

function dtED_Callback(hObject, eventdata, handles)
% hObject    handle to dtED (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dtED as text
%        str2double(get(hObject,'String')) returns contents of dtED as a double


% --- Executes during object creation, after setting all properties.
function dtED_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dtED (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sagED_Callback(hObject, eventdata, handles)
% hObject    handle to sagED (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sagED as text
%        str2double(get(hObject,'String')) returns contents of sagED as a double


% --- Executes during object creation, after setting all properties.
function sagED_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sagED (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function baselineED_Callback(hObject, eventdata, handles)
% hObject    handle to baselineED (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of baselineED as text
%        str2double(get(hObject,'String')) returns contents of baselineED as a double


% --- Executes during object creation, after setting all properties.
function baselineED_CreateFcn(hObject, eventdata, handles)
% hObject    handle to baselineED (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in selectBaselinePB.
function selectBaselinePB_Callback(hObject, eventdata, handles)
% hObject    handle to selectBaselinePB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ax,allLines] = findFig;

rect = getrect(ax);

set(hObject,'UserData',rect); %save for later
calcBase(allLines,rect,handles);

function calcBase(allLines,rect,handles)
xAll = [];
yAll = [];
for i = 1:length(allLines)
    xAll = [xAll, get(allLines(i),'XData')];
    yAll = [yAll, get(allLines(i),'YData')];
end
% vert = posToVert(rect,true);
% in = inpolygon(xAll,yAll,vert(:,1),vert(:,2));
% x = xAll(in); 
xRange = [rect(1),rect(3) + rect(1)];
in = xAll > xRange(1) & xAll < xRange(2);
y = yAll(in);
baseline = mean(y);

peak = str2double(get(handles.peakTX,'String'));
steady = str2double(get(handles.steadyTX,'String'));

peakAmp = abs(peak - baseline);
steadyAmp = abs(steady - baseline);
fprintf('Peak: %.2f, Steady: %.2f, Baseline: %.2f\n',peak, steady, baseline);
set(handles.baselineTX,'String',num2str(baseline));
set(handles.peakAmpTX,'String',num2str(peakAmp));
set(handles.steadyAmpTX,'String',num2str(steadyAmp));



% --- Executes on button press in measureSAG.
function measureSAG_Callback(hObject, eventdata, handles)
% hObject    handle to measureSAG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
numFileStr = get(handles.numFilesED,'String');
indexGroups = strsplit(numFileStr,',');
indices = [];
for i = 1:length(indexGroups)
    indices = [indices, eval(indexGroups{i})];
end
if isempty(indices)
	fprintf('Input file indices. e.g. 23:45, 101, 20\n');
    return
end
repeats = length(indices);

sag = zeros(repeats,1);
steadyAmp = zeros(repeats,1);
peakAmp = zeros(repeats,1);
peakRaw = zeros(repeats,1);
steadyRaw = zeros(repeats,1);
baseline = zeros(repeats,1);


for i = 1:repeats
    ind = indices(i);
    setFileByNum(ind);
    pause(.1);
    [~,allLines] = findFig;
    rect = get(handles.selectPeakPB,'UserData');
    calcPeak(allLines, rect, handles);
    drawnow();
    pause(.1);
    rect2 = get(handles.selectBaselinePB,'UserData');
    calcBase(allLines, rect2, handles);
    drawnow();
    pause(.1);
    peakAmp(i) = str2double(get(handles.peakAmpTX,'String'));
    steadyAmp(i) = str2double(get(handles.steadyAmpTX,'String'));
	peakRaw(i) = str2double(get(handles.peakTX,'String'));
    steadyRaw(i) = str2double(get(handles.steadyTX,'String'));
    baseline(i) = str2double(get(handles.baselineTX,'String'));
    sag(i) =  abs(steadyAmp(i) / peakAmp(i));
    set(handles.sagTX,'String',num2str(sag(i)));
    drawnow();
    fprintf('\nSAG: %.2f\n',sag(i));
%     pause(.1);
%     if i~= repeats
%         yphys_stimScope('Post_Callback');
%     end
end
[FileName,PathName] = uiputfile('sag_peak_steady.xls');
if ~ischar(FileName)
    return
end
% fid = fopen(fullfile(PathName,FileName),'w');
% fclose(fid);

titles = {'SAG', 'PeakAmp', 'SteadyAmp', 'PeakRaw', 'SteadyRaw', 'BaselineRaw'};
data = num2cell([sag, peakAmp, steadyAmp, peakRaw, steadyRaw, baseline]);
if exist(fullfile(PathName,FileName)) == 2
    delete(fullfile(PathName,FileName));
end
xlswrite(fullfile(PathName,FileName),[titles;data]);

function setFileByNum(ind)
global yphys
indchar = num2str(ind);
if isfield(yphys, 'filename')
    [pathstr,filenamestr,extstr] = fileparts(yphys.filename);
        for i=1:3-length(indchar)
            indchar = ['0', indchar];
        end
		filenamestr = ['yphys', indchar];
end
if exist([pathstr, '\', filenamestr, extstr])
    yphys_loadYphys([pathstr, '\', filenamestr, extstr]);
end


function numFilesED_Callback(hObject, eventdata, handles)
% hObject    handle to numFilesED (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numFilesED as text
%        str2double(get(hObject,'String')) returns contents of numFilesED as a double


% --- Executes during object creation, after setting all properties.
function numFilesED_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numFilesED (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function HelpSubmenu_Callback(hObject, eventdata, handles)
% hObject    handle to HelpSubmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure('MenuBar','none','Name','Help','NumberTitle','off');
c = uicontrol('style','text','FontSize',10,'HorizontalAlignment','left');
set(c,'units','normalized');
set(c,'position',[.1,.1,.8,.8]);
s = sprintf('SAG MEASUREMENT: \n\n1. Navigate to the first file in stimScope.\n\n2. in MiPhys, enter the steady state time\n\n3. Click “select peak”, select the peak\n\n4. Click ”select baseline”, select baseline.\n\n5. put in the amount of files you have\n\n6. Click Measure Sag.\n\nAt the end it will ask you to save the csv file which has all the sag measurements.');
set(c,'string',s);
