%% Incorporating the protection for the Continental Scale SFINCS model (Script 4 of 7)  
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

% To visualize the protection points 
geoscatter(protection_data(:,3), protection_data(:,4));
for i = 1:length(protection_data)
    text(protection_data(i,3), protection_data(i,4),num2str(i), 'HorizontalAlignment','center');
end 
%geoscatter(thin_dam_data(:,3), thin_dam_data(:,4),thin_dam_data(:,5))
%geodensityplot(lat, lon, ESL_Values)
geolimits([0 75],[-30 60])
geobasemap topographic

% Classify the weirs based on the analysis of the location from the geoplot
% AZORES
weir_azores_1 = [protection_data(5814:5821,:);protection_data(5814,:)];
weir_azores_2 = [protection_data(5990:5994,:);protection_data(5990,:)];
weir_azores_3 = [protection_data(6145:6150,:);protection_data(6145,:)];
weir_azores_4 = [protection_data(6452:6453,:);protection_data(6452,:)];
weir_azores_5 = [protection_data(5937:5942,:);protection_data(5937,:)];
weir_azores_6 = [protection_data(6226:6228,:);protection_data(6226,:)];
weir_azores_7 = [protection_data(6248:6250,:);protection_data(6248,:)];

weirs(1).x      =(weir_azores_1(:,1)).'; 
weirs(1).y      =(weir_azores_1(:,2)).';
weirs(1).z      =(weir_azores_1(:,5)).';
weirs(1).par1    =(repmat(0.6,length(weir_azores_1),1)); 

weirs(2).x      =(weir_azores_2(:,1)).'; 
weirs(2).y      =(weir_azores_2(:,2)).';
weirs(2).z      =(weir_azores_2(:,5)).';
weirs(2).par1    =(repmat(0.6,length(weir_azores_2),1)); 

weirs(3).x      =(weir_azores_3(:,1)).'; 
weirs(3).y      =(weir_azores_3(:,2)).';
weirs(3).z      =(weir_azores_3(:,5)).';
weirs(3).par1    =(repmat(0.6,length(weir_azores_3),1)); 

weirs(4).x      =(weir_azores_4(:,1)).'; 
weirs(4).y      =(weir_azores_4(:,2)).';
weirs(4).z      =(weir_azores_4(:,5)).';
weirs(4).par1    =(repmat(0.6,length(weir_azores_4),1)); 

weirs(5).x      =(weir_azores_5(:,1)).'; 
weirs(5).y      =(weir_azores_5(:,2)).';
weirs(5).z      =(weir_azores_5(:,5)).';
weirs(5).par1    =(repmat(0.6,length(weir_azores_5),1)); 

weirs(6).x      =(weir_azores_6(:,1)).'; 
weirs(6).y      =(weir_azores_6(:,2)).';
weirs(6).z      =(weir_azores_6(:,5)).';
weirs(6).par1    =(repmat(0.6,length(weir_azores_6),1)); 

weirs(7).x      =(weir_azores_7(:,1)).'; 
weirs(7).y      =(weir_azores_7(:,2)).';
weirs(7).z      =(weir_azores_7(:,5)).';
weirs(7).par1    =(repmat(0.6,length(weir_azores_7),1)); 


% NORTHERN IRELAND 
weir_n_ireland_1 = protection_data(5037:5066,:);

weirs(8).x      =(weir_n_ireland_1(:,1)).'; 
weirs(8).y      =(weir_n_ireland_1(:,2)).';
weirs(8).z      =(weir_n_ireland_1(:,5)).';
weirs(8).par1    =(repmat(0.6,length(weir_n_ireland_1),1)); 

%IRELAND 
weir_ireland_1 = protection_data(4823:5037,:);
weir_ireland_2 = protection_data(5066:5104,:);
weir_ireland_3 = [protection_data(6242:6246,:);protection_data(6242,:)]; 

weirs(9).x      =(weir_ireland_1(:,1)).'; 
weirs(9).y      =(weir_ireland_1(:,2)).';
weirs(9).z      =(weir_ireland_1(:,5)).';
weirs(9).par1    =(repmat(0.6,length(weir_ireland_1),1)); 

weirs(10).x      =(weir_ireland_2(:,1)).'; 
weirs(10).y      =(weir_ireland_2(:,2)).';
weirs(10).z      =(weir_ireland_2(:,5)).';
weirs(10).par1    =(repmat(0.6,length(weir_ireland_2),1)); 

weirs(11).x      =(weir_ireland_3(:,1)).'; 
weirs(11).y      =(weir_ireland_3(:,2)).';
weirs(11).z      =(weir_ireland_3(:,5)).';
weirs(11).par1    =(repmat(0.6,length(weir_ireland_3),1)); 

% RUSSIA 
weir_russia_1 = protection_data(4181:4269,:); % Borders Norway on the West 
weir_russia_2 = protection_data(2017:2062,:); % Borders Estonia and Finland 

weirs(12).x      =(weir_russia_1(:,1)).'; 
weirs(12).y      =(weir_russia_1(:,2)).';
weirs(12).z      =(weir_russia_1(:,5)).';
weirs(12).par1    =(repmat(0.6,length(weir_russia_1),1));

weirs(13).x      =(weir_russia_2(:,1)).'; 
weirs(13).y      =(weir_russia_2(:,2)).';
weirs(13).z      =(weir_russia_2(:,5)).';
weirs(13).par1    =(repmat(0.6,length(weir_russia_2),1));

% SWEDEN 
weir_sweden_1 = protection_data(2332:2826,:); % Border Norway on the south and Finland on the north in Gulf of Bothnia 
weir_sweden_2 = [protection_data(5621:5639,:);protection_data(5621,:)];
weir_sweden_3 = [protection_data(5436:5461,:);protection_data(5436,:)];
weir_sweden_4 = [protection_data(6471:6474,:);protection_data(6471,:)];
weir_sweden_5 = [protection_data(6471:6474,:);protection_data(6471,:)];
weir_sweden_6 = [protection_data(6493:6495,:);protection_data(6493,:)];
weir_sweden_7 = [protection_data(6429:6434,:);protection_data(6429,:)];

weirs(14).x      =(weir_sweden_1(:,1)).'; 
weirs(14).y      =(weir_sweden_1(:,2)).';
weirs(14).z      =(weir_sweden_1(:,5)).';
weirs(14).par1    =(repmat(0.6,length(weir_sweden_1),1));

weirs(15).x      =(weir_sweden_2(:,1)).'; 
weirs(15).y      =(weir_sweden_2(:,2)).';
weirs(15).z      =(weir_sweden_2(:,5)).';
weirs(15).par1    =(repmat(0.6,length(weir_sweden_2),1));

weirs(16).x      =(weir_sweden_3(:,1)).'; 
weirs(16).y      =(weir_sweden_3(:,2)).';
weirs(16).z      =(weir_sweden_3(:,5)).';
weirs(16).par1    =(repmat(0.6,length(weir_sweden_3),1));

weirs(17).x      =(weir_sweden_4(:,1)).'; 
weirs(17).y      =(weir_sweden_4(:,2)).';
weirs(17).z      =(weir_sweden_4(:,5)).';
weirs(17).par1    =(repmat(0.6,length(weir_sweden_4),1));

weirs(18).x      =(weir_sweden_5(:,1)).'; 
weirs(18).y      =(weir_sweden_5(:,2)).';
weirs(18).z      =(weir_sweden_5(:,5)).';
weirs(18).par1    =(repmat(0.6,length(weir_sweden_5),1));

weirs(19).x      =(weir_sweden_6(:,1)).'; 
weirs(19).y      =(weir_sweden_6(:,2)).';
weirs(19).z      =(weir_sweden_6(:,5)).';
weirs(19).par1    =(repmat(0.6,length(weir_sweden_6),1));

weirs(20).x      =(weir_sweden_7(:,1)).'; 
weirs(20).y      =(weir_sweden_7(:,2)).';
weirs(20).z      =(weir_sweden_7(:,5)).';
weirs(20).par1    =(repmat(0.6,length(weir_sweden_7),1));

% FINLAND 
weir_finland_1 = protection_data(2062:2332,:); % Borders Norway and Russia 

weirs(21).x      =(weir_finland_1(:,1)).'; 
weirs(21).y      =(weir_finland_1(:,2)).';
weirs(21).z      =(weir_finland_1(:,5)).';
weirs(21).par1    =(repmat(0.6,length(weir_finland_1),1));

% ESTONIA
weir_estonia_1 = protection_data(1962:2017,:); % Borders Russia and Latvia 
weir_estonia_2 = [protection_data(6332:6336,:);protection_data(6332,:)];
weir_estonia_3 = [protection_data(6186:6190,:);protection_data(6186,:)];
weir_estonia_4 = [protection_data(5655:5671,:);protection_data(5655,:)];
weir_estonia_5 = [protection_data(5489:5523,:);protection_data(5489,:)];

weirs(22).x      =(weir_estonia_1(:,1)).'; 
weirs(22).y      =(weir_estonia_1(:,2)).';
weirs(22).z      =(weir_estonia_1(:,5)).';
weirs(22).par1    =(repmat(0.6,length(weir_estonia_1),1));

weirs(23).x      =(weir_estonia_2(:,1)).'; 
weirs(23).y      =(weir_estonia_2(:,2)).';
weirs(23).z      =(weir_estonia_2(:,5)).';
weirs(23).par1    =(repmat(0.6,length(weir_estonia_2),1));

weirs(24).x      =(weir_estonia_3(:,1)).'; 
weirs(24).y      =(weir_estonia_3(:,2)).';
weirs(24).z      =(weir_estonia_3(:,5)).';
weirs(24).par1    =(repmat(0.6,length(weir_estonia_3),1));

weirs(25).x      =(weir_estonia_4(:,1)).'; 
weirs(25).y      =(weir_estonia_4(:,2)).';
weirs(25).z      =(weir_estonia_4(:,5)).';
weirs(25).par1    =(repmat(0.6,length(weir_estonia_4),1));

weirs(26).x      =(weir_estonia_5(:,1)).'; 
weirs(26).y      =(weir_estonia_5(:,2)).';
weirs(26).z      =(weir_estonia_5(:,5)).';
weirs(26).par1    =(repmat(0.6,length(weir_estonia_5),1));


% LATVIA 
weir_latvia_1 = protection_data(1936:1962,:); % Borders Estonia and Russia 

weirs(27).x      =(weir_latvia_1(:,1)).'; 
weirs(27).y      =(weir_latvia_1(:,2)).';
weirs(27).z      =(weir_latvia_1(:,5)).';
weirs(27).par1    =(repmat(0.6,length(weir_latvia_1),1));

% LITHUANIA + SMALL PART OF RUSSIA 
weir_lithuania_1 = protection_data(1903:1936,:); % Borders Latvia and Poland 

weirs(28).x      =(weir_lithuania_1(:,1)).'; 
weirs(28).y      =(weir_lithuania_1(:,2)).';
weirs(28).z      =(weir_lithuania_1(:,5)).';
weirs(28).par1    =(repmat(0.6,length(weir_lithuania_1),1));


% POLAND 
weir_poland_1 = protection_data(1856:1903,:); % Borders Lithuania and Germany 
weir_poland_2 = [protection_data(6133:6139,:);protection_data(6133,:)];

weirs(29).x      =(weir_poland_1(:,1)).'; 
weirs(29).y      =(weir_poland_1(:,2)).';
weirs(29).z      =(weir_poland_1(:,5)).';
weirs(29).par1    =(repmat(0.6,length(weir_poland_1),1));

weirs(30).x      =(weir_poland_2(:,1)).'; 
weirs(30).y      =(weir_poland_2(:,2)).';
weirs(30).z      =(weir_poland_2(:,5)).';
weirs(30).par1    =(repmat(0.6,length(weir_poland_2),1));

% GERMANY
weir_germany_1 = protection_data(1804:1856,:); % Borders Poland and Denmark 
weir_germany_2 = protection_data(1672:1728,:); % Borders Denmark and Netherlands 
weir_germany_3 = [protection_data(5953:5964,:);protection_data(5953,:)];
weir_germany_4 = [protection_data(5717:5741,:);protection_data(5717,:)];
weir_germany_5 = [protection_data(6208:6211,:);protection_data(6208,:)];
weir_germany_6 = [protection_data(6376:6378,:);protection_data(6376,:)];

weirs(31).x      =(weir_germany_1(:,1)).'; 
weirs(31).y      =(weir_germany_1(:,2)).';
weirs(31).z      =(weir_germany_1(:,5)).';
weirs(31).par1    =(repmat(0.6,length(weir_germany_1),1));

weirs(32).x      =(weir_germany_2(:,1)).'; 
weirs(32).y      =(weir_germany_2(:,2)).';
weirs(32).z      =(weir_germany_2(:,5)).';
weirs(32).par1    =(repmat(0.6,length(weir_germany_2),1));

weirs(33).x      =(weir_germany_3(:,1)).'; 
weirs(33).y      =(weir_germany_3(:,2)).';
weirs(33).z      =(weir_germany_3(:,5)).';
weirs(33).par1    =(repmat(0.6,length(weir_germany_3),1));

weirs(34).x      =(weir_germany_4(:,1)).'; 
weirs(34).y      =(weir_germany_4(:,2)).';
weirs(34).z      =(weir_germany_4(:,5)).';
weirs(34).par1    =(repmat(0.6,length(weir_germany_4),1));

weirs(35).x      =(weir_germany_5(:,1)).'; 
weirs(35).y      =(weir_germany_5(:,2)).';
weirs(35).z      =(weir_germany_5(:,5)).';
weirs(35).par1    =(repmat(0.6,length(weir_germany_5),1));

weirs(36).x      =(weir_germany_6(:,1)).'; 
weirs(36).y      =(weir_germany_6(:,2)).';
weirs(36).z      =(weir_germany_6(:,5)).';
weirs(36).par1    =(repmat(0.6,length(weir_germany_6),1));

% DENMARK 
weir_denmark_1 = [protection_data(5869:5874,:);protection_data(5869,:)];
weir_denmark_2 = [protection_data(5323:5385,:);protection_data(5323,:)];
weir_denmark_3 = [protection_data(5640:5654,:);protection_data(5654,:)];
weir_denmark_4 = [protection_data(6169:6175,:);protection_data(6169,:)];
weir_denmark_5 = protection_data(1728:1804,:); % Borders Germany on both sides 
weir_denmark_6 = [protection_data(6035:6043,:);protection_data(6035,:)];
weir_denmark_7 = [protection_data(5462:5488,:);protection_data(5462,:)];
weir_denmark_8 = [protection_data(6109:6113,:);protection_data(6414,:);protection_data(6415,:);protection_data(5476,:);protection_data(6413,:);protection_data(6114:6115,:);protection_data(6109,:)];
weir_denmark_9 = [protection_data(6287:6290,:);protection_data(6287,:)];
weir_denmark_10 = [protection_data(6287:6290,:);protection_data(6287,:)];
weir_denmark_11 = [protection_data(4271,:);protection_data(4273:4273,:)];
weir_denmark_12 = [protection_data(4270,:);protection_data(4272,:);protection_data(4275:4286,:)];
weir_denmark_13 = protection_data(4287:4301,:);
weir_denmark_14 = protection_data(4302:4303,:);

weirs(37).x      =(weir_denmark_1(:,1)).'; 
weirs(37).y      =(weir_denmark_1(:,2)).';
weirs(37).z      =(weir_denmark_1(:,5)).';
weirs(37).par1    =(repmat(0.6,length(weir_denmark_1),1));

weirs(38).x      =(weir_denmark_2(:,1)).'; 
weirs(38).y      =(weir_denmark_2(:,2)).';
weirs(38).z      =(weir_denmark_2(:,5)).';
weirs(38).par1    =(repmat(0.6,length(weir_denmark_2),1));

weirs(39).x      =(weir_denmark_3(:,1)).'; 
weirs(39).y      =(weir_denmark_3(:,2)).';
weirs(39).z      =(weir_denmark_3(:,5)).';
weirs(39).par1    =(repmat(0.6,length(weir_denmark_3),1));

weirs(40).x      =(weir_denmark_4(:,1)).'; 
weirs(40).y      =(weir_denmark_4(:,2)).';
weirs(40).z      =(weir_denmark_4(:,5)).';
weirs(40).par1    =(repmat(0.6,length(weir_denmark_4),1));

weirs(41).x      =(weir_denmark_5(:,1)).'; 
weirs(41).y      =(weir_denmark_5(:,2)).';
weirs(41).z      =(weir_denmark_5(:,5)).';
weirs(41).par1    =(repmat(0.6,length(weir_denmark_5),1));

weirs(42).x      =(weir_denmark_6(:,1)).'; 
weirs(42).y      =(weir_denmark_6(:,2)).';
weirs(42).z      =(weir_denmark_6(:,5)).';
weirs(42).par1    =(repmat(0.6,length(weir_denmark_6),1));

weirs(43).x      =(weir_denmark_7(:,1)).'; 
weirs(43).y      =(weir_denmark_7(:,2)).';
weirs(43).z      =(weir_denmark_7(:,5)).';
weirs(43).par1    =(repmat(0.6,length(weir_denmark_7),1));

weirs(44).x      =(weir_denmark_8(:,1)).'; 
weirs(44).y      =(weir_denmark_8(:,2)).';
weirs(44).z      =(weir_denmark_8(:,5)).';
weirs(44).par1    =(repmat(0.6,length(weir_denmark_8),1));

weirs(45).x      =(weir_denmark_9(:,1)).'; 
weirs(45).y      =(weir_denmark_9(:,2)).';
weirs(45).z      =(weir_denmark_9(:,5)).';
weirs(45).par1    =(repmat(0.6,length(weir_denmark_9),1));

weirs(46).x      =(weir_denmark_10(:,1)).'; 
weirs(46).y      =(weir_denmark_10(:,2)).';
weirs(46).z      =(weir_denmark_10(:,5)).';
weirs(46).par1    =(repmat(0.6,length(weir_denmark_10),1));

weirs(47).x      =(weir_denmark_11(:,1)).'; 
weirs(47).y      =(weir_denmark_11(:,2)).';
weirs(47).z      =(weir_denmark_11(:,5)).';
weirs(47).par1    =(repmat(0.6,length(weir_denmark_11),1));

weirs(48).x      =(weir_denmark_12(:,1)).'; 
weirs(48).y      =(weir_denmark_12(:,2)).';
weirs(48).z      =(weir_denmark_12(:,5)).';
weirs(48).par1    =(repmat(0.6,length(weir_denmark_12),1));

weirs(49).x      =(weir_denmark_13(:,1)).'; 
weirs(49).y      =(weir_denmark_13(:,2)).';
weirs(49).z      =(weir_denmark_13(:,5)).';
weirs(49).par1    =(repmat(0.6,length(weir_denmark_13),1));

weirs(50).x      =(weir_denmark_14(:,1)).'; 
weirs(50).y      =(weir_denmark_14(:,2)).';
weirs(50).z      =(weir_denmark_14(:,5)).';
weirs(50).par1    =(repmat(0.6,length(weir_denmark_14),1));


% ALAND ISLAND 
weir_aland_1 = [protection_data(5761:5793,:);protection_data(5761,:)];

weirs(51).x      =(weir_aland_1(:,1)).'; 
weirs(51).y      =(weir_aland_1(:,2)).';
weirs(51).z      =(weir_aland_1(:,5)).';
weirs(51).par1    =(repmat(0.6,length(weir_aland_1),1));

% NETHERLANDS 
% The thin dam input takes care of the protection for the Netherlands 

% BELGIUM 
weir_belgium_1 = protection_data(1603:1608,:); % Borders Netherlands and France 

weirs(52).x      =(weir_belgium_1(:,1)).'; 
weirs(52).y      =(weir_belgium_1(:,2)).';
weirs(52).z      =(weir_belgium_1(:,5)).';
weirs(52).par1    =(repmat(0.6,length(weir_belgium_1),1));

% FRANCE
weir_france_1 = protection_data(1418:1604,:); % Borders Belgium and Spain 
weir_france_2 = [protection_data(6271:6274,:);protection_data(6271,:)];
weir_france_3 = [protection_data(6435:6437,:);protection_data(6435,:)];
weir_france_4 = [protection_data(6370:6373,:);protection_data(6370,:)];
weir_france_5 = [protection_data(6508:6510,:);protection_data(6508,:)];
weir_france_6 = [protection_data(6360:6363,:);protection_data(6360,:)];
weir_france_7 = [protection_data(6222:6225,:);protection_data(6222,:)];
weir_france_8 = protection_data (1130:1177,:); % Borders Spain and Italy
weir_france_9 = [protection_data(5244:5280,:);protection_data(5244,:)];

weirs(53).x      =(weir_france_1(:,1)).'; 
weirs(53).y      =(weir_france_1(:,2)).';
weirs(53).z      =(weir_france_1(:,5)).';
weirs(53).par1    =(repmat(0.6,length(weir_france_1),1));

weirs(54).x      =(weir_france_2(:,1)).'; 
weirs(54).y      =(weir_france_2(:,2)).';
weirs(54).z      =(weir_france_2(:,5)).';
weirs(54).par1    =(repmat(0.6,length(weir_france_2),1));

weirs(55).x      =(weir_france_3(:,1)).'; 
weirs(55).y      =(weir_france_3(:,2)).';
weirs(55).z      =(weir_france_3(:,5)).';
weirs(55).par1    =(repmat(0.6,length(weir_france_3),1));

weirs(56).x      =(weir_france_4(:,1)).'; 
weirs(56).y      =(weir_france_4(:,2)).';
weirs(56).z      =(weir_france_4(:,5)).';
weirs(56).par1    =(repmat(0.6,length(weir_france_4),1));

weirs(57).x      =(weir_france_5(:,1)).'; 
weirs(57).y      =(weir_france_5(:,2)).';
weirs(57).z      =(weir_france_5(:,5)).';
weirs(57).par1    =(repmat(0.6,length(weir_france_5),1));

weirs(58).x      =(weir_france_6(:,1)).'; 
weirs(58).y      =(weir_france_6(:,2)).';
weirs(58).z      =(weir_france_6(:,5)).';
weirs(58).par1    =(repmat(0.6,length(weir_france_6),1));

weirs(59).x      =(weir_france_7(:,1)).'; 
weirs(59).y      =(weir_france_7(:,2)).';
weirs(59).z      =(weir_france_7(:,5)).';
weirs(59).par1    =(repmat(0.6,length(weir_france_7),1));

weirs(60).x      =(weir_france_8(:,1)).'; 
weirs(60).y      =(weir_france_8(:,2)).';
weirs(60).z      =(weir_france_8(:,5)).';
weirs(60).par1    =(repmat(0.6,length(weir_france_8),1));

weirs(61).x      =(weir_france_9(:,1)).'; 
weirs(61).y      =(weir_france_9(:,2)).';
weirs(61).z      =(weir_france_9(:,5)).';
weirs(61).par1    =(repmat(0.6,length(weir_france_9),1));

% SPAIN
weir_spain_1 = protection_data(1332:1418,:); % Borders France and Portgual 
weir_spain_2 = protection_data(1177:1273,:); % Borders Portugal and France 
weir_spain_3 = [protection_data(6382:6385,:);protection_data(6382,:)];
weir_spain_4 = [protection_data(5900:5907,:);protection_data(5900,:)];
weir_spain_5 = [protection_data(5829:5838,:);protection_data(5829,:)];

weirs(62).x      =(weir_spain_1(:,1)).'; 
weirs(62).y      =(weir_spain_1(:,2)).';
weirs(62).z      =(weir_spain_1(:,5)).';
weirs(62).par1    =(repmat(0.6,length(weir_spain_1),1));

weirs(63).x      =(weir_spain_2(:,1)).'; 
weirs(63).y      =(weir_spain_2(:,2)).';
weirs(63).z      =(weir_spain_2(:,5)).';
weirs(63).par1    =(repmat(0.6,length(weir_spain_2),1));

weirs(64).x      =(weir_spain_3(:,1)).'; 
weirs(64).y      =(weir_spain_3(:,2)).';
weirs(64).z      =(weir_spain_3(:,5)).';
weirs(64).par1    =(repmat(0.6,length(weir_spain_3),1));

weirs(65).x      =(weir_spain_4(:,1)).'; 
weirs(65).y      =(weir_spain_4(:,2)).';
weirs(65).z      =(weir_spain_4(:,5)).';
weirs(65).par1    =(repmat(0.6,length(weir_spain_4),1));

weirs(66).x      =(weir_spain_5(:,1)).'; 
weirs(66).y      =(weir_spain_5(:,2)).';
weirs(66).z      =(weir_spain_5(:,5)).';
weirs(66).par1    =(repmat(0.6,length(weir_spain_5),1));

% PORTUGAL 
weir_portugal_1 = protection_data(1273:1332,:); % Borders Spain 

weirs(67).x      =(weir_portugal_1(:,1)).'; 
weirs(67).y      =(weir_portugal_1(:,2)).';
weirs(67).z      =(weir_portugal_1(:,5)).';
weirs(67).par1    =(repmat(0.6,length(weir_portugal_1),1));


% ITALY
weir_italy_1 = protection_data(944:1131,:);
weir_italy_2 = [protection_data(6163:6168,:);protection_data(6163,:)];
weir_italy_3 = [protection_data(6163:6168,:);protection_data(6163,:)];
weir_italy_4 = [protection_data(6500:6502,:);protection_data(6500,:)];
weir_italy_5 = protection_data(6503:6504,:);
weir_italy_6 = [protection_data(5155:5211,:);protection_data(5155,:)];
weir_italy_7 = [protection_data(5105:5152,:);protection_data(5105,:)];

weirs(68).x      =(weir_italy_1(:,1)).'; 
weirs(68).y      =(weir_italy_1(:,2)).';
weirs(68).z      =(weir_italy_1(:,5)).';
weirs(68).par1    =(repmat(0.6,length(weir_italy_1),1));

weirs(69).x      =(weir_italy_2(:,1)).'; 
weirs(69).y      =(weir_italy_2(:,2)).';
weirs(69).z      =(weir_italy_2(:,5)).';
weirs(69).par1    =(repmat(0.6,length(weir_italy_2),1));

weirs(70).x      =(weir_italy_3(:,1)).'; 
weirs(70).y      =(weir_italy_3(:,2)).';
weirs(70).z      =(weir_italy_3(:,5)).';
weirs(70).par1    =(repmat(0.6,length(weir_italy_3),1));

weirs(71).x      =(weir_italy_4(:,1)).'; 
weirs(71).y      =(weir_italy_4(:,2)).';
weirs(71).z      =(weir_italy_4(:,5)).';
weirs(71).par1    =(repmat(0.6,length(weir_italy_4),1));

weirs(72).x      =(weir_italy_5(:,1)).'; 
weirs(72).y      =(weir_italy_5(:,2)).';
weirs(72).z      =(weir_italy_5(:,5)).';
weirs(72).par1    =(repmat(0.6,length(weir_italy_5),1));

weirs(73).x      =(weir_italy_6(:,1)).'; 
weirs(73).y      =(weir_italy_6(:,2)).';
weirs(73).z      =(weir_italy_6(:,5)).';
weirs(73).par1    =(repmat(0.6,length(weir_italy_6),1));

weirs(74).x      =(weir_italy_7(:,1)).'; 
weirs(74).y      =(weir_italy_7(:,2)).';
weirs(74).z      =(weir_italy_7(:,5)).';
weirs(74).par1    =(repmat(0.6,length(weir_italy_7),1));


% MALTA 
weir_malta_1 = [protection_data(6151:6156,:);protection_data(6151,:)];
% Smaller island on malta has only 2 protection points. The protection levels are low anyhow 
% Cannot setup the weir structures there 

weirs(75).x      =(weir_malta_1(:,1)).'; 
weirs(75).y      =(weir_malta_1(:,2)).';
weirs(75).z      =(weir_malta_1(:,5)).';
weirs(75).par1    =(repmat(0.6,length(weir_malta_1),1));

% SLOVENIA
weir_slovenia_1 = protection_data(941:944,:);

weirs(76).x      =(weir_slovenia_1(:,1)).'; 
weirs(76).y      =(weir_slovenia_1(:,2)).';
weirs(76).z      =(weir_slovenia_1(:,5)).';
weirs(76).par1    =(repmat(0.6,length(weir_slovenia_1),1));

% CROATIA
weir_croatia_1 = protection_data(868:941,:); % Borders Slovenia and Montenegro 
weir_croatia_2 = [protection_data(5972:5979,:);protection_data(5972,:)];
weir_croatia_3 = [protection_data(5980:5989,:);protection_data(5980,:)];
weir_croatia_4 = [protection_data(6395:6399,:);protection_data(6395,:)];
weir_croatia_5 = [protection_data(6351:6355,:);protection_data(6351,:)];
weir_croatia_6 = [protection_data(6096:6108,:);protection_data(6096,:)];
weir_croatia_7 = [protection_data(6263:6270,:);protection_data(6263,:)];
weir_croatia_8 = [protection_data(6496:6499,:);protection_data(6496,:)];
weir_croatia_9 = [protection_data(6444:6446,:);protection_data(6444,:)];
weir_croatia_10 = [protection_data(6464:6466,:);protection_data(6466,:)];
weir_croatia_11 = [protection_data(5995:6001,:);protection_data(5995,:)];
weir_croatia_12 = [protection_data(6337:6340,:);protection_data(6337,:)];
weir_croatia_13 = [protection_data(6073:6083,:);protection_data(6073,:)];
weir_croatia_14 = [protection_data(6125:6132,:);protection_data(6125,:)];
weir_croatia_15 = [protection_data(6305:6310,:);protection_data(6305,:)];

weirs(77).x      =(weir_croatia_1(:,1)).'; 
weirs(77).y      =(weir_croatia_1(:,2)).';
weirs(77).z      =(weir_croatia_1(:,5)).';
weirs(77).par1    =(repmat(0.6,length(weir_croatia_1),1));

weirs(78).x      =(weir_croatia_2(:,1)).'; 
weirs(78).y      =(weir_croatia_2(:,2)).';
weirs(78).z      =(weir_croatia_2(:,5)).';
weirs(78).par1    =(repmat(0.6,length(weir_croatia_2),1));

weirs(79).x      =(weir_croatia_3(:,1)).'; 
weirs(79).y      =(weir_croatia_3(:,2)).';
weirs(79).z      =(weir_croatia_3(:,5)).';
weirs(79).par1    =(repmat(0.6,length(weir_croatia_3),1));

weirs(80).x      =(weir_croatia_4(:,1)).'; 
weirs(80).y      =(weir_croatia_4(:,2)).';
weirs(80).z      =(weir_croatia_4(:,5)).';
weirs(80).par1    =(repmat(0.6,length(weir_croatia_4),1));

weirs(81).x      =(weir_croatia_5(:,1)).'; 
weirs(81).y      =(weir_croatia_5(:,2)).';
weirs(81).z      =(weir_croatia_5(:,5)).';
weirs(81).par1    =(repmat(0.6,length(weir_croatia_5),1));

weirs(82).x      =(weir_croatia_6(:,1)).'; 
weirs(82).y      =(weir_croatia_6(:,2)).';
weirs(82).z      =(weir_croatia_6(:,5)).';
weirs(82).par1    =(repmat(0.6,length(weir_croatia_6),1));

weirs(83).x      =(weir_croatia_7(:,1)).'; 
weirs(83).y      =(weir_croatia_7(:,2)).';
weirs(83).z      =(weir_croatia_7(:,5)).';
weirs(83).par1    =(repmat(0.6,length(weir_croatia_7),1));

weirs(84).x      =(weir_croatia_8(:,1)).'; 
weirs(84).y      =(weir_croatia_8(:,2)).';
weirs(84).z      =(weir_croatia_8(:,5)).';
weirs(84).par1    =(repmat(0.6,length(weir_croatia_8),1));

weirs(85).x      =(weir_croatia_9(:,1)).'; 
weirs(85).y      =(weir_croatia_9(:,2)).';
weirs(85).z      =(weir_croatia_9(:,5)).';
weirs(85).par1    =(repmat(0.6,length(weir_croatia_9),1));

weirs(86).x      =(weir_croatia_10(:,1)).'; 
weirs(86).y      =(weir_croatia_10(:,2)).';
weirs(86).z      =(weir_croatia_10(:,5)).';
weirs(86).par1    =(repmat(0.6,length(weir_croatia_10),1));

weirs(87).x      =(weir_croatia_11(:,1)).'; 
weirs(87).y      =(weir_croatia_11(:,2)).';
weirs(87).z      =(weir_croatia_11(:,5)).';
weirs(87).par1    =(repmat(0.6,length(weir_croatia_11),1));

weirs(88).x      =(weir_croatia_12(:,1)).'; 
weirs(88).y      =(weir_croatia_12(:,2)).';
weirs(88).z      =(weir_croatia_12(:,5)).';
weirs(88).par1    =(repmat(0.6,length(weir_croatia_12),1));

weirs(89).x      =(weir_croatia_13(:,1)).'; 
weirs(89).y      =(weir_croatia_13(:,2)).';
weirs(89).z      =(weir_croatia_13(:,5)).';
weirs(89).par1    =(repmat(0.6,length(weir_croatia_13),1));

weirs(91).x      =(weir_croatia_14(:,1)).'; 
weirs(91).y      =(weir_croatia_14(:,2)).';
weirs(91).z      =(weir_croatia_14(:,5)).';
weirs(91).par1    =(repmat(0.6,length(weir_croatia_14),1));

weirs(92).x      =(weir_croatia_15(:,1)).'; 
weirs(92).y      =(weir_croatia_15(:,2)).';
weirs(92).z      =(weir_croatia_15(:,5)).';
weirs(92).par1    =(repmat(0.6,length(weir_croatia_15),1));

% MONTENEGRO 
weir_montenegro_1 = protection_data(856:868,:);

weirs(93).x      =(weir_montenegro_1(:,1)).'; 
weirs(93).y      =(weir_montenegro_1(:,2)).';
weirs(93).z      =(weir_montenegro_1(:,5)).';
weirs(93).par1    =(repmat(0.6,length(weir_montenegro_1),1));

% ALBANIA 
weir_albania_1 = protection_data(831:856,:);

weirs(94).x      =(weir_albania_1(:,1)).'; 
weirs(94).y      =(weir_albania_1(:,2)).';
weirs(94).z      =(weir_albania_1(:,5)).';
weirs(94).par1    =(repmat(0.6,length(weir_albania_1),1));

% GREECE 
weir_greece_1 = protection_data(638:831,:); % Borders Albania and Turkiye 
weir_greece_2 = [protection_data(6084:6089,:);protection_data(6084,:)];
weir_greece_3 = [protection_data(5859:5868,:);protection_data(5859,:)];
weir_greece_4 = [protection_data(6316:6320,:);protection_data(6316,:)];
weir_greece_5 = [protection_data(5803:5813,:);protection_data(5803,:)];
weir_greece_6 = [protection_data(5965:5971,:);protection_data(5965,:)];
weir_greece_7 = [protection_data(6505:6507,:);protection_data(6505,:)];
weir_greece_8 = [protection_data(6120:6124,:);protection_data(6120,:)];
weir_greece_9 = [protection_data(6322:6324,:);protection_data(6322,:)];
weir_greece_10 = [protection_data(6322:6324,:);protection_data(6322,:)];
weir_greece_11 = [protection_data(5281:5321,:);protection_data(5281,:)];
weir_greece_12 = [protection_data(5386:5414,:);protection_data(5386,:)];
weir_greece_13 = [protection_data(6007:6013,:);protection_data(6007,:)];
weir_greece_14 = [protection_data(6167:6180,:);protection_data(6167,:)];
weir_greece_15 = [protection_data(6426:6331,:);protection_data(6329,:)];
weir_greece_16 = [protection_data(6029:6033,:);protection_data(6029,:)];
weir_greece_17 = [protection_data(5920:5929,:);protection_data(5920,:)];
weir_greece_18 = [protection_data(6002:6005,:);protection_data(6002,:)];
% Some tiny greek islands were ignored. There protection levels were low to begin with 
% Also the the amount of protection points for a small island was not sufficient to setup the weir structures via SFINCS model 

weirs(95).x      =(weir_greece_1(:,1)).'; 
weirs(95).y      =(weir_greece_1(:,2)).';
weirs(95).z      =(weir_greece_1(:,5)).';
weirs(95).par1    =(repmat(0.6,length(weir_greece_1),1));

weirs(96).x      =(weir_greece_2(:,1)).'; 
weirs(96).y      =(weir_greece_2(:,2)).';
weirs(96).z      =(weir_greece_2(:,5)).';
weirs(96).par1    =(repmat(0.6,length(weir_greece_2),1));

weirs(97).x      =(weir_greece_3(:,1)).'; 
weirs(97).y      =(weir_greece_3(:,2)).';
weirs(97).z      =(weir_greece_3(:,5)).';
weirs(97).par1    =(repmat(0.6,length(weir_greece_3),1));

weirs(98).x      =(weir_greece_4(:,1)).'; 
weirs(98).y      =(weir_greece_4(:,2)).';
weirs(98).z      =(weir_greece_4(:,5)).';
weirs(98).par1    =(repmat(0.6,length(weir_greece_4),1));

weirs(99).x      =(weir_greece_5(:,1)).'; 
weirs(99).y      =(weir_greece_5(:,2)).';
weirs(99).z      =(weir_greece_5(:,5)).';
weirs(99).par1    =(repmat(0.6,length(weir_greece_5),1));

weirs(100).x      =(weir_greece_6(:,1)).'; 
weirs(100).y      =(weir_greece_6(:,2)).';
weirs(100).z      =(weir_greece_6(:,5)).';
weirs(100).par1    =(repmat(0.6,length(weir_greece_6),1));

weirs(101).x      =(weir_greece_7(:,1)).'; 
weirs(101).y      =(weir_greece_7(:,2)).';
weirs(101).z      =(weir_greece_7(:,5)).';
weirs(101).par1    =(repmat(0.6,length(weir_greece_7),1));

weirs(102).x      =(weir_greece_8(:,1)).'; 
weirs(102).y      =(weir_greece_8(:,2)).';
weirs(102).z      =(weir_greece_8(:,5)).';
weirs(102).par1    =(repmat(0.6,length(weir_greece_8),1));

weirs(103).x      =(weir_greece_9(:,1)).'; 
weirs(103).y      =(weir_greece_9(:,2)).';
weirs(103).z      =(weir_greece_9(:,5)).';
weirs(103).par1    =(repmat(0.6,length(weir_greece_9),1));

weirs(104).x      =(weir_greece_10(:,1)).'; 
weirs(104).y      =(weir_greece_10(:,2)).';
weirs(104).z      =(weir_greece_10(:,5)).';
weirs(104).par1    =(repmat(0.6,length(weir_greece_10),1));

weirs(105).x      =(weir_greece_11(:,1)).'; 
weirs(105).y      =(weir_greece_11(:,2)).';
weirs(105).z      =(weir_greece_11(:,5)).';
weirs(105).par1    =(repmat(0.6,length(weir_greece_11),1));

weirs(106).x      =(weir_greece_12(:,1)).'; 
weirs(106).y      =(weir_greece_12(:,2)).';
weirs(106).z      =(weir_greece_12(:,5)).';
weirs(106).par1    =(repmat(0.6,length(weir_greece_12),1));

weirs(107).x      =(weir_greece_13(:,1)).'; 
weirs(107).y      =(weir_greece_13(:,2)).';
weirs(107).z      =(weir_greece_13(:,5)).';
weirs(107).par1    =(repmat(0.6,length(weir_greece_13),1));

weirs(108).x      =(weir_greece_14(:,1)).'; 
weirs(108).y      =(weir_greece_14(:,2)).';
weirs(108).z      =(weir_greece_14(:,5)).';
weirs(108).par1    =(repmat(0.6,length(weir_greece_14),1));

weirs(109).x      =(weir_greece_15(:,1)).'; 
weirs(109).y      =(weir_greece_15(:,2)).';
weirs(109).z      =(weir_greece_15(:,5)).';
weirs(109).par1    =(repmat(0.6,length(weir_greece_15),1));

weirs(110).x      =(weir_greece_16(:,1)).'; 
weirs(110).y      =(weir_greece_16(:,2)).';
weirs(110).z      =(weir_greece_16(:,5)).';
weirs(110).par1    =(repmat(0.6,length(weir_greece_16),1));

weirs(111).x      =(weir_greece_17(:,1)).'; 
weirs(111).y      =(weir_greece_17(:,2)).';
weirs(111).z      =(weir_greece_17(:,5)).';
weirs(111).par1    =(repmat(0.6,length(weir_greece_17),1));

weirs(112).x      =(weir_greece_18(:,1)).'; 
weirs(112).y      =(weir_greece_18(:,2)).';
weirs(112).z      =(weir_greece_18(:,5)).';
weirs(112).par1    =(repmat(0.6,length(weir_greece_18),1));

% TURKIYE  
weir_turkiye_1 = protection_data(610:638,:); % Borders Greece
weir_turkiye_2 = [protection_data(5596:5610,:);protection_data(5596,:)]; % NORTH AEGEAN
weir_turkiye_3 = [protection_data(5611:5620,:);protection_data(5611,:)]; % SOUTH AEGEN 
weir_turkiye_4 = [protection_data(5794:5802,:);protection_data(5794,:)];
weir_turkiye_5 = [protection_data(6140:6144,:);protection_data(6140,:)];
weir_turkiye_6 = [protection_data(5930:5936,:);protection_data(5930,:)];
weir_turkiye_7 = [protection_data(5596:5610,:);protection_data(5596,:)];
weir_turkiye_8 = [protection_data(5611:5620,:);protection_data(5611,:)];
weir_turkiye_9 = [protection_data(6066:6072,:);protection_data(6066,:)];
weir_turkiye_10 = [protection_data(5596:5610,:);protection_data(5596,:)];
weir_turkiye_11 = protection_data(26:223,:); % Borders Syria

weirs(113).x      =(weir_turkiye_1(:,1)).'; 
weirs(113).y      =(weir_turkiye_1(:,2)).';
weirs(113).z      =(weir_turkiye_1(:,5)).';
weirs(113).par1    =(repmat(0.6,length(weir_turkiye_1),1));

weirs(114).x      =(weir_turkiye_2(:,1)).'; 
weirs(114).y      =(weir_turkiye_2(:,2)).';
weirs(114).z      =(weir_turkiye_2(:,5)).';
weirs(114).par1    =(repmat(0.6,length(weir_turkiye_2),1));

weirs(115).x      =(weir_turkiye_3(:,1)).'; 
weirs(115).y      =(weir_turkiye_3(:,2)).';
weirs(115).z      =(weir_turkiye_3(:,5)).';
weirs(115).par1    =(repmat(0.6,length(weir_turkiye_3),1));

weirs(116).x      =(weir_turkiye_4(:,1)).'; 
weirs(116).y      =(weir_turkiye_4(:,2)).';
weirs(116).z      =(weir_turkiye_4(:,5)).';
weirs(116).par1    =(repmat(0.6,length(weir_turkiye_4),1));

weirs(117).x      =(weir_turkiye_5(:,1)).'; 
weirs(117).y      =(weir_turkiye_5(:,2)).';
weirs(117).z      =(weir_turkiye_5(:,5)).';
weirs(117).par1    =(repmat(0.6,length(weir_turkiye_5),1));

weirs(118).x      =(weir_turkiye_6(:,1)).'; 
weirs(118).y      =(weir_turkiye_6(:,2)).';
weirs(118).z      =(weir_turkiye_6(:,5)).';
weirs(118).par1    =(repmat(0.6,length(weir_turkiye_6),1));

weirs(119).x      =(weir_turkiye_7(:,1)).'; 
weirs(119).y      =(weir_turkiye_7(:,2)).';
weirs(119).z      =(weir_turkiye_7(:,5)).';
weirs(119).par1    =(repmat(0.6,length(weir_turkiye_7),1));

weirs(120).x      =(weir_turkiye_8(:,1)).'; 
weirs(120).y      =(weir_turkiye_8(:,2)).';
weirs(120).z      =(weir_turkiye_8(:,5)).';
weirs(120).par1    =(repmat(0.6,length(weir_turkiye_8),1));

weirs(121).x      =(weir_turkiye_9(:,1)).'; 
weirs(121).y      =(weir_turkiye_9(:,2)).';
weirs(121).z      =(weir_turkiye_9(:,5)).';
weirs(121).par1    =(repmat(0.6,length(weir_turkiye_9),1));

weirs(122).x      =(weir_turkiye_10(:,1)).'; 
weirs(122).y      =(weir_turkiye_10(:,2)).';
weirs(122).z      =(weir_turkiye_10(:,5)).';
weirs(122).par1    =(repmat(0.6,length(weir_turkiye_10),1));

weirs(123).x      =(weir_turkiye_11(:,1)).'; 
weirs(123).y      =(weir_turkiye_11(:,2)).';
weirs(123).z      =(weir_turkiye_11(:,5)).';
weirs(123).par1    =(repmat(0.6,length(weir_turkiye_11),1));

% BLACK SEA 
weir_blsea_1 = protection_data(223:610,:);

weirs(124).x      =(weir_blsea_1(:,1)).'; 
weirs(124).y      =(weir_blsea_1(:,2)).';
weirs(124).z      =(weir_blsea_1(:,5)).';
weirs(124).par1    =(repmat(0.6,length(weir_blsea_1),1));

% CYPRUS
weir_cyprus_1 = [protection_data(5213:5243,:);protection_data(5213,:)];

weirs(125).x      =(weir_cyprus_1(:,1)).'; 
weirs(125).y      =(weir_cyprus_1(:,2)).';
weirs(125).z      =(weir_cyprus_1(:,5)).';
weirs(125).par1    =(repmat(0.6,length(weir_cyprus_1),1));

% Write the weir file 
inp.weirfile = 'sfincs.weir';
sfincs_write_obstacle_file_1par(inp.weirfile,weirs)