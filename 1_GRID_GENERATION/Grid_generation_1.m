%% Generating the grids and main input files for the SFINCS models (Script 1 of 5)
% Determining the orientation of the grid points in relation to the coastline
% Name: Hassaan Mohamed 
% Student Number: 1070154

clc;                        % Clear the command window 
close all;                  % Close al figures 
clear all;                  % Clear all existing variables

%% Finding the distance and angle between the buffer points and the coastline 

% Read the x,y coordinates of the grid generation points 
% Obtained from QGIS and saved as CSV file which is loaded here
% Change the hook up points based on the location of your model

GRD_Hook_ups = readtable ('');                           
xp = table2array (GRD_Hook_ups(:,1));
yp = table2array (GRD_Hook_ups(:,2)); 
Grid_hookup_pts = [xp, yp];

scatter (xp, yp);
x = [1:length(xp)]';
y = num2str(x);
i = cellstr(y);
ix = 0.1; iy = 0.1;
text (xp+ix, yp+iy, i);

hold on 

% Read the x,y coordinates of the shapefile that defines the coastline 
% The lon,lat data stored in the M.structure file is extracted
% Change the coastline based on the location of your model 

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

% p_poly_dist function to be used to find the relationships between the Grid hookup points and the coastline 
% d_min - vector of distances (1 X np) from points to polyline
% x_d_min - vector (1 X np) of X coordinates of the closest points of polyline.
% y_d_min - vector (1 X np) of Y coordinates of the closest points of polyline.

% If is_vertex(j)==true, the closest polyline point to a point (xp(j), yp(j)) is a vertex. Otherwise, this --
% point is a projection on polyline's segment.

% xc - an array (np X nv-1) containing X coordinates of all projected points. 
% xc(j,k) is an X coordinate of a projection of point j on a segment k

% yc - an array (np X nv-1) containing Y coordinates of all projected
% points. yc(j,k) is Y coordinate of a projection of point j on a segment k

% idx_c - vector (1 X np) of indices of segments that contain the closest point. 
% For instance,  idx_c(2) == 4 means that the polyline point closest to point 2 belongs to segment 4

[d_min, x_d_min, y_d_min, is_vertex, xc, yc, idx_c] = p_poly_dist (xp,yp,xv,yv);

% atan2d to be utilized to find the angle 
% atan2d gives the angle between the vector and the x-axis in degrees 
% Angle is measured in a counterclockwise direction
% The orientation can then be utilized to label the grid point between one of the 4 quadrants
% point
y1 = (y_d_min) - (yp);
x1 = (x_d_min) - (xp);

orient = mod(atan2d (y1 , x1),360);

orientation_grd_pts = [xp, yp, orient];
writematrix (orientation_grd_pts,'orientation_grd_pts.csv')

% The csv file produced will give the orientation for the input points based on the p_poly_dist function outputs 
% This orientation might not be accurate still but would be applicable to majority of the points 
% So use an "Orientation_Correction" Excel sheet to manually fix the orientation based on visual assessment of the point location on the map 















