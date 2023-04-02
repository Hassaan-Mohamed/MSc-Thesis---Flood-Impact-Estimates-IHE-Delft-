%% Creating the Elevation data input files for the SFINCS models (Script 3 of 5)  
% Clipping the elevation data to the respective grid extents  
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


% Load the information from the GeoTIFF files saved in the respective subfolders from the execution of previous script. 
% Loop over all subfolders to extract a list of GeoTIFF files in the subfolders and execute the gdal functions on them
for i = 1:numel(sfincs_subfolders)
    current_folder = sfincs_subfolders{i};
    cd (current_folder); 
    Tif_files = dir(fullfile(current_folder, 'C*.tif'));

    % Load the grid information mat file in the subfolder to extract the xmin, ymin, xmax and ymax values for the clipping procedure
    grid_file = dir(fullfile(current_folder, 'G*.mat'));                
    grid_file_path = fullfile (current_folder, grid_file(1).name);      % Get the path of the mat file with the grid information
    grid_bb_load = load(grid_file_path);                                % Load the mat file with the grid infomation 
    grid_info = [grid_bb_load.grid_variable];                           % Save the 4 grid points in an array to identify the 4 points of the grid bounding box
    
    xmin = min(grid_info(:,1:2));
    ymin = min(grid_info(:,3:4));
    xmax = max(grid_info(:,1:2));
    ymax = max(grid_info(:,3:4));
    
    % Create a list of GeoTIFF files as arguements for the gdalbuildvrt command                 
    Tif_file_list = strjoin(fullfile(current_folder, {Tif_files.name}), ' '); 

    % Build a virtual mosaic using the gdalbuildvrt command (merging)
    vrt_file = fullfile (current_folder, 'merged.vrt');                     
    merge_command = sprintf ('gdalbuildvrt %s %s', vrt_file, Tif_file_list);
    system (merge_command);

    % Convert the merged VRT file to a single-band GeoTIFF file using gdal_translate
    tif_file = fullfile(current_folder, 'merged.tif');
    translate_command = sprintf('gdal_translate -b 1 %s %s', vrt_file, tif_file);
    system (translate_command);

    % To clip the merged GeoTIFF file to the grid, reproject the GeoTIFF file again so that it matches with the grid coordinates
    % Define the target projection
    % Also define the target resolution of the clipped file. Consistency in resolution is critical
    target_projection = 'EPSG:3035';
    origin_file = 'merged.tif';
    destin_file = 'merged_reprojected.tif';
    system(['gdalwarp -t_srs ' target_projection ' -tr 30 30 ' origin_file ' ' destin_file]);

    % Clip the merged file to the grid bounding box using the gdalwarp command 
    clipped_Tif_file = fullfile(current_folder, 'clipped.tif'); 
    merged_Tif_file = fullfile(current_folder, 'merged_reprojected.tif'); 
    clip_command = sprintf('gdalwarp -te %f %f %f %f %s %s', xmin, ymin, xmax, ymax, merged_Tif_file, clipped_Tif_file);
    system (clip_command);

    % To save disk space delete the original GeoTIFF files and the merged GeoTIFF files 
    % Only the clipped GeoTIFF file is required to proceed further with obtaining the elevation for the respective grid and sfincs model 
    delete_files = dir(fullfile(current_folder, 'Cop*'));
    delete_files = [delete_files; dir(fullfile(current_folder, 'mer*'))];
    
    % Loop over each file and delete it
    for d = 1:length(delete_files)
        file = fullfile(current_folder, delete_files(d).name); 
        delete(file);
    end 
end 


% After executing this script, the user should have the clipped GeoTIFF file providing the required elevation data for the respective grid in the relevant SFINCS model subfolder 







    