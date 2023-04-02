%% Creating the Elevation data input files for the SFINCS models (Script 2 of 5)  
% Identifying the applicable elevation data for the SFINCS model 
% Name: Hassaan Mohamed 
% Student Number: 1070154

clc;                        % Clear the command window 
close all;                  % Close all figures 
clear all;                  % Clear all existing variables

% First step is to make a directory of all the subfolders for the SFINCS models 
sfincs_dir = '';   
sfincs_dir_info = dir(fullfile(sfincs_dir, 'S*'));
sfincs_dir_info = natsortfiles (sfincs_dir_info); 
sfincs_dir_info(~[sfincs_dir_info.isdir]) = [];                         % To get rid of any S* that are potentially not folders 
sfincs_subfolders = fullfile (sfincs_dir,{sfincs_dir_info.name});       % Path of all subfolders for the sfincs models 

% Load the grid information from the mat files saved in the respective subfolders. 
% Loop over all subfolders to extract the Grid data that was saved from previous scripts

grid_info = [];                                                         % Intialilze the grid information matrix                                                          

for i = 1:length (sfincs_subfolders)
    current_folder = sfincs_subfolders{i};                              % Choose the subfolder
    grid_file = dir(fullfile(current_folder, 'G*.mat'));                
    grid_file_path = fullfile (current_folder, grid_file(1).name);      % Get the path of the mat file with the grid information
    grid_bb_load = load(grid_file_path);                                % Load the mat file with the grid infomation 

    grid_info = [grid_info; grid_bb_load.grid_variable];                % Combine the grid information of the current loop with the final matrix
end

clear i; clear current_folder; clear grid_file; clear grid_file_path; clear grid_bb_load; 

% Now with all the grid information loaded, define the bounding box information for the grids
% The bounding boxes are created using the minimum and maximum values of the X and Y coordinates 
% The orientation determines the specification of the four corners 

grid_bb_info = {};                                                      % Initialize the bounding box information cell array  

% Using a loop bounding box information for each grid is stored in cell 
for i = 1:height(grid_info)        %length (grid_info)
    if grid_info (i,5) == 90
    current_bb{i} = [max(grid_info(i,1:2)) min(grid_info(i,3:4)); 
                    min(grid_info(i,1:2)) min(grid_info(i,3:4)); 
                    min(grid_info(i,1:2)) max(grid_info(i,3:4)); 
                    max(grid_info(i,1:2)) max(grid_info(i,3:4)); 
                    max(grid_info(i,1:2)) min(grid_info(i,3:4))];
        else if grid_info (i,5) == 0
        current_bb{i} = [min(grid_info(i,1:2)) min(grid_info(i,3:4)); 
                    min(grid_info(i,1:2)) max(grid_info(i,3:4)); 
                    max(grid_info(i,1:2)) max(grid_info(i,3:4)); 
                    max(grid_info(i,1:2)) min(grid_info(i,3:4)); 
                    min(grid_info(i,1:2)) min(grid_info(i,3:4))]; 

            else if grid_info (i,5) == -90
            current_bb{i} = [min(grid_info(i,1:2)) max(grid_info(i,3:4)); 
                    max(grid_info(i,1:2)) max(grid_info(i,3:4)); 
                    max(grid_info(i,1:2)) min(grid_info(i,3:4)); 
                    min(grid_info(i,1:2)) min(grid_info(i,3:4)); 
                    min(grid_info(i,1:2)) max(grid_info(i,3:4))];

                else if grid_info (i,5) == 180
                current_bb{i} = [max(grid_info(i,1:2)) max(grid_info(i,3:4)); 
                    max(grid_info(i,1:2)) min(grid_info(i,3:4)); 
                    min(grid_info(i,1:2)) min(grid_info(i,3:4)); 
                    min(grid_info(i,1:2)) max(grid_info(i,3:4)); 
                    max(grid_info(i,1:2)) max(grid_info(i,3:4))];
                end
            end
        end
    end

    grid_bb_info {i} = current_bb{i};                                       % Adding the box information to the cell array 
end 

% Next step is to load the GeoTIFF files that would be needed to the bounding box check 
% The check using the inpoly2 and InterX functions are applied on the reprojected GeoTIFF files 
% This is because the grids and the model are based on the ESPG:3035 projection 
Tif_dir = '';
Tif_files = dir(fullfile(Tif_dir,'*.tif'));

% Also loaded is the original GeoTIFF files with the WGS84 projection
% These GeoTIFF files have the same names as the reprojected ones and are the files that are needed for merging and clipping later
% Reprojected GeoTIFF files are not recommended for the merging process as their edges do not align well and produces information gaps between the merged GeoTIFF files 
Tif_orig_dir = '';
Tif_orig_files = dir(fullfile(Tif_orig_dir,'*.tif'));

% Save the GeoTIFF file data in a MATLAB structure using the "geotiff_read" function
for i = 1:length(Tif_files)
   Tif_data(i) = geotiff_read(fullfile(Tif_dir,Tif_files(i).name), 'x','y');               
end

for i = 1: length(grid_bb_info)

    grid_bb = [grid_bb_info{i}(:,1), grid_bb_info{i}(:,2)];                 % Create the bounding box for the grid to execute the check 

    for j = 1:length(Tif_files)
    
        X = Tif_data(j).x;                                                  % Create the bounding box for the GeoTIFF file to execute the check 
        Y = Tif_data(j).y;
        Tif_bb=[min(X) min(Y);
                min(X) max(Y);
                max(X) max(Y);
                max(X) min(Y);
                min(X) min(Y)];
    
            [in,on]   = inpoly2([Tif_bb(:,1),Tif_bb(:,2)],[grid_bb(:,1),grid_bb(:,2)]);    % GeoTIFF file inside the grid?
            [in2,on2] = inpoly2([grid_bb(:,1),grid_bb(:,2)],[Tif_bb(:,1),Tif_bb(:,2)]);    % Grid inside the GeoTIFF file?
            p         = InterX(Tif_bb',grid_bb');                                          % GeoTIFF file and the grid crossing each other?
    
          if (sum(in)>0 || ~isempty(p) || sum(in2)>0)
                Tif_folder = Tif_orig_files(j).folder;                     % Define the source folder, where the original GeoTIFF file is saved                                     
                Sfincs_folder = sfincs_subfolders{i};                      % Define the destination folder where the relevant SFINCS model is saved 
    
                Tif_name = Tif_orig_files(j).name;                         % Define the name of the GeoTIFF to be copied 
    
                Tif_path = fullfile(Tif_folder, Tif_name);                 % Construct the full file path of the GeoTIFF file to be copied
                Sfincs_path = fullfile (Sfincs_folder, Tif_name);          % Construct the full file path for the destination folder where the GeoTIFF file is to be stored
    
                copyfile(Tif_path, Sfincs_path);
          end
     end 
end 


% After executing this script, the user should have all the GeoTIFF files that contribute to the relevant grid copied to the subsequent SFINCS model subfolder 

