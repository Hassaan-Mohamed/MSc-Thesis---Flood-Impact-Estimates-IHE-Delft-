%% Generating the input files for the Boundary Conditions of the SFINCS models (Script 3 of 3) 
% Attempt to make synthetic hydrographs from the water level inputs in the SFINCS model 
% Name: Hassaan Mohamed 
% Student Number: 1070154

clc;                        % Clear the command window 
close all;                  % Close al figures 
clear all;                  % Clear all existing variables

% This script will identify the boundary points and the synthetic hydrographs relevant to the particular SFINCS model based on its grid location
% Then save the sfincs.bzs and sfincs.bnd file to the respective SFINCS model subfolder

% Load the information that contains the locations of the boundary points and the hydrographs associated with those points from the previous script 
bc_info = load("Synthetic_hydrographs.mat"); 
bc_info = bc_info.zh_final; 
bc_x = bc_info(:,1);
bc_y = bc_info(:,2); 

sfincs_dir = '';
sfincs_dir_info = dir(fullfile(sfincs_dir, 'S*'));
sfincs_dir_info = natsortfiles (sfincs_dir_info); 
sfincs_dir_info(~[sfincs_dir_info.isdir]) = [];                         % To get rid of any S* that are potentially not folders 
sfincs_subfolders = fullfile (sfincs_dir,{sfincs_dir_info.name});       % Path of all subfolders for the sfincs models 

for i = 1:length(sfincs_subfolders)
    current_folder = sfincs_subfolders{i};
    mat_info  = dir(fullfile(current_folder,'G*.mat'));
    mat_names = fullfile (current_folder,{mat_info.name});
    mat_data = load(mat_names{1});

    % Define the geographical coordinates of the four corners of the grid
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

    % Check which boundary points fall within the grid extents 
    within_grid = (bc_x >= xmin) & (bc_x <= xmax) & (bc_y >= ymin) & (bc_y <= ymax);

    % Create a separate variable from just the boundary condition information that falls within the respective grid
    grid_bc = bc_info(within_grid,:); 

    % Create the information required for boundary points and boundary water-level time-series 
    bndfile = grid_bc(:,1:2);
    bnd_points.x = bndfile(:,1); 
    bnd_points.y = bndfile(:,2);
    bnd_points.length = length(bndfile);

    bzsfile = grid_bc(:,3:end).';
    bzsfile = round(bzsfile, 3); 

    % Remove the rows with only zeros 
    zero_rows = all(bzsfile == 0, 2);
    bzsfile(zero_rows, :) = [];

    % Find the row index of the first row containing a zero
    zero_row = find(any(bzsfile==0,2),1,'first');
    
    % If a zero row exists, delete it and all rows below it
    if ~isempty(zero_row)
        bzsfile(zero_row:end,:) = [];
    end
    
    % Add a row of zeros to the top and bottom of the bzsfile matrix 
    bzsfile = vertcat(zeros(1,size(bzsfile,2)), bzsfile); bzsfile = vertcat(bzsfile, zeros(1,size(bzsfile,2)));

    % Create the time array for the final bzs file
    % Time is given in seconds for the SFINCS model and the interval adopted here is 30 minutes or 1800 seconds
    num_rows = size(bzsfile,1);
    time = (0:1800:(num_rows-1)*1800)'; 

    bzsfile_final = [time bzsfile]; 


    % Create the sfincs.bnd and sfincs.bzs files in the respective SFINCS subfolders
    inp.bzsfile = fullfile(current_folder, 'sfincs.bzs');
    inp.bndfile = fullfile(current_folder, 'sfincs.bnd');

    sfincs_write_boundary_conditions (inp.bzsfile, time, bzsfile);
    sfincs_write_boundary_points (inp.bndfile, bnd_points); 

    % Update the time information on the sfincs.inp file 
    % Update the output information on the input file based on the runtime   
    start_time_str = '20230101 000000';                                             % Start time as a string
    start_time_dt = datetime(start_time_str, 'InputFormat', 'yyyyMMdd HHmmss');     % Convert start time to a datetime object
    stop_time_dt = start_time_dt + seconds(time(end));                              % Add storm duration time in seconds to the start time
    stop_time_str = datestr(stop_time_dt, 'yyyymmdd HHMMSS');                       % Format the stop time as a string in the required format

    % Open the sfincs.inp file for appending 
    fileID = fopen(fullfile(current_folder,'sfincs.inp'), 'a');
    fprintf (fileID,'tref         = %s\n','20230101 000000');
    fprintf (fileID,'tstart       = %s\n','20230101 000000');
    fprintf (fileID,'tstop        = %s\n', stop_time_str);
    fprintf (fileID,'dtmaxout     = %.0f\n', time(end));
    fprintf (fileID,'dtout        = %.0f\n', time(end));
end 

