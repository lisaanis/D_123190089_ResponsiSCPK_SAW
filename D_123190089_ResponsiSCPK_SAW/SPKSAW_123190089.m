function varargout = SPKSAW_123190089(varargin)
% SPKSAW_123190089 MATLAB code for SPKSAW_123190089.fig
%      SPKSAW_123190089, by itself, creates a new SPKSAW_123190089 or raises the existing
%      singleton*.
%
%      H = SPKSAW_123190089 returns the handle to a new SPKSAW_123190089 or the handle to
%      the existing singleton*.
%
%      SPKSAW_123190089('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPKSAW_123190089.M with the given input arguments.
%
%      SPKSAW_123190089('Property','Value',...) creates a new SPKSAW_123190089 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SPKSAW_123190089_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SPKSAW_123190089_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SPKSAW_123190089

% Last Modified by GUIDE v2.5 25-Jun-2021 23:35:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SPKSAW_123190089_OpeningFcn, ...
                   'gui_OutputFcn',  @SPKSAW_123190089_OutputFcn, ...
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


% --- Executes just before SPKSAW_123190089 is made visible.
function SPKSAW_123190089_OpeningFcn(hObject, eventdata, handles, varargin)
global p
p.MyData = [];

handles.output = hObject;
guidata(hObject, handles);

% UIWAIT makes SPKSAW_123190089 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SPKSAW_123190089_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
opts = detectImportOptions('DATA RUMAH.xlsx'); %mengambil file yang akan dipilih
opts.SelectedVariableNames = [3:8]; %memilih data pada kolom 3,4,5,6,7,8
x = readmatrix('DATA RUMAH.xlsx', opts);%data kriteria alternatif 
k=[0,1,1,1,1,1];%nilai atribut, dimana 0= atribut COST &1= atribut BENEFIT
w=[0.3,0.2,0.23,0.1,0.07,0.1];% bobot untuk masing-masing kriteria

%langkah kesatu normalisasi matriks
[m n]=size (x); %matriks m x n dengan ukuran sebanyak variabel x(input)
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
Y=zeros (m,n); %membuat matriks Y, yang merupakan titik kosong
for j=1:n,
    if k(j)==1, %statement untuk kriteria dengan atribut keuntungan
        R(:,j)=x(:,j)./max(x(:,j));
    else
        R(:,j)=min(x(:,j))./x(:,j);
    end;
end;

%langkah kedua, proses perangkingan
for i=1:m,
    V(i)= sum(w.*R(i,:));
end;

%langkah ketiga, mengurutkan data 20 terbaik
[poin number] = sort(V, 'descend'); %mengurutkan data
global p %deklarasikan var p
for z=1:20,
    hasilV = poin(z); %menyimpan data nilai vektor V
    NoRumah = number(z); %menyimpan data nilai urutan atau no Rumah
    p.MyData = [p.MyData; [hasilV NoRumah]];
    set(handles.uitable2,'data', p.MyData); %menampilkan data ke uitable1
end;

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
%memanggil file untuk ditampilkan di uitable1
opts = detectImportOptions('DATA RUMAH.xlsx'); %mengambil file yang akan dipilih
opts.SelectedVariableNames = [1 3:8]; %memilih data pada kolom 1,3,4,5,6,7,8
data = readmatrix('DATA RUMAH.xlsx', opts); %membaca file xlsx yang sudah dipilih kolomnya
set(handles.uitable1,'data', data); %menampilkan data ke uitable1
