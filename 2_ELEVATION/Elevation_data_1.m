%% Creating the Elevation data input files for the SFINCS models (Script 1 of 5)  
% Reprojecting the GeoTIFF files to the desired projection system 
% Name: Hassaan Mohamed 
% Student Number: 1070154

clc;                        % Clear the command window 
close all;                  % Close all figures 
clear all;                  % Clear all existing variables

% Define the original folder and the destination folder for the GeoTIFF files 
origin_folder = '';
destin_folder = '';

% Get a list of all the TIF files in the original folder 
TIF_files = dir(fullfile(origin_folder, '*.tif'));

% Define the target projection
target_projection = 'EPSG:3035';

% Loop over the files in the folder and carryout the reprojection
% Utilize the gdalwarp function to carry out the reprojection 

for i = 1:length(TIF_files)
    origin_file = fullfile(origin_folder, TIF_files(i).name);       % Define the original file path
    destin_file = fullfile(destin_folder, TIF_files(i).name);       % Define the destination file path 

    system(['gdalwarp -t_srs ' target_projection ' ' origin_file ' ' destin_file]);  
end


%% Load and check the details of the new reprojected TIF files (If the user desires) 

% Read the new TIFF files 
% TIFS = dir(fullfile(destin_folder,'*.tif'));
% 
% 
% % Save the Tiff data in a matlab structure using the "geotiff_read" function
% for i = 1:length(TIFS)
%    Reprojected_TIF_data(i) = geotiff_read(fullfile(destin_folder,TIFS(i).name));               
% end







