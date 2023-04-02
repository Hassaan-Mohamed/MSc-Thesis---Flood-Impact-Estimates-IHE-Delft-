%% Generating the input files for the Boundary Conditions of the SFINCS models (Script 2 of 3) 
% Attempt to make synthetic hydrographs from the water level inputs in the SFINCS model 
% Name: Hassaan Mohamed 
% Student Number: 1070154

clc;                        % Clear the command window 
close all;                  % Close al figures 
clear all;                  % Clear all existing variables


% Store the current working directory first 
Orig_dir = pwd; 

% Make the current directory the file directory of the ESL data
ESL_dir = '';
cd (ESL_dir);
      

% Extract the data within the CSV file for easy processing 
ESL_table = readtable('ESL_data_points');
ESL_X = table2array (ESL_table(:,1));
ESL_Y = table2array (ESL_table(:,2));
ESL_lon = table2array (ESL_table(:,3));
ESL_lat = table2array (ESL_table(:,4));
ESL_values = table2array (ESL_table(:,5));


% Make the current directory the file directory of the ESSL data 

ESSL_dir = '';
cd (ESSL_dir);

ESSL_table = readtable('ESSL_data_RP100_reprojected.csv');
ESSL_X = table2array (ESSL_table(:,1));
ESSL_Y = table2array (ESSL_table(:,2));
ESSL_lon = table2array (ESSL_table(:,3));
ESSL_lat = table2array (ESSL_table(:,4));
ESSL_values = table2array (ESSL_table(:,5));

% Return to the original directory of the code and clear the directories from the workspace 
cd (Orig_dir);
clear ESL_dir;
clear ESSL_dir;
clear Orig_dir;

% ESL and ESSL coordinate points are not the same and the vector sizes are also different
% Find the ESSL points that are closest to the ESL points 
% Use the dsearchn function to identify the indexes that are closest
ESL_coordinates = [ESL_X ESL_Y];
ESSL_coordinates = [ESSL_X ESSL_Y];

nearest_neighbour = dsearchn (ESSL_coordinates, ESL_coordinates);  
ESSL_values_nearest = ESSL_values(nearest_neighbour);

% Now you have an estimated ESSL value for each ESL data point 
% Then progress to create the synthetic hydrographs based on the methodology adopted
event_duration_ini = 8*(ESSL_values_nearest)+10; 
min_value = 12; 
max_value = 48; 

% Limit the minimum and maximum event duration to 12 and 48 hours in accordance with the methodology 
event_duration = min(max(event_duration_ini,min_value), max_value);

% Form the hydrographs
for i = 1:length(event_duration)
    dt  = 0.5; 
    t   = 0:dt:event_duration(i);
    t0  = mean(t); 
    dd  = event_duration/2;
    zh{i} = interp1([0 t0 event_duration(i)] , [0 ESL_values(i) 0] , t).'; 
end


% Make all the hydrographs the same size so it can be concatenated together to an array
% Find the maximum row size for a hydrograph and add zeros to other hydrographs that have less values 
max_rows = max(cellfun(@(x) size(x,1), zh));
for i = 1:numel(zh)
    current_cell = zh{i};
    num_rows = size(current_cell, 1);
    if num_rows < max_rows
        additional_rows = max_rows - num_rows;
        zh{i} = [current_cell; zeros(additional_rows, 1)];
    end
end


% Create a double array from the cell array and concatenate them to a single array 
% Then combine the location and the hydrograph data into one final array 
zh_array = horzcat (zh{:}); 
zh_array_t = zh_array'; 

zh_final = [ESL_X ESL_Y zh_array_t]; 

save('Synthetic_hydrographs', "zh_final"); 

    






























































