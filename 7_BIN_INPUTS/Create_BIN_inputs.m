%% Creating the BIN input files for the SFINCS models   
% Creating sfincs.dep, sfincs.man, sfincs.msk & sfincs.ind files   
% Name: Hassaan Mohamed 
% Student Number: 1070154

clc;                        % Clear the command window 
close all;                  % Close all figures 
clear all;                  % Clear all existing variables

% First step is to make a directory of all the subfolders for the SFINCS models 
sfincs_dir = '';
sfincs_dir_info = dir(fullfile(sfincs_dir, 'S*'));
sfincs_dir_info = natsortfiles (sfincs_dir_info); 
sfincs_dir_info(~[sfincs_dir_info.isdir]) = [];                         % To get rid of any S* that are potentially not folders 
sfincs_subfolders = fullfile (sfincs_dir,{sfincs_dir_info.name});       % Path of all subfolders for the sfincs models 

for i = 1:length(sfincs_subfolders)
    current_folder = sfincs_subfolders{i};

    msk     = importdata(fullfile(current_folder, 'sfincs_ascii.msk'));
    Z       = importdata(fullfile(current_folder, 'sfincs_ascii.dep'));
    manning = readmatrix(fullfile(current_folder,'sfincs_ascii.man'), 'FileType', 'Text', 'NumHeaderLines', 0, 'Delimiter', '\t');  


    inp.depfile = fullfile(current_folder, 'sfincs.dep');
    inp.mskfile = fullfile(current_folder, 'sfincs.msk');
    inp.manningfile = fullfile(current_folder, 'sfincs.man');
    inp.indexfile = fullfile(current_folder, 'sfincs.ind');


    sfincs_write_binary_inputs(manning,msk,inp.indexfile,inp.manningfile,inp.mskfile);
    sfincs_write_binary_inputs(Z,msk,inp.indexfile,inp.depfile,inp.mskfile);
end 
