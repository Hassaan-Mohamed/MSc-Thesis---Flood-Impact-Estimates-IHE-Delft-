%% Incorporating the protection for the Continental Scale SFINCS model (Script 5a of 7)  
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
pd = table2array (readtable ('final_protection_UK.csv')); 
pr_level = pd (:,5);

% To visualize the protection points 
geoscatter(pd(:,4), pd(:,3));
for i = 1:length(pd)
    text(pd(i,4), pd(i,3),num2str(i), 'HorizontalAlignment','center');
end 
%geoscatter(thin_dam_data(:,3), thin_dam_data(:,4),thin_dam_data(:,5))
%geodensityplot(lat, lon, ESL_Values)
geolimits([0 75],[-30 60])
geobasemap topographic

%% MAKING THE WEIRS 

% Classify the weirs based on the analysis of the location from the geoplot
% United Kingdom 

w_uk_1 = [pd(471,:);pd(1330,:);pd(472,:);pd(1331,:);pd(1332:1334,:);pd(473:474,:);pd(476,:);pd(1335:1341,:);pd(477,:);pd(1342:1344,:);pd(478,:);pd(1345,:);...
    pd(479,:);pd(480,:);pd(1346:1347,:);pd(481:482,:);pd(1348,:);pd(484,:);pd(1349:1350,:);pd(1352,:);pd(1351,:);pd(486,:);pd(1353:1354,:);pd(487,:);pd(1355:1356,:);...
    pd(488,:);pd(1357:1359,:);pd(489:490,:);pd(1360:1361,:);pd(491,:);pd(1363:1369,:);pd(492,:);pd(1370:1376,:);pd(493,:);pd(1377,:);pd(494,:);pd(1378:1389,:);pd(496,:);...
    pd(1450:1452,:);pd(497,:);pd(1453:1456,:);pd(500,:)];
w_uk_2 = [pd(499,:);pd(1457:1463,:);pd(1473,:);pd(1472,:);pd(1471,:);pd(1470,:);pd(1469,:);pd(1468,:);pd(498,:)];
w_uk_3 = [pd(498,:);pd(1464:1467,:)]; 
w_uk_4 = [pd(500,:);pd(1390:1399,:);];
w_uk_5 = [pd(1400:1413,:)];
w_uk_6 = [pd(1400,:);pd(779:782,:);pd(505,:);pd(783:785,:);pd(506,:);pd(788:791,:);pd(507,:)];
w_uk_7 = [pd(794:799,:);pd(507,:)];
w_uk_8 = [pd(508,:);pd(800:804,:);pd(509,:);pd(811:827,:);pd(830,:);pd(828,:);pd(833:837,:);pd(840,:);pd(10,:);pd(841:843,:);pd(12:13,:);pd(844:847,:);pd(15:16,:);...
    pd(876,:);pd(17,:);pd(880:885,:);pd(18:21,:);pd(889,:);pd(888,:);pd(886,:);pd(890:894,:);pd(24,:);pd(896,:);pd(25,:);pd(899:902,:);pd(26:28,:);pd(913:918,:);...
    pd(910,:);pd(29,:);pd(922,:);pd(920,:);pd(919,:);pd(31,:);pd(923:925,:);pd(33,:);pd(929,:);pd(928,:);pd(926,:);pd(34,:);pd(931,:);pd(36:46,:);pd(938,:);pd(47:48,:)];
w_uk_9 = [pd(48:49,:);pd(944:945,:);pd(50:52,:);pd(946,:);pd(53:54,:);pd(947,:);pd(55,:);pd(949,:);pd(948,:);pd(56,:);pd(950:953,:);pd(57,:);pd(964:968,:);pd(957,:);pd(58,:)];
w_uk_10 = [pd(59,:);pd(969:973,:)];
w_uk_11 = [pd(59,:);pd(974:976,:)];
w_uk_12 = [pd(60,:);pd(979:984,:);pd(61,:);pd(985:993,:);pd(62,:);pd(63:65,:);pd(1000,:);pd(66,:);pd(999,:);pd(67,:);pd(1003:1005,:);pd(68:71,:)];
w_uk_13 = [pd(71,:);pd(1013,:);pd(72,:);pd(1014,:);pd(74,:)];
w_uk_14 = [pd(74,:);pd(1029,:);pd(1026,:);pd(1025,:);pd(1024,:);pd(1023,:);pd(1015:1022,:);pd(1028,:);pd(1030,:);pd(74,:)];
w_uk_15 = [pd(74:119,:)];
w_uk_16 = [pd(119,:);pd(1483:1486,:);pd(1479,:);pd(120,:);pd(1487,:);pd(121:127,:);pd(1488,:);pd(128:129,:);pd(1496,:);pd(1493,:);pd(130,:);pd(1489:1492,:);pd(1497,:);...
    pd(131:143,:);pd(1415,:);pd(144,:);pd(1416:1417,:);pd(145,:);pd(1418:1419,:);pd(146,:);pd(1421,:);pd(1421:1423,:);pd(147:148,:);pd(1424:1425,:);pd(149,:);pd(1052,:);...
    pd(150,:);pd(1426:1429,:);pd(151,:);pd(1053:1060,:);pd(153,:);pd(1061:1066,:);pd(154,:);pd(1070:1085,:);pd(1089,:);pd(157,:);pd(1091,:);pd(1094,:)];
w_uk_17 = [pd(648,:);pd(1036,:);pd(1044:1045,:);pd(649,:);pd(1046:1047,:);pd(650,:);pd(1048,:);pd(651,:);pd(1049,:);pd(652,:);pd(1050,:);pd(653:654,:);pd(1414,:);pd(655:656,:);pd(1031:1035,:);...
    pd(1043,:);pd(1042,:);pd(1041,:);pd(1040,:);pd(1038,:);pd(1037,:);pd(1036,:);pd(648,:)];
w_uk_18 = [pd(1094,:);pd(159:160,:);pd(1099,:);pd(161,:);pd(1102:1104,:);pd(162:163,:);pd(1105:1108,:);pd(164:165,:);pd(1109,:);pd(166,:);pd(1110:1112,:);pd(167:168,:);pd(1113:1114,:);...
    pd(169:171,:);pd(1116:1120,:);pd(173:175,:);pd(1121:1124,:);pd(176:177,:)];
w_uk_19 = [pd(420:429,:);pd(1318,:);pd(430,:);pd(1319,:);pd(431,:);pd(1320:1321,:);pd(432:456,:);pd(1501,:);pd(457:468,:);pd(1327:1329,:);pd(1326,:);pd(1325,:);pd(1324,:);pd(1323,:);pd(1322,:);pd(469:471,:)];
w_uk_20 = [pd(865:869,:);pd(703,:);pd(870,:);pd(873,:);pd(872,:);pd(858,:);pd(702,:);pd(854:856,:);pd(852,:);pd(850,:);pd(849,:);pd(848,:);pd(700,:);pd(699,:);pd(861:863,:);...
    pd(698,:);pd(704,:);pd(865,:)];


save('w_uk_1','w_uk_1');save('w_uk_2','w_uk_2');
save('w_uk_3','w_uk_3');save('w_uk_4','w_uk_4');
save('w_uk_5','w_uk_5');save('w_uk_6','w_uk_6');
save('w_uk_7','w_uk_7');save('w_uk_8','w_uk_8');
save('w_uk_9','w_uk_9');save('w_uk_10','w_uk_10');
save('w_uk_11','w_uk_11');save('w_uk_12','w_uk_12');
save('w_uk_13','w_uk_13');save('w_uk_14','w_uk_14');
save('w_uk_15','w_uk_15');save('w_uk_16','w_uk_16');
save('w_uk_17','w_uk_17');save('w_uk_18','w_uk_18');
save('w_uk_19','w_uk_19');save('w_uk_20','w_uk_20');






