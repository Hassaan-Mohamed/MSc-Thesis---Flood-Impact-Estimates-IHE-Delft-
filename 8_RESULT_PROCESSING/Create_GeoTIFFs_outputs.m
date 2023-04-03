%% Analysis of the results from the SFINCS models 
% Creating GeoTIFF files from the NetCDF format output files 
% Name: Hassaan Mohamed 
% Student Number: 1070154

clc;                        % Clear the command window 
close all;                  % Close al figures 
clear all;                  % Clear all existing variables

% First step is to make a directory of all the subfolders for the SFINCS models 
sfincs_dir = '';
sfincs_dir_info = dir(fullfile(sfincs_dir, 'S*'));
sfincs_dir_info = natsortfiles (sfincs_dir_info); 
sfincs_dir_info(~[sfincs_dir_info.isdir]) = [];                         % To get rid of any S* that are potentially not folders 
sfincs_subfolders = fullfile (sfincs_dir,{sfincs_dir_info.name});       % Path of all subfolders for the sfincs models 

% Read the shapefile of the location/region that corresponds to the results
M = m_shaperead('');
xv = [M.ncst{1}(:,1)];
yv = [M.ncst{1}(:,2)];


for i = 1:numel(sfincs_subfolders)
    current_folder = sfincs_subfolders{i};                              % Define the path and create a struct of the NetCDF file 
    netcdf_file = dir(fullfile(current_folder, 'sfincs_map.nc'));       % Define the name of the NetCDF file to read data from it
    netcdf_file_name = fullfile(current_folder,netcdf_file.name);

    x = ncread(netcdf_file_name, 'x');                                  % Read the X coordinate from the NetCDF file 
    y = ncread(netcdf_file_name, 'y');                                  % Read the Y coordinate from the NetCDF file 
    zsmax = ncread(netcdf_file_name, 'zsmax');                          % Read the maximum water level variable

    % Create a mask for the data
    mask = false(size(zsmax));
    [in,on] = inpoly2([x(:),y(:)],[xv, yv]);
    msk = mask(:);
    msk(in) = 1;

    mask = reshape(msk, size(zsmax));

    % Apply the mask to the water level data
    zsmax(~mask) = NaN;

    % Convert zsmax to centimeters
    zsmax_cm = zsmax * 100;
    
    % Round to the nearest integer
    zsmax_cm = round(zsmax_cm);
    
    % Replace zero and NaN values with NaN
    zsmax_cm(zsmax_cm == 0 | isnan(zsmax_cm)) = NaN;
    
    % MATLAB supports 1-, 2-, 4-, and 8-byte storage for integer data.
    % Save memory and execution time of programs by using the smallest integer type that accommodates the respective data.
    % Use flipud 
    zsmax_i16 = int16(zsmax_cm);
    zsmax_i16_flip = flipud(zsmax_i16);

    % Write the TIF file to the subfolder 
    bbox = [min(x(:)),min(y(:));max(x(:)),max(y(:))];
    tiff_id = ['output_',sprintf('%d',i),'.tif'];
    tiff_name = fullfile(current_folder,tiff_id);
    geotiffwrite(tiff_name,bbox,zsmax_i16_flip);
end 



% PLOTTING
% Plot the water level
% figure;
% pcolor(x, y, zsmax_cm);
% shading interp;
% colorbar;
% 
% hold on;
% 
% plot (xv, yv); 
% 
% xlabel('X');
% ylabel('Y');
% title('Maximum Water Level');










