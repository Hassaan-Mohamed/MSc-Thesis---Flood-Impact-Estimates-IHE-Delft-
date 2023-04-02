%% Incorporating the protection structures within the SFINCS models (Script 6 of 6) 
% sfincs.thd setup - Creating the Thin Dams file for the SFINCS model    
% Name: Hassaan Mohamed 
% Student Number: 1070154

clc;                        % Clear the command window 
close all;                  % Close all figures 
clear all;                  % Clear all existing variables

% SFINCS has variety of options to input structures that can redirect or restrict the flow of water 
% This can be used to imitate the flood hazard mitigation approaches 
% In this model Thin Dams is implemented in coastlines that has a protection level higher than the ESL values
% This applies to regions with protection levels at RPs 1000 and 10,000 according to the protection data from Michalis Vousdoukas 
% With a thin dam, the flow through the grid cells is completely restricted as the dam acts as a wall that has infinite height 

% Load the protection data first 
protection_data = table2array (readtable ('protection_data_europe_reprojected')); 
protection_level = protection_data (:,5);

% Find the points that have a protection level higher than the largest return period for the ESL values 
thin_dams = find (protection_level > 200);
thin_dam_data = protection_data(thin_dams,:); 

% To visualize the thin dam points 
geoscatter(thin_dam_data(:,3), thin_dam_data(:,4));
for i = 1:length(thin_dam_data)
    text(thin_dam_data(i,3), thin_dam_data(i,4),num2str(i), 'HorizontalAlignment','center');
end 
%geoscatter(thin_dam_data(:,3), thin_dam_data(:,4),thin_dam_data(:,5))
%geodensityplot(lat, lon, ESL_Values)
geolimits([0 75],[-30 60])
geobasemap topographic

% Classify the thin dams based on the analysis of their location from the geoplot 
thin_dam_01 = thin_dam_data (1:69, :); 
thin_dam_02 = thin_dam_data (70:81, :); 
thin_dam_03 = thin_dam_data (82:84, :); 
thin_dam_04 = thin_dam_data (85:89, :); 
thin_dam_05 = thin_dam_data (90:93, :); 

% Make the thin dam input file using the sfincs_write_thin_dams function 
% The way to write the code is from SFINCS user manual number 4 on structures 

inp.thdfile = 'sfincs.thd'; 

thindams(1).x      = (thin_dam_01(:,1)).'; 
thindams(1).y      = (thin_dam_01(:,2)).';
thindams(1).name   = {'THD01'}; 

thindams(2).x      = (thin_dam_02(:,1)).'; 
thindams(2).y      = (thin_dam_02(:,2)).';
thindams(2).name   = {'THD02'}; 

thindams(3).x      = (thin_dam_03(:,1)).'; 
thindams(3).y      = (thin_dam_03(:,2)).';
thindams(3).name   = {'THD03'}; 

thindams(4).x      = (thin_dam_04(:,1)).'; 
thindams(4).y      = (thin_dam_04(:,2)).';
thindams(4).name   = {'THD04'}; 

thindams(5).x      = (thin_dam_05(:,1)).'; 
thindams(5).y      = (thin_dam_05(:,2)).';
thindams(5).name   = {'THD05'}; 

sfincs_write_thin_dams(inp.thdfile,thindams)

%% Next the generated thin dams file is to be copied to the sfincs subfolders

% Define the path to the thd file created above 
thd_file = '';

% Define the base directory of the SFINCS subfolders 
sfincs_dir = '';

DirList = dir (sfincs_dir);                     % Get a list of all files, including the folders
DirList = DirList([DirList.isdir]);             % Extract only the folders, not the regular files 
DirList = DirList (3:end);                      % Get rid of the first two folders: current and parent directories 

Folder_number = numel(DirList);                 % Count the number of subfolders

% Now copy the generated bzs file to all the subfolders you want
for k = 1 : Folder_number 
    subfolder = fullfile(sfincs_dir, DirList(k).name);
    copyfile(thd_file, fullfile(subfolder, 'sfincs.thd'));
end




