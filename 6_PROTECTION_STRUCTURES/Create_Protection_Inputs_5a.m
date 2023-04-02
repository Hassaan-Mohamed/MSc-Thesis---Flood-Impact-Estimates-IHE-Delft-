%% Incorporating the protection structures within the SFINCS models (Script 5 of 6)  
% sfincs.weir setup - for Norway 
% Name: Hassaan Mohamed 
% Student Number: 1070154

clc;                        % Clear the command window 
close all;                  % Close all figures 
clear all;                  % Clear all existing variables

% SFINCS has variety of options to input structures that can redirect or restrict the flow of water 
% This can be used to imitate the flood hazard mitigation approaches 
% In the model weirs are one of the structures that is implemented to reduce the flood hazards 
% Weirs act similar to thin dams, but consists of a certain height (levee). 
% When the water level is higher than the weir, a flux over the weir is calculated by the SFINCS model 
% In a SFINCS model, the user can specify multiple polylines within one sfincs.weir file, where a maximum of 5000 supplied points are supported 
% Apart from the coordinate locations of the points (X,Y), the elevation (Z) and the coefficient of the weir formula (Cd) has to be specified. 
% The specified polylines based on the input points and snapped onto the SFINCS grid within the model

% Load the protection data first 
protection_data = table2array (readtable ('final_protection.csv')); 
pr_level = protection_data (:,5);

% To visualize the protection points 
geoscatter(protection_data(:,3), protection_data(:,4));
for i = 1:length(protection_data)
    text(protection_data(i,3), protection_data(i,4),num2str(i), 'HorizontalAlignment','center');
end 
%geoscatter(thin_dam_data(:,3), thin_dam_data(:,4),thin_dam_data(:,5))
%geodensityplot(lat, lon, ESL_Values)
geolimits([0 75],[-30 60])
geobasemap topographic


% NORWAY protection information 
weir_norway_1 = [protection_data(6479:6483,:);protection_data(6479,:)];
weir_norway_2 = [protection_data(6157:6162,:);protection_data(6157,:)];
weir_norway_3 = [protection_data(6196:6207,:);protection_data(6196,:)];
weir_norway_4 = [protection_data(6196:6207,:);protection_data(6196,:)];
weir_norway_5 = [protection_data(6215:6221,:);protection_data(6215,:)];
weir_norway_6 = protection_data(2826:4181,:); % Borders Russia on the north and Sweden down south 

% Write the weir file 
inp.weirfile = 'sfincs.weir';

weirs(1).x      =(weir_norway_1(:,1)).'; 
weirs(1).y      =(weir_norway_1(:,2)).';
weirs(1).z      =(weir_norway_1(:,5)).';
weirs(1).par1    =(repmat(0.6,length(weir_norway_1),1)); 

weirs(2).x      =(weir_norway_2(:,1)).'; 
weirs(2).y      =(weir_norway_2(:,2)).';
weirs(2).z      =(weir_norway_2(:,5)).';
weirs(2).par1    =(repmat(0.6,length(weir_norway_2),1)); 

weirs(3).x      =(weir_norway_3(:,1)).'; 
weirs(3).y      =(weir_norway_3(:,2)).';
weirs(3).z      =(weir_norway_3(:,5)).';
weirs(3).par1    =(repmat(0.6,length(weir_norway_3),1)); 

weirs(4).x      =(weir_norway_4(:,1)).'; 
weirs(4).y      =(weir_norway_4(:,2)).';
weirs(4).z      =(weir_norway_4(:,5)).';
weirs(4).par1    =(repmat(0.6,length(weir_norway_4),1)); 

weirs(5).x      =(weir_norway_5(:,1)).'; 
weirs(5).y      =(weir_norway_5(:,2)).';
weirs(5).z      =(weir_norway_5(:,5)).';
weirs(5).par1    =(repmat(0.6,length(weir_norway_5),1)); 

weirs(6).x      =(weir_norway_6(:,1)).'; 
weirs(6).y      =(weir_norway_6(:,2)).';
weirs(6).z      =(weir_norway_6(:,5)).';
weirs(6).par1    =(repmat(0.6,length(weir_norway_6),1)); 

sfincs_write_obstacle_file_1par(inp.weirfile,weirs)