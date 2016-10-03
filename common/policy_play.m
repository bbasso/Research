function varargout = policy_play(varargin)
% POLICY_PLAY M-file for policy_play.fig
%      POLICY_PLAY, by itself, creates a new POLICY_PLAY or raises the existing
%      singleton*.
%
%      H = POLICY_PLAY returns the handle to a new POLICY_PLAY or the handle to
%      the existing singleton*.
%
%      POLICY_PLAY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POLICY_PLAY.M with the given input arguments.
%
%      POLICY_PLAY('Property','Value',...) creates a new POLICY_PLAY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before policy_play_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to policy_play_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help policy_play

% Last Modified by GUIDE v2.5 29-May-2011 18:25:57


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @policy_play_OpeningFcn, ...
                   'gui_OutputFcn',  @policy_play_OutputFcn, ...
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
% Declare non-UI data here so that they can be used in any functions in
% this GUI file. 
% [s,x,params,world_handles] = init_smdp;

    % --- Executes just before policy_play is made visible.
    function policy_play_OpeningFcn(hObject, eventdata, handles, varargin)
        % This function has no output args, see OutputFcn.
        % hObject    handle to figure
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)
        % varargin   command line arguments to policy_play (see VARARGIN)

        % --- Executes during object creation, after setting all properties.

        % Choose default command line output for policy_play
        handles.output = hObject;

        % Update handles structure
        guidata(hObject, handles);

        %Set pushbutton to random image
        load playbutton;
        set(handles.pushbutton1,'CData',playbutton);

        function axes1_CreateFcn(hObject, eventdata, handles)
            % hObject    handle to axes1 (see GCBO)
            % eventdata  reserved - to be defined in a future version of MATLAB
            % handles    empty - handles not created until after all CreateFcns called

            [s,x,params,world_handles] = init_smdp;
            new_world_handles = draw_world(x(1), params, params.map,world_handles);
            world_handles = new_world_handles;
        end
    end



    % --- Outputs from this function are returned to the command line.
    function varargout = policy_play_OutputFcn(hObject, eventdata, handles)
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;
    end

    % --- Executes on button press in pushbutton1.
    function pushbutton1_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    axes(handles.axes1);
    % cla;
    [s,x,params,world_handles] = init_smdp;
    draw_world(x(1), params, params.map,world_handles);
    end


    % --------------------------------------------------------------------
    function FileMenu_Callback(hObject, eventdata, handles)
    % hObject    handle to FileMenu (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    end

    % --------------------------------------------------------------------
    function OpenMenuItem_Callback(hObject, eventdata, handles)
    % hObject    handle to OpenMenuItem (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    file = uigetfile('*.fig');
    if ~isequal(file, 0)
        open(file);
    end
    end

    % --------------------------------------------------------------------
    function PrintMenuItem_Callback(hObject, eventdata, handles)
    % hObject    handle to PrintMenuItem (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    printdlg(handles.figure1)
    end

    % --------------------------------------------------------------------
    function CloseMenuItem_Callback(hObject, eventdata, handles)
    % hObject    handle to CloseMenuItem (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                         ['Close ' get(handles.figure1,'Name') '...'],...
                         'Yes','No','Yes');
    if strcmp(selection,'No')
        return;
    end

    delete(handles.figure1)
    end

    % % --- Executes on selection change in popupmenu1.
    % function popupmenu1_Callback(hObject, eventdata, handles)
    % % hObject    handle to popupmenu1 (see GCBO)
    % % eventdata  reserved - to be defined in a future version of MATLAB
    % % handles    structure with handles and user data (see GUIDATA)
    % 
    % % Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
    % %        contents{get(hObject,'Value')} returns selected item from popupmenu1
    % 
    % 
    % % --- Executes during object creation, after setting all properties.
    % function popupmenu1_CreateFcn(hObject, eventdata, handles)
    % % hObject    handle to popupmenu1 (see GCBO)
    % % eventdata  reserved - to be defined in a future version of MATLAB
    % % handles    empty - handles not created until after all CreateFcns called
    % 
    % % Hint: popupmenu controls usually have a white background on Windows.
    % %       See ISPC and COMPUTER.
    % if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    %      set(hObject,'BackgroundColor','white');
    % end
    % 
    % set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)', 'draw_world'});

    % --- Executes during object creation, after setting all properties.
    function Agents_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to Agents (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
        set(handles.Agents,'Data',rand(4,2))
    end

    % --- Executes when entered data in editable cell(s) in Agents.
    function Agents_CellEditCallback(hObject, eventdata, handles)

    % hObject    handle to Agents (see GCBO)
    % eventdata  structure with the following fields (see UITABLE)
    %	Indices: row and column indices of the cell(s) edited
    %	PreviousData: previous data for the cell(s) edited
    %	EditData: string(s) entered by the user
    %	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
    %	Error: error string when failed to convert EditData to appropriate value for Data
    % handles    structure with handles and user data (see GUIDATA)
        agents = str2double(get(hObject, 'String'));
        handles.metricdata.density = agents;
        guidata(hObject,handles)
    end

    % --- Executes when entered data in editable cell(s) in Tasks.
    % function Tasks_CellEditCallback(hObject, eventdata, handles)
    % hObject    handle to Tasks (see GCBO)
    % eventdata  structure with the following fields (see UITABLE)
    %	Indices: row and column indices of the cell(s) edited
    %	PreviousData: previous data for the cell(s) edited
    %	EditData: string(s) entered by the user
    %	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
    %	Error: error string when failed to convert EditData to appropriate value for Data
    % handles    structure with handles and user data (see GUIDATA)


    % --- Executes during object creation, after setting all properties.
%     function Tasks_CreateFcn(hObject, eventdata, handles)
%     % hObject    handle to Tasks (see GCBO)
%     % eventdata  reserved - to be defined in a future version of MATLAB
%     % handles    empty - handles not created until after all CreateFcns called
%         if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%             set(hObject,'BackgroundColor','white');
%         end
%         set(handles.Agents,'Data',rand(4,2))
%     end

end


% --- Executes during object creation, after setting all properties.
function Tasks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tasks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


