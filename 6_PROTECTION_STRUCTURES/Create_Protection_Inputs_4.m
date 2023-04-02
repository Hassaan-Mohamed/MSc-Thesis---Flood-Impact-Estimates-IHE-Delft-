%% Incorporating the protection structures within the SFINCS models (Script 4 of 6)  
% sfincs.weir setup - Europe excluding Norway 
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
pd = table2array (readtable ('final_protection_CAM.csv')); 
pr_level = pd (:,5);

% To visualize the protection points 
geoscatter(pd(:,3), pd(:,4));
for i = 1:length(pd)
    text(pd(i,3), pd(i,4),num2str(i), 'HorizontalAlignment','center');
end 
%geoscatter(thin_dam_data(:,3), thin_dam_data(:,4),thin_dam_data(:,5))
%geodensityplot(lat, lon, ESL_Values)
geolimits([0 75],[-30 60])
geobasemap topographic

% Classify the weirs based on the analysis of the location from the geoplot
% SOUTH_FRANCE
weir_cam_1 = [pd(30:34,:);pd(15:17,:);pd(35:41,:);pd(18:21,:);pd(42,:);pd(22:24,:);pd(43,:);pd(25:26,:);pd(44,:);pd(13:14,:);pd(10:12,:);pd(45:51,:);pd(53,:);pd(52,:);pd(54:55,:);...
    pd(27:28,:);pd(1:9,:);pd(56:58,:);pd(29,:);pd(59:65,:);pd(67:70,:)];


weirs(1).x      =(weir_cam_1(:,1)).';
weirs(1).y      =(weir_cam_1(:,2)).';
weirs(1).z      =(weir_cam_1(:,5)).';
weirs(1).par1    =(repmat(0.6,length(weir_cam_1),1)); 


% Write the weir file 
inp.weirfile = 'sfincs.weir';
sfincs_write_obstacle_file_1par(inp.weirfile,weirs)


