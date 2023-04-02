%% Generating the grids and main input files for the SFINCS models (Script 4 of 5)
% Visualize the grid extents for modifications based on the grid extents and coastline  
% Name: Hassaan Mohamed 
% Student Number: 1070154

clc;                        % Clear the command window 
close all;                  % Close all figures 
clear all;                  % Clear all existing variables

% The purpose of this script is to import the grid characteristics defined by the previous script and plot it
% A plot of the grids vs the coastlines helps identify any issues with the grid and if we need any modifications to the grid points manually 

% Plotting the intended coastline first using the shapefile 
M = m_shaperead('');
xv = [];
yv = [];

for i = 1:numel(M.ncst)
    x = [M.ncst{i}(:,1).'];
    y = [M.ncst{i}(:,2).'];

    % Concatenate NaN values between segments 
    if i > 1
        xv = [xv NaN];
        yv = [yv NaN];
    end

    % Concatenate the X and Y coordinates for the current segment
    xv = [xv x];
    yv = [yv y];
end

plot (xv, yv); 
hold on 

% Load the Grid origin points 
Grid_generation_pts = readtable ('');
gx = table2array (Grid_generation_pts (:,1));
gy = table2array (Grid_generation_pts (:,2));

scatter (gx, gy);
g = [1:length(gx)]';
h = num2str(g);
i = cellstr(h);
ix = 0.1; iy = 0.1;
text (gx+ix, gy+iy, i);

hold on

% Load the Grid characteristics created from the dedicated script 
Grid_details = readtable ('Grid_characteristics.csv');

Grid_array = table2array (Grid_details);
x0 = table2array (Grid_details (:,1));
y0 = table2array (Grid_details (:,2));

scatter (x0,y0, 'filled');
j = [1:length(x0)]';
k = num2str(j);
l = cellstr(k);
lx = 0.1; ly = 0.1;
text (x0+lx, y0+ly, l);

hold on

q1_grid_idx = find(Grid_array (:,7) == 90);
q2_grid_idx = find(Grid_array (:,7) == 0);
q3_grid_idx = find(Grid_array (:,7) == -90);
q4_grid_idx = find(Grid_array (:,7) == 180);

q1_x0 = x0(q1_grid_idx);
q1_y0 = y0(q1_grid_idx);
q1_x1 = x0(q1_grid_idx) - 100*1000;
q1_y1 = y0(q1_grid_idx);
q1_x2 = x0(q1_grid_idx);
q1_y2 = y0(q1_grid_idx) + 100*1000;
q1_x3 = x0(q1_grid_idx) - 100*1000;
q1_y3 = y0(q1_grid_idx) + 100*1000;

q2_x0 = x0(q2_grid_idx);
q2_y0 = y0(q2_grid_idx);
q2_x1 = x0(q2_grid_idx);
q2_y1 = y0(q2_grid_idx) + 100*1000;
q2_x2 = x0(q2_grid_idx) + 100*1000;
q2_y2 = y0(q2_grid_idx);
q2_x3 = x0(q2_grid_idx) + 100*1000;
q2_y3 = y0(q2_grid_idx) + 100*1000;

q3_x0 = x0(q3_grid_idx);
q3_y0 = y0(q3_grid_idx);
q3_x1 = x0(q3_grid_idx) + 100*1000;
q3_y1 = y0(q3_grid_idx);
q3_x2 = x0(q3_grid_idx);
q3_y2 = y0(q3_grid_idx) - 100*1000;
q3_x3 = x0(q3_grid_idx) + 100*1000;
q3_y3 = y0(q3_grid_idx) - 100*1000;

q4_x0 = x0(q4_grid_idx);
q4_y0 = y0(q4_grid_idx);
q4_x1 = x0(q4_grid_idx);
q4_y1 = y0(q4_grid_idx) - 100*1000;
q4_x2 = x0(q4_grid_idx) - 100*1000;
q4_y2 = y0(q4_grid_idx);
q4_x3 = x0(q4_grid_idx) - 100*1000;
q4_y3 = y0(q4_grid_idx) - 100*1000;

% Plot the grids and the intended coastline for visualisation and the manual check 
for i = 1:length(q1_grid_idx)
    q1_x = [q1_x0(i), q1_x2(i), q1_x3(i),  q1_x1(i),  q1_x0(i)];
    q1_y = [q1_y0(i), q1_y2(i), q1_y3(i),  q1_y1(i),  q1_y0(i)];
    plot (q1_x, q1_y, 'b-', 'Linewidth', 3);
    labels = {'label 1','label 2','label 3', 'label 4', 'label 1'};
    text(q1_x, q1_y, labels, 'verticalAlignment', 'bottom', 'HorizontalAlignment','left'); 
    hold on 
end

hold on 

for i = 1:length(q2_grid_idx)
    q2_x = [q2_x0(i), q2_x1(i), q2_x3(i), q2_x2(i), q2_x0(i)];
    q2_y = [q2_y0(i), q2_y1(i), q2_y3(i), q2_y2(i), q2_y0(i)];
    plot (q2_x, q2_y, 'r-', 'Linewidth', 3);
    labels = {'label 1','label 2','label 3', 'label 4', 'label 1'};
    text(q2_x, q2_y, labels, 'verticalAlignment', 'bottom', 'HorizontalAlignment','left'); 
    hold on 
end

hold on 

for i = 1:length(q3_grid_idx)
    q3_x = [q3_x0(i), q3_x1(i), q3_x3(i), q3_x2(i), q3_x0(i)];
    q3_y = [q3_y0(i), q3_y1(i), q3_y3(i), q3_y2(i), q3_y0(i)];
    plot (q3_x, q3_y, 'k-', 'Linewidth', 3);
    labels = {'label 1','label 2','label 3', 'label 4', 'label 1'};
    text(q3_x, q3_y, labels, 'verticalAlignment', 'bottom', 'HorizontalAlignment','left');
    hold on 
end

hold on 

for i = 1:length(q4_grid_idx)
    q4_x = [q4_x0(i), q4_x1(i), q4_x3(i), q4_x2(i), q4_x0(i)];
    q4_y = [q4_y0(i), q4_y1(i), q4_y3(i), q4_y2(i),  q4_y0(i)];
    plot (q4_x, q4_y, 'm-', 'Linewidth', 3);
    labels = {'label 1','label 2','label 3', 'label 4', 'label 1'};
    text(q4_x, q4_y, labels, 'verticalAlignment', 'bottom', 'HorizontalAlignment','left');
    hold on 
end





