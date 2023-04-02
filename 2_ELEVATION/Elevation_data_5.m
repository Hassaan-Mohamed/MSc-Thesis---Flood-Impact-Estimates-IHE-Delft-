%% Creating the Elevation data input files for the SFINCS models (Script 5 of 5)  
% Creating XYZ files from the clipped GeoTIFF files   
% Name: Hassaan Mohamed 
% Student Number: 1070154

clc;                        % Clear the command window 
close all;                  % Close all figures 
clear all;                  % Clear all existing variables

% First step is to make a directory of all the subfolders for the SFINCS models 
sfincs_dir = '';
%sfincs_dir = 'C:\Users\hmo008\Desktop\SFINCS_Europe_inp_files';
sfincs_dir_info = dir(fullfile(sfincs_dir, 'S*'));
sfincs_dir_info = natsortfiles (sfincs_dir_info); 
sfincs_dir_info(~[sfincs_dir_info.isdir]) = [];                         % To get rid of any S* that are potentially not folders 
sfincs_subfolders = fullfile (sfincs_dir,{sfincs_dir_info.name});       % Path of all subfolders for the sfincs models 


% Loop over all the subfolders and convert the clipped GeoTIFF file from previous scripts to XYZ files 
% These XYZ files can then be used to further check if there are any faults or errors when creating the sfincs.dep files that would input elevation data into the corresponding SFINCS model
% Plotting the XYZ can potentially show any errors or inconsistencies in the elevation data. 

for i = 1:length(sfincs_subfolders)
    current_folder = sfincs_subfolders{i};
    Tif_file = dir(fullfile(current_folder, 'cl*.tif'));
    
    xyzfil = fullfile(current_folder,[Tif_file.name(1:end-3:end) '.xyz']);
    status = data_io_tif2xyz(fullfile(current_folder,Tif_file.name),xyzfil,'epsgin',3035,'epsgout',3035); 
end 

% Creating the XYZ file is not mandatory for obtaining inputs of the SFINCS models using the methodology presented. 