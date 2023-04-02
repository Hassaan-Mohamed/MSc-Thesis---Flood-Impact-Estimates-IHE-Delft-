%% Generating the grids and main input files for the SFINCS models (Script 2 of 5)
% Adjusting the grid points based on the coastline 
% Name: Hassaan Mohamed 
% Student Number: 1070154

clc;                        % Clear the command window 
close all;                  % Close al figures 
clear all;                  % Clear all existing variables

%% Import the Grid hookup points 

% Read the x,y coordinates of the grid generation points 
% Obtained from QGIS and saved as CSV file which is loaded here

GRD_Hook_ups = readtable ('UK_Grid_Points');
xp = table2array (GRD_Hook_ups(:,1));
yp = table2array (GRD_Hook_ups(:,2)); 

%% Import the orientation information 
% This is the adjusted/corrected orientation information after a qualitative check from the maps

Orientation_info = readtable ('orientation_grd_pts_corrected.csv');
orient = table2array(Orientation_info(:,1));

%% Built-in check 

% The purpose is to check whether the rectangular grids generated from the grid points does not intersect with the coastline 
% If the vertical or horizontal check vectors intersect the buffer polyline, then it indicates that the grid point should be further moved away from the coastline

B = m_shaperead('UK_Boundary_Buffer_final');

xb = [];
yb = [];

for i = 1:numel(B.ncst)
    xi = [B.ncst{i}(:,1).'];
    yi = [B.ncst{i}(:,2).'];

    % Concatenate NaN values between segments 
    if i > 1
        xb = [xb NaN];
        yb = [yb NaN];
    end

    % Concatenate the X and Y coordinates for the current segment
    xb = [xb xi];
    yb = [yb yi];
end


% Create the vertical and horizontal check polylines 
q1_Hits = zeros (1, length (xp));
q2_Hits = zeros (1, length (xp));
q3_Hits = zeros (1, length (xp));
q4_Hits = zeros (1, length (xp));

for i = 1:length(xp)
    if orient(i) >= 135 && orient (i) <= 225
        q4_Hits(i) = 1;
        q4_Hits_amount = nnz (q4_Hits);

        q4_check_y(:,i) = (linspace (yp(i)+50*1000,yp(i)-50*1000,2000)).';
        q4_check_y = q4_check_y(:, any(q4_check_y));

        
        q4_check_x0 (:,i) = xp (i);
        q4_check_x = repelem (q4_check_x0(1:end, :), 2000,1);
        q4_check_x = q4_check_x(:, any(q4_check_x));

    elseif orient(i) >= 45 && orient (i) <= 135
        q1_Hits(i) = 1;
        q1_Hits_amount = nnz (q1_Hits);

        q1_check_x(:,i) = (linspace (xp(i)+50*1000,xp(i)-50*1000,2000)).';
        q1_check_x = q1_check_x(:, any(q1_check_x));

        
        q1_check_y0 (:,i) = yp (i);
        q1_check_y = repelem (q1_check_y0(1:end, :), 2000,1);
        q1_check_y = q1_check_y(:, any(q1_check_y));

    elseif orient(i) >= 315 || orient (i) <= 45
        q2_Hits(i) = 1;
        q2_Hits_amount = nnz (q2_Hits);

        q2_check_y(:,i) = (linspace (yp(i)+50*1000,yp(i)-50*1000,2000)).';
        q2_check_y = q2_check_y(:, any(q2_check_y));

        
        q2_check_x0 (:,i) = xp (i);
        q2_check_x = repelem (q2_check_x0(1:end, :), 2000,1);
        q2_check_x = q2_check_x(:, any(q2_check_x));

    elseif orient(i) >= 225 && orient (i) <= 315
        q3_Hits(i) = 1;
        q3_Hits_amount = nnz (q3_Hits);

        q3_check_x(:,i) = (linspace (xp(i)+50*1000,xp(i)-50*1000,2000)).';
        q3_check_x = q3_check_x(:, any(q3_check_x));

        
        q3_check_y0 (:,i) = yp (i);
        q3_check_y = repelem (q3_check_y0(1:end, :), 2000,1);
        q3_check_y = q3_check_y(:, any(q3_check_y));
    end
end

%% Index the quadrant points 

q1_grid_idx = find(orient >= 45 & orient <= 135);
q2_grid_idx = find(orient >= 315 | orient <= 45);
q3_grid_idx = find(orient >= 225 & orient <= 315);
q4_grid_idx = find(orient >= 135 & orient <= 225);

%% Quadrant 1 computations 

for t = 1:size(q1_check_x, 2)
    [q1_xi, q1_yi] = intersections (xb, yb, q1_check_x(:,t), q1_check_y(:,t));
    q1_ints_x{t} = q1_xi;
    q1_ints_y{t} = q1_yi;
end

for j = 1:length (q1_ints_x)
    if height (q1_ints_x{j}) > 1

        if max(q1_ints_x{j}) > xp(q1_grid_idx(j))
            q1_ints_x_max{j} = max(q1_ints_x{j});
        else
            q1_ints_x_max{j} = xp(q1_grid_idx(j));
        end

        
        if min(q1_ints_x{j}) < xp(q1_grid_idx(j))
            q1_ints_x_min{j} = min(q1_ints_x{j});
        else
            q1_ints_x_min{j} = xp(q1_grid_idx(j));
        end

        q1_ints_x_min_max{j} = [q1_ints_x_min{j}, q1_ints_x_max{j}];

        elseif height (q1_ints_x {j}) == 1
            q1_ints_x_min_max{j} = [min(q1_check_x(:, j)), max(q1_check_x(:, j))];
    end
end

  
for a = 1:numel(q1_ints_x_min_max)
    q1_x_min_max_array = q1_ints_x_min_max{a};
    q1_idx_btwn_ints = find ((xb>q1_x_min_max_array(:,1)) & (xb<q1_x_min_max_array(:,2)));
    q1_new_y_grid_pts_cell{a} = min(yb(q1_idx_btwn_ints));
    q1_new_y_grid_pts = cell2mat(q1_new_y_grid_pts_cell);
end

%% Quadrant 2 computations 

for t = 1:size(q2_check_x, 2)
    [q2_xi, q2_yi] = intersections (xb, yb, q2_check_x(:,t), q2_check_y(:,t));
    q2_ints_x{t} = q2_xi;
    q2_ints_y{t} = q2_yi;
end

for j = 1:length (q2_ints_y)
    if height (q2_ints_y{j}) > 1

        if max(q2_ints_y{j}) > yp(q2_grid_idx(j))
            q2_ints_y_max{j} = max(q2_ints_y{j});
        else
            q2_ints_y_max{j} = yp(q2_grid_idx(j));
        end

        
        if min(q2_ints_y{j}) < yp(q2_grid_idx(j))
            q2_ints_y_min{j} = min(q2_ints_y{j});
        else
            q2_ints_y_min{j} = yp(q2_grid_idx(j));
        end

        q2_ints_y_min_max{j} = [q2_ints_y_min{j}, q2_ints_y_max{j}];

        elseif height (q2_ints_y {j}) == 1
            q2_ints_y_min_max{j} = [min(q2_check_y(:, j)), max(q2_check_y(:, j))];
    end
end
  
for a = 1:numel(q2_ints_y_min_max)
    q2_y_min_max_array = q2_ints_y_min_max{a};
    q2_idx_btwn_ints = find ((yb>q2_y_min_max_array(:,1)) & (yb<q2_y_min_max_array(:,2)));
    q2_new_x_grid_pts_cell{a} = min(xb(q2_idx_btwn_ints));
    q2_new_x_grid_pts = cell2mat(q2_new_x_grid_pts_cell);
end

%% Quadrant 3 computations 

for t = 1:size(q3_check_x, 2)
    [q3_xi, q3_yi] = intersections (xb, yb, q3_check_x(:,t), q3_check_y(:,t));
    q3_ints_x{t} = q3_xi;
    q3_ints_y{t} = q3_yi;
end

for j = 1:length (q3_ints_x)
    if height (q3_ints_x{j}) > 1
        q3_ints_x_min_max{j} = [min(q3_ints_x {j}), max(q3_ints_x {j})];

        elseif height (q3_ints_x {j}) == 1
            q3_ints_x_min_max{j} = [min(q3_check_x(:, j)), max(q3_check_x(:, j))];
    end
end
  

for j = 1:length (q3_ints_x)
    if height (q3_ints_x{j}) > 1

        if max(q3_ints_x{j}) > xp(q3_grid_idx(j))
            q3_ints_x_max{j} = max(q3_ints_x{j});
        else
            q3_ints_x_max{j} = xp(q3_grid_idx(j));
        end

        
        if min(q3_ints_x{j}) < xp(q3_grid_idx(j))
            q3_ints_x_min{j} = min(q3_ints_x{j});
        else
            q3_ints_x_min{j} = xp(q3_grid_idx(j));
        end

        q3_ints_x_min_max{j} = [q3_ints_x_min{j}, q3_ints_x_max{j}];

        elseif height (q3_ints_x {j}) == 1
            q3_ints_x_min_max{j} = [min(q3_check_x(:, j)), max(q3_check_x(:, j))];
    end
end

  
for a = 1:numel(q3_ints_x_min_max)
    q3_x_min_max_array = q3_ints_x_min_max{a};
    q3_idx_btwn_ints = find ((xb>q3_x_min_max_array(:,1)) & (xb<q3_x_min_max_array(:,2)));
    q3_new_y_grid_pts_cell{a} = max(yb(q3_idx_btwn_ints));
    q3_new_y_grid_pts = cell2mat(q3_new_y_grid_pts_cell);
end

%% Quadrant 4 computations 

for t = 1:size(q4_check_x, 2)
    [q4_xi, q4_yi] = intersections (xb, yb, q4_check_x(:,t), q4_check_y(:,t));
    q4_ints_x{t} = q4_xi;
    q4_ints_y{t} = q4_yi;
end

for j = 1:length (q4_ints_y)
    if height (q4_ints_y{j}) > 1

        if max(q4_ints_y{j}) > yp(q4_grid_idx(j))
            q4_ints_y_max{j} = max(q4_ints_y{j});
        else
            q4_ints_y_max{j} = yp(q4_grid_idx(j));
        end

        
        if min(q4_ints_y{j}) < yp(q4_grid_idx(j))
            q4_ints_y_min{j} = min(q4_ints_y{j});
        else
            q4_ints_y_min{j} = yp(q4_grid_idx(j));
        end

        q4_ints_y_min_max{j} = [q4_ints_y_min{j}, q4_ints_y_max{j}];

        elseif height (q4_ints_y {j}) == 1
            q4_ints_y_min_max{j} = [min(q4_check_y(:, j)), max(q4_check_y(:, j))];
    end
end
  
 
for a = 1:numel(q4_ints_y_min_max)
    q4_y_min_max_array = q4_ints_y_min_max{a};
    q4_idx_btwn_ints = find ((yb>q4_y_min_max_array(:,1)) & (yb<q4_y_min_max_array(:,2)));
    q4_new_x_grid_pts_cell{a} = max(xb(q4_idx_btwn_ints));
    q4_new_x_grid_pts = cell2mat(q4_new_x_grid_pts_cell);
end

% After the checks the grid points in each quadrant would either remain at their current location or be moved away from the coastline based on their orientation
% This is to ensure that all the land area will be encompassed within the generated grids and not fall outside of it 



%% Creating the Grid Final Points 

new_yp = yp;
new_xp = xp;

new_yp(q1_grid_idx) = q1_new_y_grid_pts;
new_yp(q3_grid_idx) = q3_new_y_grid_pts;

new_xp(q2_grid_idx) = q2_new_x_grid_pts;
new_xp(q4_grid_idx) = q4_new_x_grid_pts;

new_grid_pts = [new_xp(:) , new_yp(:)];
writematrix(new_grid_pts, 'new_grd_points.csv')

%% Plot the coastline and the new points for visualization 

M = m_shaperead('UK_Boundary_reprojected');
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

plot (xb,yb);
hold on

scatter (xp, yp);
x = [1:length(xp)]';
y = num2str(x);
i = cellstr(y);
ix = 0.1; iy = 0.1;
text (xp+ix, yp+iy, i);
hold on 

scatter (new_xp, new_yp);
n_x = [1:length(new_xp)]';
n_y = num2str(n_x);
n_i = cellstr(n_y);
n_ix = 0.1; n_iy = 0.1;
text (new_xp+n_ix, new_yp+n_iy, n_i);


