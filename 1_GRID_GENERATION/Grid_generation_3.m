%% Generating the grids and main input files for the SFINCS models (Script 3 of 5)
% Generating the grid information and the overall input file "sfincs.inp" based on the grid points  
% Name: Hassaan Mohamed 
% Student Number: 1070154

clc;                        % Clear the command window 
close all;                  % Close al figures 
clear all;                  % Clear all existing variables

% 7 outputs in total to define the grids 

% x0            = x-coordinate of the origin point
% y0            = y-coordinate of the origin point 
% nmax          = number of grid cells in x direction  
% mmax          = number of grid cells in y direction 
% dx, dy        = Size of the grid cells 
% rotation      = Angle taken in clockwise direction from the horizontal axis 

% Read the longitudes, lattitudes and orientation of the points 

Grid_pts = readtable ('ITA_Grid_Points.csv'); 
long = table2array (Grid_pts(:,1));
lat = table2array (Grid_pts(:,2)); 

Orientation = readtable ('orientation_grd_pts.csv');
orient = table2array (Orientation(:,3));

Grid_pts_array = [long, lat, orient];

% Identify the indexes of the points in each quadrant 

q1_grid_idx = find(orient >= 45 & orient <= 135);
q2_grid_idx = find(orient >= 315 | orient <= 45);
q3_grid_idx = find(orient >= 225 & orient <= 315);
q4_grid_idx = find(orient >= 135 & orient <= 225);

% Create arrays for the x & y values of the points for each quadrant 

q1_x_grid_pts = Grid_pts_array (q1_grid_idx, 1);
q1_y_grid_pts = Grid_pts_array (q1_grid_idx, 2);

q2_x_grid_pts = Grid_pts_array (q2_grid_idx, 1);
q2_y_grid_pts = Grid_pts_array (q2_grid_idx, 2);

q3_x_grid_pts = Grid_pts_array (q3_grid_idx, 1);
q3_y_grid_pts = Grid_pts_array (q3_grid_idx, 2);

q4_x_grid_pts = Grid_pts_array (q4_grid_idx, 1);
q4_y_grid_pts = Grid_pts_array (q4_grid_idx, 2);

%% Quadrant 1 - Grid generation 

q1_x0 = q1_x_grid_pts + (50*1000);
q1_x0_inp = q1_x_grid_pts - (50*1000);
q1_y0 = q1_y_grid_pts;
q1_y0_inp = q1_y_grid_pts;
q1_mmax = (repelem (3333, length(q1_grid_idx))).';
q1_nmax = (repelem (3333, length(q1_grid_idx))).';
q1_rotation = (repelem (90, length(q1_grid_idx))).';
q1_rotation_inp = (repelem (0, length(q1_grid_idx))).';

%% Quadrant 2 - Grid generation

q2_x0 = q2_x_grid_pts;
q2_x0_inp = q2_x_grid_pts;
q2_y0 = q2_y_grid_pts  - (50*1000);
q2_y0_inp = q2_y_grid_pts  - (50*1000);
q2_mmax = (repelem (3333, length(q2_grid_idx))).';
q2_nmax = (repelem (3333, length(q2_grid_idx))).';
q2_rotation = (repelem (0, length(q2_grid_idx))).';
q2_rotation_inp = (repelem (0, length(q2_grid_idx))).';

%% Quadrant 3 - Grid generation

q3_x0 = q3_x_grid_pts - (50*1000);
q3_x0_inp = q3_x_grid_pts - (50*1000);
q3_y0 = q3_y_grid_pts;
q3_y0_inp = q3_x_grid_pts - (100*1000);
q3_mmax = (repelem (3333, length(q3_grid_idx))).';
q3_nmax = (repelem (3333, length(q3_grid_idx))).';
q3_rotation = (repelem (-90, length(q3_grid_idx))).';
q3_rotation_inp = (repelem (0, length(q3_grid_idx))).';

%% Quadrant 4 - Grid generation

q4_x0 = q4_x_grid_pts;
q4_x0_inp = q4_x_grid_pts - (100*1000);
q4_y0 = q4_y_grid_pts  + (50*1000);
q4_y0_inp = q4_y_grid_pts  - (50*1000);
q4_mmax = (repelem (3333, length(q4_grid_idx))).';
q4_nmax = (repelem (3333, length(q4_grid_idx))).';
q4_rotation = (repelem (180, length(q4_grid_idx))).';
q4_rotation_inp = (repelem (0, length(q4_grid_idx))).';

%% Setting up the grid details 

x0 = [q1_x0; q2_x0; q3_x0; q4_x0]; 
y0 = [q1_y0; q2_y0; q3_y0; q4_y0];

x0_inp = [q1_x0_inp; q2_x0_inp; q3_x0_inp; q4_x0_inp];
y0_inp = [q1_y0_inp; q2_y0_inp; q3_y0_inp; q4_y0_inp];

mmax = [q1_mmax; q2_mmax; q3_mmax; q4_mmax];
nmax = [q1_nmax; q2_nmax; q3_nmax; q4_nmax];

dx = (repelem (30, height(Grid_pts_array))).';
dy = (repelem (30, height(Grid_pts_array))).';

rotation = [q1_rotation; q2_rotation; q3_rotation; q4_rotation]; 
rotation_inp = [q1_rotation_inp; q2_rotation_inp; q3_rotation_inp; q4_rotation_inp]; 

%% Extracting the grid characteristics  
% Current projection = EPSG:3035 (ETRS89-extended / LAEA Europe)

Grid_characteristics = [x0, y0, mmax, nmax, dx, dy, rotation];
writematrix(Grid_characteristics, 'Grid_characteristics.csv')
Grid_input = [x0_inp, y0_inp, mmax, nmax, dx, dy, rotation_inp];
writematrix(Grid_input, 'Grid_input.csv')

% Making the sfincs.inp files and the subfolders
New_Dir = fullfile('');
SFINCS_dir = fullfile(New_Dir, 'SFINCS_inp_files');
mkdir(SFINCS_dir);
for s = 1 : height (Grid_input)
   iddir = ['SFINCS_Setup', sprintf('%d',s)];
   idpath = fullfile(SFINCS_dir, iddir);
   mkdir(idpath);
end

Main_Path = '....\SFINCS_inp_files';

if ~exist(Main_Path, 'dir')                                                             % Warn the user if the folder does not exist 
  message = sprintf('This folder does not exist:\n%s', Main_Path);
  uiwait(errordlg(message));
  return;
end

DirList  = dir(Main_Path);                                                              % Get a list of all files, including folders
DirList  = DirList([DirList.isdir]);                                                    % Extract only the folders, not regular files
DirList  = DirList(3:end);                                                              % Get rid of first two folders: "." and ".."

if isempty(DirList)                                                                     % Warn the user if no subfolders exist
  message = sprintf('This folder does not contain any subfolders:\n%s', Main_Path);
  uiwait(errordlg(message));
  return;
end

DirList = natsortfiles (DirList);                                                       % Sort the directory list in a logical manner  
Folder_number = numel(DirList);                                                         % Count the number of subfolders

for k = 1 : Folder_number                                                               % Loop over all subfolders, processing each one
  thisDir = fullfile(Main_Path, DirList(k).name);
  cd (thisDir); 
  inputID(k) = fopen (sprintf('sfincs.inp'), 'wt');

%   fprintf (inputID(k),'SFINCS_European_Model_Input_file %d\n', k);
%   fprintf (inputID(k), '       \n');
  fprintf (inputID(k),'x0           = %.2f\n', Grid_input(k,1));
  fprintf (inputID(k),'y0           = %.2f\n', Grid_input(k,2));
  fprintf (inputID(k),'mmax         = %d\n', Grid_input(k,3));
  fprintf (inputID(k),'nmax         = %d\n', Grid_input(k,4));
  fprintf (inputID(k),'dx           = %d\n', Grid_input(k,5));
  fprintf (inputID(k),'dy           = %d\n', Grid_input(k,6));
  fprintf (inputID(k),'rotation     = %d\n', Grid_input(k,7));
  fprintf (inputID(k), '       \n'); 

  fprintf (inputID(k),'depfile      = %s\n','sfincs.dep');
  fprintf (inputID(k),'mskfile      = %s\n','sfincs.msk');
  fprintf (inputID(k),'manningfile  = %s\n','sfincs.man');
  fprintf (inputID(k),'weirfile     = %s\n','sfincs.weir');
  fprintf (inputID(k),'indexfile    = %s\n','sfincs.ind');
  fprintf (inputID(k), '       \n');

  fprintf (inputID(k),'bndfile      = %s\n','sfincs.bnd');
  fprintf (inputID(k),'bzsfile      = %s\n','sfincs.bzs');
  fprintf (inputID(k), '       \n');

  fprintf (inputID(k),'advection    = %s\n','0');
  fprintf (inputID(k),'alpha        = %s\n','0.75');
  fprintf (inputID(k),'huthresh     = %s\n','0.05');
  fprintf (inputID(k),'theta        = %s\n','0.9');
  fprintf (inputID(k),'qinf         = %s\n','0.0');
  fprintf (inputID(k), '       \n');

  fprintf (inputID(k),'inputformat  = %s\n','bin');
  fprintf (inputID(k),'outputformat = %s\n','net');
  fprintf (inputID(k), '       \n');
  
  fclose(inputID(k));
end




