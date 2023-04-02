%% Incorporating the protection structures within the SFINCS models (Script 1 of 7)  
% Setting up the protection levels using the ESL_data 
% Name: Hassaan Mohamed 
% Student Number: 1070154

clc;                        % Clear the command window 
close all;                  % Close all figures 
clear all;                  % Clear all existing variables


% Load the protection data from IHE & JRC 
protection_file = importdata ('protection4Michalis_final_usrestored.txt'); 
protection_data = protection_file.data; 

% Save the loaded data as a csv file in the directory to be reprojected using QGIS
csvwrite ('protection_data.csv', protection_data); 

% In the next script the reprojected protection_data will be utilized to execute the next steps 