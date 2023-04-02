%% Incorporating the protection structures within the SFINCS models (Script 3 of 7)  
% Setting up the protection levels using the ESL_data 
% Name: Hassaan Mohamed 
% Student Number: 1070154

clc;                        % Clear the command window 
close all;                  % Close all figures 
clear all;                  % Clear all existing variables


% Load the protection data from IHE & JRC  
% The protection data for europe specifically have been extracted using QGIS 
% The reprojection of the coordinates to EPSG:3035 (ETRS89-extended / LAEA Europe) has also been done in QGIS 
% The data is then saved in the directory as a csv file which is loaded here 
% Protection level is provided in column 5 of the data and is given as a return period. 
% We need to hence associate the relevant ESL level to the protection level provided 
protection_data = table2array (readtable ('protection_data')); 
XY_protection = [protection_data(:,1), protection_data(:,2)];
protection_level = protection_data (:,5);


% Import the ESL data needed to set the protection levels 
ESL_RP1    = table2array (readtable('ESL1_RPs_Baseline_median_RP1_reprojected.csv')); 
ESL_RP2    = table2array (readtable('ESL1_RPs_Baseline_median_RP2_reprojected.csv')); 
ESL_RP5    = table2array (readtable('ESL1_RPs_Baseline_median_RP5_reprojected.csv')); 
ESL_RP10   = table2array (readtable('ESL1_RPs_Baseline_median_RP10_reprojected.csv')); 
ESL_RP20   = table2array (readtable('ESL1_RPs_Baseline_median_RP20_reprojected.csv')); 
ESL_RP30   = table2array (readtable('ESL1_RPs_Baseline_median_RP30_reprojected.csv')); 
ESL_RP50   = table2array (readtable('ESL1_RPs_Baseline_median_RP50_reprojected.csv')); 
ESL_RP100  = table2array (readtable('ESL1_RPs_Baseline_median_RP100_reprojected.csv')); 
ESL_RP200  = table2array (readtable('ESL1_RPs_Baseline_median_RP200_reprojected.csv'));          
ESL_points = [ESL_RP1(:,1), ESL_RP1(:,2)]; 

% Classify the protection data points based on the level associated with it 
% There are only 6 unique values in the protection level data: 1,2,10,30,50,1000,10000
RP1_protection_points    = find (protection_level == 1); 
RP2_protection_points    = find (protection_level == 2); 
RP10_protection_points   = find (protection_level == 10); 
RP30_protection_points   = find (protection_level == 30); 
RP50_protection_points   = find (protection_level == 50);  
RP200_protection_points  = find (protection_level == 1000 | protection_level == 10000); 


% ESL and protection data coordinate points are not the same and the vector sizes are also different
% Find the ESL points that are closest to the protection data points so that the ESL data can be attached to the respective protection coordinates 
nearest_neighbour_RP1 = dsearchn (ESL_points,XY_protection(RP1_protection_points,:)); 
nearest_neighbour_RP2 = dsearchn (ESL_points,XY_protection(RP2_protection_points,:)); 
nearest_neighbour_RP10 = dsearchn (ESL_points,XY_protection(RP10_protection_points,:)); 
nearest_neighbour_RP30 = dsearchn (ESL_points,XY_protection(RP30_protection_points,:)); 
nearest_neighbour_RP50 = dsearchn (ESL_points,XY_protection(RP50_protection_points,:)); 
nearest_neighbour_RP200 = dsearchn (ESL_points,XY_protection(RP200_protection_points,:)); 

% Assign the ESL value that is from the relevant Return Period data to the protection points given in the text file  
protection = zeros(length(protection_level),1); 
protection(RP1_protection_points) = ESL_RP1(nearest_neighbour_RP1,5);
protection(RP2_protection_points) = ESL_RP2(nearest_neighbour_RP2,5);
protection(RP10_protection_points) = ESL_RP10(nearest_neighbour_RP10,5);
protection(RP30_protection_points) = ESL_RP30(nearest_neighbour_RP30,5);
protection(RP50_protection_points) = ESL_RP50(nearest_neighbour_RP50,5);
protection(RP200_protection_points) = ESL_RP200(nearest_neighbour_RP200,5);

% Write the X,Y coordinates and the ESL for the corresponding return period that models the protection in a single matrix 
final_protection = [protection_data(:,1:4), protection];

% This is then saved in a csv to be called within the next script, which will assign these elevation values to the DEM
writematrix(final_protection, 'Enter_Filename'); 



%% The scatter is just to visualize the protection levels across Europe 
geoscatter(protection_data(:,3), protection_data(:,4),protection_data(:,5))
%geodensityplot(, lon, ESL_Values)
geolimits([0 75],[-30 60])
geobasemap topographic
