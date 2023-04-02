%% Incorporating the protection for the Continental Scale SFINCS model (Script 5b of 7)  
% sfincs.weir input setup 
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

load('w_uk_1.mat');load('w_uk_2.mat');load('w_uk_3.mat');load('w_uk_4.mat');load('w_uk_5.mat');
load('w_uk_6.mat');load('w_uk_7.mat');load('w_uk_8.mat');load('w_uk_9.mat');load('w_uk_10.mat');
load('w_uk_11.mat');load('w_uk_12.mat');load('w_uk_13.mat');load('w_uk_14.mat');load('w_uk_15.mat');
load('w_uk_16.mat');load('w_uk_17.mat');load('w_uk_18.mat');load('w_uk_19.mat');load('w_uk_20.mat');

% % To visualize the protection points 
% geoscatter(protection_data(:,3), protection_data(:,4));
% for i = 1:length(protection_data)
%     text(protection_data(i,3), protection_data(i,4),num2str(i), 'HorizontalAlignment','center');
% end 
% %geoscatter(thin_dam_data(:,3), thin_dam_data(:,4),thin_dam_data(:,5))
% %geodensityplot(lat, lon, ESL_Values)
% geolimits([0 75],[-30 60])
% geobasemap topographic

% Classify the weirs based on the analysis of the location from the geoplot

% SCOTLAND 
weir_scotland_1 = [protection_data(5948:5952,:);protection_data(5948,:)];
weir_scotland_2 = [protection_data(5848:5858,:);protection_data(5848,:)];
weir_scotland_3 = [protection_data(6021:6028,:);protection_data(6021,:)];
weir_scotland_4 = [protection_data(5742:5760,:);protection_data(5742,:)];
weir_scotland_5 = [protection_data(6386:6389,:);protection_data(6386,:)];
weir_scotland_6 = [protection_data(6406:6409,:);protection_data(6406,:)];
weir_scotland_7 = [protection_data(6298:6300,:);protection_data(6298,:)];
weir_scotland_8 = [protection_data(5566:5595,:);protection_data(5566,:)];
weir_scotland_9 = [protection_data(6438:6440,:);protection_data(6438,:)];
weir_scotland_10 = [protection_data(6454:6457,:);protection_data(6454,:)];
weir_scotland_11 = [protection_data(6044:6053,:);protection_data(6044,:)];
weir_scotland_12 = [protection_data(6390:6394,:);protection_data(6390,:)];
weir_scotland_13 = [protection_data(6054:6065,:);protection_data(6054,:)];
weir_scotland_14 = [protection_data(5524:5565,:);protection_data(5524,:)];
weir_scotland_15 = [protection_data(6237:6241,:);protection_data(6237,:)];
weir_scotland_16 = [protection_data(5875:5891,:);protection_data(5875,:)];
weir_scotland_17 = [protection_data(6511:6514,:);protection_data(6511,:)];
weir_scotland_18 = [protection_data(6487:6492,:);protection_data(6487,:)];
weir_scotland_19 = [protection_data(5672:5716,:);protection_data(5672,:)];
weir_scotland_20 = [protection_data(5672:5716,:);protection_data(5672,:)];
weir_scotland_21 = protection_data(4482:4726,:);

weirs(1).x      =(weir_scotland_1(:,1)).'; 
weirs(1).y      =(weir_scotland_1(:,2)).';
weirs(1).z      =(weir_scotland_1(:,5)).';
weirs(1).par1    =(repmat(0.6,length(weir_scotland_1),1));

weirs(2).x      =(weir_scotland_2(:,1)).'; 
weirs(2).y      =(weir_scotland_2(:,2)).';
weirs(2).z      =(weir_scotland_2(:,5)).';
weirs(2).par1    =(repmat(0.6,length(weir_scotland_2),1));

weirs(3).x      =(weir_scotland_3(:,1)).'; 
weirs(3).y      =(weir_scotland_3(:,2)).';
weirs(3).z      =(weir_scotland_3(:,5)).';
weirs(3).par1    =(repmat(0.6,length(weir_scotland_3),1));

weirs(4).x      =(weir_scotland_4(:,1)).'; 
weirs(4).y      =(weir_scotland_4(:,2)).';
weirs(4).z      =(weir_scotland_4(:,5)).';
weirs(4).par1    =(repmat(0.6,length(weir_scotland_4),1));

weirs(5).x      =(weir_scotland_5(:,1)).'; 
weirs(5).y      =(weir_scotland_5(:,2)).';
weirs(5).z      =(weir_scotland_5(:,5)).';
weirs(5).par1    =(repmat(0.6,length(weir_scotland_5),1));

weirs(6).x      =(weir_scotland_6(:,1)).'; 
weirs(6).y      =(weir_scotland_6(:,2)).';
weirs(6).z      =(weir_scotland_6(:,5)).';
weirs(6).par1    =(repmat(0.6,length(weir_scotland_6),1));

weirs(7).x      =(weir_scotland_7(:,1)).'; 
weirs(7).y      =(weir_scotland_7(:,2)).';
weirs(7).z      =(weir_scotland_7(:,5)).';
weirs(7).par1    =(repmat(0.6,length(weir_scotland_7),1));

weirs(8).x      =(weir_scotland_8(:,1)).'; 
weirs(8).y      =(weir_scotland_8(:,2)).';
weirs(8).z      =(weir_scotland_8(:,5)).';
weirs(8).par1    =(repmat(0.6,length(weir_scotland_8),1));

weirs(9).x      =(weir_scotland_9(:,1)).'; 
weirs(9).y      =(weir_scotland_9(:,2)).';
weirs(9).z      =(weir_scotland_9(:,5)).';
weirs(9).par1    =(repmat(0.6,length(weir_scotland_9),1));

weirs(10).x      =(weir_scotland_10(:,1)).'; 
weirs(10).y      =(weir_scotland_10(:,2)).';
weirs(10).z      =(weir_scotland_10(:,5)).';
weirs(10).par1    =(repmat(0.6,length(weir_scotland_10),1));

weirs(11).x      =(weir_scotland_11(:,1)).'; 
weirs(11).y      =(weir_scotland_11(:,2)).';
weirs(11).z      =(weir_scotland_11(:,5)).';
weirs(11).par1    =(repmat(0.6,length(weir_scotland_11),1));

weirs(12).x      =(weir_scotland_12(:,1)).'; 
weirs(12).y      =(weir_scotland_12(:,2)).';
weirs(12).z      =(weir_scotland_12(:,5)).';
weirs(12).par1    =(repmat(0.6,length(weir_scotland_12),1));

weirs(13).x      =(weir_scotland_13(:,1)).'; 
weirs(13).y      =(weir_scotland_13(:,2)).';
weirs(13).z      =(weir_scotland_13(:,5)).';
weirs(13).par1    =(repmat(0.6,length(weir_scotland_13),1));

weirs(14).x      =(weir_scotland_14(:,1)).'; 
weirs(14).y      =(weir_scotland_14(:,2)).';
weirs(14).z      =(weir_scotland_14(:,5)).';
weirs(14).par1    =(repmat(0.6,length(weir_scotland_14),1));

weirs(15).x      =(weir_scotland_15(:,1)).'; 
weirs(15).y      =(weir_scotland_15(:,2)).';
weirs(15).z      =(weir_scotland_15(:,5)).';
weirs(15).par1    =(repmat(0.6,length(weir_scotland_15),1));

weirs(16).x      =(weir_scotland_16(:,1)).'; 
weirs(16).y      =(weir_scotland_16(:,2)).';
weirs(16).z      =(weir_scotland_16(:,5)).';
weirs(16).par1    =(repmat(0.6,length(weir_scotland_16),1));

weirs(17).x      =(weir_scotland_17(:,1)).'; 
weirs(17).y      =(weir_scotland_17(:,2)).';
weirs(17).z      =(weir_scotland_17(:,5)).';
weirs(17).par1    =(repmat(0.6,length(weir_scotland_17),1));

weirs(18).x      =(weir_scotland_18(:,1)).'; 
weirs(18).y      =(weir_scotland_18(:,2)).';
weirs(18).z      =(weir_scotland_18(:,5)).';
weirs(18).par1    =(repmat(0.6,length(weir_scotland_18),1));

weirs(19).x      =(weir_scotland_19(:,1)).'; 
weirs(19).y      =(weir_scotland_19(:,2)).';
weirs(19).z      =(weir_scotland_19(:,5)).';
weirs(19).par1    =(repmat(0.6,length(weir_scotland_19),1));

weirs(20).x      =(weir_scotland_20(:,1)).'; 
weirs(20).y      =(weir_scotland_20(:,2)).';
weirs(20).z      =(weir_scotland_20(:,5)).';
weirs(20).par1    =(repmat(0.6,length(weir_scotland_20),1));

weirs(21).x      =(weir_scotland_21(:,1)).'; 
weirs(21).y      =(weir_scotland_21(:,2)).';
weirs(21).z      =(weir_scotland_21(:,5)).';
weirs(21).par1    =(repmat(0.6,length(weir_scotland_21),1));

weirs(22).x      =(w_uk_1(:,1)).'; 
weirs(22).y      =(w_uk_1(:,2)).';
weirs(22).z      =(w_uk_1(:,5)).';
weirs(22).par1    =(repmat(0.6,length(w_uk_1),1));

weirs(23).x      =(w_uk_2(:,1)).'; 
weirs(23).y      =(w_uk_2(:,2)).';
weirs(23).z      =(w_uk_2(:,5)).';
weirs(23).par1    =(repmat(0.6,length(w_uk_2),1));

weirs(24).x      =(w_uk_3(:,1)).'; 
weirs(24).y      =(w_uk_3(:,2)).';
weirs(24).z      =(w_uk_3(:,5)).';
weirs(24).par1    =(repmat(0.6,length(w_uk_3),1));

weirs(25).x      =(w_uk_4(:,1)).'; 
weirs(25).y      =(w_uk_4(:,2)).';
weirs(25).z      =(w_uk_4(:,5)).';
weirs(25).par1    =(repmat(0.6,length(w_uk_4),1));

weirs(26).x      =(w_uk_5(:,1)).'; 
weirs(26).y      =(w_uk_5(:,2)).';
weirs(26).z      =(w_uk_5(:,5)).';
weirs(26).par1    =(repmat(0.6,length(w_uk_5),1));

weirs(27).x      =(w_uk_6(:,1)).'; 
weirs(27).y      =(w_uk_6(:,2)).';
weirs(27).z      =(w_uk_6(:,5)).';
weirs(27).par1    =(repmat(0.6,length(w_uk_6),1));

weirs(28).x      =(w_uk_7(:,1)).'; 
weirs(28).y      =(w_uk_7(:,2)).';
weirs(28).z      =(w_uk_7(:,5)).';
weirs(28).par1    =(repmat(0.6,length(w_uk_7),1));

weirs(29).x      =(w_uk_8(:,1)).'; 
weirs(29).y      =(w_uk_8(:,2)).';
weirs(29).z      =(w_uk_8(:,5)).';
weirs(29).par1    =(repmat(0.6,length(w_uk_8),1));

weirs(30).x      =(w_uk_9(:,1)).'; 
weirs(30).y      =(w_uk_9(:,2)).';
weirs(30).z      =(w_uk_9(:,5)).';
weirs(30).par1    =(repmat(0.6,length(w_uk_9),1));

weirs(31).x      =(w_uk_10(:,1)).'; 
weirs(31).y      =(w_uk_10(:,2)).';
weirs(31).z      =(w_uk_10(:,5)).';
weirs(31).par1    =(repmat(0.6,length(w_uk_10),1));

weirs(32).x      =(w_uk_11(:,1)).'; 
weirs(32).y      =(w_uk_11(:,2)).';
weirs(32).z      =(w_uk_11(:,5)).';
weirs(32).par1    =(repmat(0.6,length(w_uk_11),1));

weirs(33).x      =(w_uk_12(:,1)).'; 
weirs(33).y      =(w_uk_12(:,2)).';
weirs(33).z      =(w_uk_12(:,5)).';
weirs(33).par1    =(repmat(0.6,length(w_uk_12),1));

weirs(34).x      =(w_uk_13(:,1)).'; 
weirs(34).y      =(w_uk_13(:,2)).';
weirs(34).z      =(w_uk_13(:,5)).';
weirs(34).par1    =(repmat(0.6,length(w_uk_13),1));

weirs(35).x      =(w_uk_14(:,1)).'; 
weirs(35).y      =(w_uk_14(:,2)).';
weirs(35).z      =(w_uk_14(:,5)).';
weirs(35).par1    =(repmat(0.6,length(w_uk_14),1));

weirs(36).x      =(w_uk_15(:,1)).'; 
weirs(36).y      =(w_uk_15(:,2)).';
weirs(36).z      =(w_uk_15(:,5)).';
weirs(36).par1    =(repmat(0.6,length(w_uk_15),1));

weirs(37).x      =(w_uk_16(:,1)).'; 
weirs(37).y      =(w_uk_16(:,2)).';
weirs(37).z      =(w_uk_16(:,5)).';
weirs(37).par1    =(repmat(0.6,length(w_uk_16),1));

weirs(38).x      =(w_uk_17(:,1)).'; 
weirs(38).y      =(w_uk_17(:,2)).';
weirs(38).z      =(w_uk_17(:,5)).';
weirs(38).par1    =(repmat(0.6,length(w_uk_17),1));

weirs(39).x      =(w_uk_18(:,1)).'; 
weirs(39).y      =(w_uk_18(:,2)).';
weirs(39).z      =(w_uk_18(:,5)).';
weirs(39).par1    =(repmat(0.6,length(w_uk_18),1));

weirs(40).x      =(w_uk_19(:,1)).'; 
weirs(40).y      =(w_uk_19(:,2)).';
weirs(40).z      =(w_uk_19(:,5)).';
weirs(40).par1    =(repmat(0.6,length(w_uk_19),1));

weirs(41).x      =(w_uk_20(:,1)).'; 
weirs(41).y      =(w_uk_20(:,2)).';
weirs(41).z      =(w_uk_20(:,5)).';
weirs(41).par1    =(repmat(0.6,length(w_uk_20),1));

% Write the weir file 
inp.weirfile = 'sfincs.weir';
sfincs_write_obstacle_file_1par(inp.weirfile,weirs)