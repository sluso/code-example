function varargout = visionwithcam(varargin)
% VISIONWITHCAM M-file for visionwithcam.fig
%      VISIONWITHCAM, by itself, creates a new VISIONWITHCAM or raises the existing
%      singleton*.
%
%      H = VISIONWITHCAM returns the handle to a new VISIONWITHCAM or the handle to
%      the existing singleton*.
%
%      VISIONWITHCAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VISIONWITHCAM.M with the given input arguments.
%
%      VISIONWITHCAM('Property','Value',...) creates a new VISIONWITHCAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before visionwithcam_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to visionwithcam_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help visionwithcam

% Last Modified by GUIDE v2.5 14-Oct-2012 10:18:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @visionwithcam_OpeningFcn, ...
                   'gui_OutputFcn',  @visionwithcam_OutputFcn, ...
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
end

% --- Executes just before visionwithcam is made visible.
function visionwithcam_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to visionwithcam (see VARARGIN)
% Choose default command line output for visionwithcam
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes visionwithcam wait for user response (see UIRESUME)
% uiwait(handles.figure1);

end
% --- Outputs from this function are returned to the command line.
function varargout = visionwithcam_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

end

% --- Executes on button press in load_image.
function load_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

vid=handles.vid;
start(vid); 
trigger(vid);
stoppreview(vid);
img= getdata(vid);
imwrite(img,'image.png');
handles.img=img;
guidata(hObject,handles);
end

% --- Executes on button press in sobel.
function sobel_Callback(hObject, eventdata, handles)
% hObject    handle to sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sobel
end

% --- Executes on button press in canny.
function canny_Callback(hObject, eventdata, handles)
% hObject    handle to canny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of canny
end

% --- Executes on button press in roberts.
function roberts_Callback(hObject, eventdata, handles)
% hObject    handle to roberts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of roberts

end
% --- Executes on button press in prewitt.
function prewitt_Callback(hObject, eventdata, handles)
% hObject    handle to prewitt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of prewitt


end
% --- Executes on button press in apply.
function apply_Callback(hObject, eventdata, handles)
% hObject    handle to apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A= rgb2gray(handles.img);
val1=get(handles.sobel,'Value');
val2=get(handles.prewitt,'Value');
val3=get(handles.roberts,'Value');
val4=get(handles.canny,'Value');
if val1==1
    B=edge(A,'sobel')
end
if val2==1
     B=edge(A,'prewitt')
end
    if val3==1
    B=edge(A,'roberts');
end
if val4==1
    B=edge(A,'canny')
end
handles.B=B;
axes(handles.axes2); 

imshow(B);

guidata(hObject,handles);

end


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
vid = videoinput('winvideo', 1, 'YUY2_640x480');
vid.FramesPerTrigger = 1;
vid.ReturnedColorspace = 'rgb';
triggerconfig(vid, 'manual');
vidRes = get(vid, 'VideoResolution');
imWidth = vidRes(1);
imHeight = vidRes(2);
nBands = get(vid, 'NumberOfBands');
hImage = image(zeros(imHeight, imWidth, nBands), 'parent', handles.axes1);
preview(vid, hImage);
handles.vid=vid;
guidata(hObject,handles);

end
