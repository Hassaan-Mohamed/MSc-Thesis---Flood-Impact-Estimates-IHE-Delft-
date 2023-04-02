%% Generating the grids and main input files for the SFINCS models (Script 5 of 5)
% Creating the bounding box matrices based on the grid points 
% Name: Hassaan Mohamed 
% Student Number: 1070154

clc;                        % Clear the command window 
close all;                  % Close all figures 
clear all;                  % Clear all existing variables

% The grid bounding box data generated using this script will be used in other scripts 
% This bounding box would be called to clip the necessary elevation, friction and mask data to the corresponding grid of the model

% Load the first grid point from the Grid characteristics file created using the dedicated script 
Grid_details = readtable ('Grid_characteristics.csv');
Grid_array = table2array (Grid_details);
x0 = table2array (Grid_details (:,1));
y0 = table2array (Grid_details (:,2));


% Create the other three grid points using x0 & y0 
% The grid size utilized for simplification is approximately 100km x 100km 
q1_grid_idx = find(Grid_array (:,7) == 90);
q2_grid_idx = find(Grid_array (:,7) == 0);
q3_grid_idx = find(Grid_array (:,7) == -90);
q4_grid_idx = find(Grid_array (:,7) == 180);

X = zeros(height(Grid_array),2);
Y = zeros(height(Grid_array),2);

for i = 1:height(q1_grid_idx)
    X(q1_grid_idx(i),:) = [x0(q1_grid_idx(i)), x0(q1_grid_idx(i)) - 99.99*1000].';
    Y(q1_grid_idx(i),:) = [y0(q1_grid_idx(i)), y0(q1_grid_idx(i)) + 99.99*1000].';
end

for i = 1:height(q2_grid_idx)
    X(q2_grid_idx(i),:) = [x0(q2_grid_idx(i)), x0(q2_grid_idx(i)) + 99.99*1000].';
    Y(q2_grid_idx(i),:) = [y0(q2_grid_idx(i)); y0(q2_grid_idx(i)) + 99.99*1000].';
end

for i = 1:height(q3_grid_idx)
    X(q3_grid_idx(i),:) = [x0(q3_grid_idx(i)), x0(q3_grid_idx(i)) + 99.99*1000].';
    Y(q3_grid_idx(i),:) = [y0(q3_grid_idx(i)); y0(q3_grid_idx(i)) - 99.99*1000].';
end

for i = 1:height(q4_grid_idx)
    X(q4_grid_idx(i),:) = [x0(q4_grid_idx(i)), x0(q4_grid_idx(i)) - 99.99*1000].';
    Y(q4_grid_idx(i),:) = [y0(q4_grid_idx(i)); y0(q4_grid_idx(i)) - 99.99*1000].';
end

grid_bb = [X Y Grid_array(:,7)];    
writematrix (grid_bb, 'grid_bounding_boxes.csv')
    
% Save the grid information to the respective SFINCS model subfolders 
Main_Path = '...\SFINCS_inp_files';
  
if ~exist(Main_Path, 'dir')                                                             % Warn the user if the folder does not exist 
  message = sprintf('This folder does not exist:\n%s', Main_Path);
  uiwait(errordlg(message));
  return;
end    

DirList = dir(Main_Path);
DirList = DirList([DirList.isdir]);
DirList = DirList(3:end);
DirList = natsortfiles (DirList);                                                       % Sort the directory list in a logical manner  
NumberOfFolders = numel(DirList);                                                       % Count the number of subfolders

for k = 1:NumberOfFolders
    bb_dir = ['Grid_bb', sprintf('%d',k)];
    grid_variable = grid_bb(k,:);
    save(fullfile(Main_Path, DirList(k).name, bb_dir),'grid_variable'); 
end














