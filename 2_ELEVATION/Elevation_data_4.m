%% Creating the Elevation data input files for the SFINCS models (Script 4 of 5)  
% Creating sfincs.dep files from the GeoTIFF files    
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

% Loop over all the subfolders and convert the clipped GeoTIFF from previous script to sfincs.dep 
% These sfincs.dep files are then read by the SFINCS models for the elevation data during the simulations

for i = 1:length(sfincs_subfolders)
    current_folder = sfincs_subfolders{i};
    Tif_file = dir(fullfile(current_folder, 'cl*.tif'));
    Tif_info = geotiff_read(fullfile(current_folder,Tif_file.name));

    Z = double(Tif_info.z);                                              % Store the GeoTIFF elevation data in a matrix to create the .dep files
    
    % Flip the matrix because the GeoTIFF information is saved with mapx and mapy values representing the easting and northing from the files upper-left corner 
    % However SFINCS input has the x0,y0 as the upper left corner values and an increasing y value going downwards. 
    % This is opposite of the gdalwarp output, hence the flip is necessary to be consistent with the mask, manning inputs and the coordinates of the model grid
    Z = flipud (Z);   

    dep_ascii_path = fullfile(current_folder,'sfincs_ascii.dep');
    writematrix(Z,dep_ascii_path,'FileType', 'text', 'Delimiter','tab');
end 





%% If needed, to extract data from XYZ file use the code below 

%     XYZ_file = dir(fullfile(current_folder, 'ct*'));
%     XYZ_file_path = fullfile(current_folder,XYZ_file(1).name);
% 
%     % Read the XYZ data from file
%     data = importdata(XYZ_file_path);
% 
%     % Extract the x, y, and z values from the data
%     x = data(:,1);
%     y = data(:,2);
%     z = data(:,3);
% 
%     % Specify the number of rows and columns in the square matrix
%     numRows = 3333;
%     numCols = 3333;
% 
%     % Reshape the Z values into a square matrix
%     Z = reshape(z, numRows, numCols);

%% BIN input creation (Optional) 

% If the user desires, the BIN format inputs can be generated at this stage too. 
% Use the code given below if needed. 
% The mask file for the model is required to carry out this step.

% inp.depfile = fullfile(current_folder, 'sfincs.dep');
% inp.mskfile = fullfile(current_folder, 'sfincs.msk');
% inp.indexfile = fullfile(current_folder, 'sfincs.ind');
% msk     = importdata(fullfile(current_folder, 'sfincs_ascii.msk'));
% 
% sfincs_write_binary_inputs(Z,msk,inp.indexfile,inp.depfile,inp.mskfile);