%% Generating the Friction input files for the SFINCS models (Script 1 of 1)
% Assigning the Manning roughness coefficients to the grid cells of the SFINCS models    
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

% Load the Copernicus Corine Land Cover TIF file 
% Get the general information of the TIF file 
TIF_directory = '';
TIF_files = dir(fullfile(TIF_directory, '*.tif'));
%TIF_info = geotiff_read(TIF_files.name);
TIF_info = geotifinfo_jre(TIF_files.name);
TIF_data = imread (TIF_files.name);

% Use a for loop to load the grid data for each model and create the subsequent friction (manning roughness coefficients) file 
for i = length(sfincs_subfolders)
    current_folder = sfincs_subfolders{i}; 
    mat_info  = dir(fullfile(current_folder,'G*.mat'));
    mat_names = fullfile (current_folder,{mat_info.name});
    current_file = mat_names{1};
    mat_data = load(current_file);

    % Define the geographical coordinates of the four corner of the grid
    if mat_data.grid_variable(5) == 90
        xmin = mat_data.grid_variable(2); xmax = mat_data.grid_variable(1); ymin = mat_data.grid_variable(3); ymax = mat_data.grid_variable(4);
    
        else if mat_data.grid_variable(5) == 0
            xmin = mat_data.grid_variable(1); xmax = mat_data.grid_variable(2); ymin = mat_data.grid_variable(3); ymax = mat_data.grid_variable(4);
    
            else if mat_data.grid_variable(5) == -90
                xmin = mat_data.grid_variable(1); xmax = mat_data.grid_variable(2); ymin = mat_data.grid_variable(4); ymax = mat_data.grid_variable(3);
    
                else if mat_data.grid_variable(5) == 180
                 xmin = mat_data.grid_variable(2); xmax = mat_data.grid_variable(1); ymin = mat_data.grid_variable(4); ymax = mat_data.grid_variable(3);
                 
                end 
            end 
        end 
    end 
    
    
    % Clip the Corine Land Cover TIF file to the grid bounding box using the gdalwarp command 
    clipped_Tif_file = fullfile(current_folder, 'manning_clipped.tif'); 
    Tif_file = TIF_files.name;
    clip_command = sprintf('gdalwarp -te %f %f %f %f %s %s', xmin, ymin, xmax, ymax, Tif_file, clipped_Tif_file);
    system (clip_command);
    
    % Load the clipped TIF file with the land cover information related to just the relevant grid extents 
    clipped_TIF_directory = current_folder;
    clipped_TIF_files = dir(fullfile(clipped_TIF_directory, 'm*.tif'));
    clipped_TIF_names = fullfile(clipped_TIF_directory, {clipped_TIF_files.name});
    current_clipped_TIF_file = clipped_TIF_names{1};
    clipped_TIF_data = geotiff_read(current_clipped_TIF_file);
    
    % Save the land cover data within the TIF file to a double matrix that can be processed further
    LC_data = double(clipped_TIF_data.z); 
    resized_LC_data = imresize(LC_data, [3333, 3333], "nearest");
    
    % Flip the matrix because the TIF information is saved with mapx and mapy values representing the easting and northing from the files upper-left corner 
    % However SFINCS input has the x0,y0 as the upper left corner values and an increasing y value going downwards. 
    % This is opposite of the gdalwarp output, hence the flip is necessary to be consistent with the mask, elevation inputs and the coordinates of the model grid
    resized_LC_data = flipud(resized_LC_data);


    
    % Create a new variable and assign the relevant manning roughness coefficients to the respective land cover types 
    manning_rc = resized_LC_data; 
    
    manning_rc(resized_LC_data == 1)       = 0.013;
    manning_rc(resized_LC_data == 2)       = 0.013;
    manning_rc(resized_LC_data == 3)       = 0.013;
    manning_rc(resized_LC_data == 4)       = 0.013;
    manning_rc(resized_LC_data == 5)       = 0.013;
    manning_rc(resized_LC_data == 6)       = 0.013;
    manning_rc(resized_LC_data == 7)       = 0.013;
    manning_rc(resized_LC_data == 8)       = 0.013;
    manning_rc(resized_LC_data == 9)       = 0.013;
    manning_rc(resized_LC_data == 10)      = 0.025;
    manning_rc(resized_LC_data == 11)      = 0.025;
    manning_rc(resized_LC_data == 12)      = 0.03;
    manning_rc(resized_LC_data == 13)      = 0.03;
    manning_rc(resized_LC_data == 14)      = 0.03;
    manning_rc(resized_LC_data == 15)      = 0.08;
    manning_rc(resized_LC_data == 16)      = 0.08;
    manning_rc(resized_LC_data == 17)      = 0.08;
    manning_rc(resized_LC_data == 18)      = 0.035;
    manning_rc(resized_LC_data == 19)      = 0.04;
    manning_rc(resized_LC_data == 20)      = 0.04;
    manning_rc(resized_LC_data == 21)      = 0.05;
    manning_rc(resized_LC_data == 22)      = 0.06;
    manning_rc(resized_LC_data == 23)      = 0.1;
    manning_rc(resized_LC_data == 24)      = 0.1;
    manning_rc(resized_LC_data == 25)      = 0.1;
    manning_rc(resized_LC_data == 26)      = 0.04;
    manning_rc(resized_LC_data == 27)      = 0.05;
    manning_rc(resized_LC_data == 28)      = 0.05;
    manning_rc(resized_LC_data == 29)      = 0.06;
    manning_rc(resized_LC_data == 30)      = 0.025;
    manning_rc(resized_LC_data == 31)      = 0.035;
    manning_rc(resized_LC_data == 32)      = 0.027;
    manning_rc(resized_LC_data == 33)      = 0.025;
    manning_rc(resized_LC_data == 34)      = 0.01;
    manning_rc(resized_LC_data == 35)      = 0.04;
    manning_rc(resized_LC_data == 36)      = 0.04;
    manning_rc(resized_LC_data == 37)      = 0.04;
    manning_rc(resized_LC_data == 38)      = 0.04;
    manning_rc(resized_LC_data == 39)      = 0.04;
    manning_rc(resized_LC_data == 40)      = 0.05;
    manning_rc(resized_LC_data == 41)      = 0.05;
    manning_rc(resized_LC_data == 42)      = 0.07;
    manning_rc(resized_LC_data == 43)      = 0.07;
    manning_rc(resized_LC_data == 44)      = 0.07;
    
    manning_rc(resized_LC_data == 0)       = 0.01;
    manning_rc(resized_LC_data == -128)    = 0.01;
    manning_rc(resized_LC_data == 48)      = 0.01;
    manning_rc(resized_LC_data == 128)     = 0.01; 
    
    % Save the 3333x3333 variable that includes all the relevant roughness coefficients for the area covered by the grid to the sfincs model subfolder
    % Every subfolder should have a sfincs.man file that gives the friction input for that model at the end of the process

    %manning_rc_path = fullfile(current_folder, 'sfincs.man');
    manning_rc_path = fullfile(current_folder,'sfincs_ascii.man');
    writematrix(manning_rc,manning_rc_path,'FileType', 'text', 'Delimiter','tab');

    %msk = importdata(fullfile(current_folder, 'sfincs_ascii.msk'));
    %inp.manningfile = fullfile(current_folder, 'sfincs.man');

    %sfincs_write_binary_roughness(manning_rc,msk,inp.manningfile);

    %writematrix(manning_rc,manning_rc_path,'FileType', 'text', 'Delimiter','tab')
    %dlmwrite(manning_rc_path, manning_rc, 'delimiter', '\t', 'precision', 3);
end 


% In the case of a Corine Land Cover (CLC) map, a value of -128 typically indicates that the land cover type for that pixel is unknown or not classified
% In other words, a value of -128 represents a "no data" or "nodata" value for that pixel. 
% This value is often used in remote sensing and GIS applications to indicate that a pixel should not be included in any further analysis or processing steps because the data for that pixel is not reliable or is missing.