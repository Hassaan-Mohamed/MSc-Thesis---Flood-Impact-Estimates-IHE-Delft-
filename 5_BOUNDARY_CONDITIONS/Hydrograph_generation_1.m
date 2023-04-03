%% Generating the input files for the Boundary Conditions of the SFINCS models (Script 1 of 3) 
% Extracting data from the European Extreme Storm Surge Levels dataset 
% Name: Hassaan Mohamed 
% Student Number: 1070154

clc;                        % Clear the command window 
close all;                  % Close al figures 
clear all;                  % Clear all existing variables

%% Extracting data from the European Extreme Storm Surge level - Historical 

% Dataset containing extreme storm surge levels (ESSL) at European scale is obtained from the link below
% https://data.jrc.ec.europa.eu/dataset/0026aa70-cc6d-4f6f-8c2f-554a2f9b17f2
% ESSL will be used to determine the storm event durations later 

essl_info = ncinfo ('CoastAlRisk_Europe_EESSL_Historical.nc');
essl_lon = ncread ('CoastAlRisk_Europe_EESSL_Historical.nc', 'longitude');
essl_lat = ncread ('CoastAlRisk_Europe_EESSL_Historical.nc', 'latitude');
essl_data = ncread ('CoastAlRisk_Europe_EESSL_Historical.nc', 'ssl');
essl_RP = ncread ('CoastAlRisk_Europe_EESSL_Historical.nc', 'RP');

essl_RP5    = essl_data(1,:)';
essl_RP10   = essl_data(2,:)';
essl_RP20   = essl_data(3,:)';
essl_RP50   = essl_data(4,:)';
essl_RP100  = essl_data(5,:)';
essl_RP200  = essl_data(6,:)';
essl_RP500  = essl_data(7,:)';
essl_RP1000 = essl_data(8,:)';

ESSL_data_R5        = [essl_lon, essl_lat, essl_RP5];
ESSL_data_RP10      = [essl_lon, essl_lat, essl_RP10]; 
ESSL_data_RP20      = [essl_lon, essl_lat, essl_RP20]; 
ESSL_data_RP50      = [essl_lon, essl_lat, essl_RP50]; 
ESSL_data_RP100     = [essl_lon, essl_lat, essl_RP100]; 
ESSL_data_RP200     = [essl_lon, essl_lat, essl_RP200]; 
ESSL_data_RP500     = [essl_lon, essl_lat, essl_RP500]; 
ESSL_data_RP1000    = [essl_lon, essl_lat, essl_RP1000]; 

writematrix (ESSL_data_R5, 'ESSL_data_RP5.csv');
writematrix (ESSL_data_RP10, 'ESSL_data_RP10.csv');
writematrix (ESSL_data_RP20, 'ESSL_data_RP20.csv');
writematrix (ESSL_data_RP50, 'ESSL_data_RP50.csv');
writematrix (ESSL_data_RP100, 'ESSL_data_RP100.csv');
writematrix (ESSL_data_RP200, 'ESSL_data_RP200.csv');
writematrix (ESSL_data_RP500, 'ESSL_data_RP500.csv');
writematrix (ESSL_data_RP1000, 'ESSL_data_RP1000.csv');




%% To plot the ESSL data vs the ESL data 

% Make the current directory the file directory of the ESL data
% Store the current working directory first 
Orig_dir = pwd; 
ESL_dir = 'D:\IHE_Studies\Module_14_THESIS\SFINCS_MODELLING\SFINCS_ICELAND\MATLAB\Boundary_Conditions\ESL_Data';
cd (ESL_dir);
      

% Extract the data within the CSV file for easy processing 
ESL_table = readtable('ESL1_RPs_Baseline_median_RP100_reprojected.csv');
X = table2array (ESL_table(:,1));
Y = table2array (ESL_table(:,2));
lon = table2array (ESL_table(:,3));
lat = table2array (ESL_table(:,4));
ESL_Values = table2array (ESL_table(:,5));

% Return to the original directory of the code and clear the directories from the workspace 
cd (Orig_dir);
clear ESL_dir; 
clear Orig_dir;

figure
geoscatter(lat(1,:), lon(1,:),ESL_Values(1,:), 'Marker', 'o', 'MarkerEdgeColor','red')
k = 1:length(lat(1,:)); text(lat(1,:),lon(1,:),num2str(k'));
hold on
geoscatter(essl_lat, essl_lon,essl_RP100, 'Marker', 'x', 'MarkerEdgeColor','blue')
l = 1:length(essl_lat); text(essl_lat,essl_lon,num2str(l'));
%geodensityplot(lat, lon, ESL_Values)
geolimits([0 75],[-30 60])
geobasemap topographic


