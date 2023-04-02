%% Generating the Mask input files for the SFINCS models (Script 1 of 1)
% Defining the active, non-active, outflow boundary and water-level input boundary grid cells of the SFINCS models
% Name: Hassaan Mohamed
% Student Number: 1070154

clc;                        % Clear the command window
close all;                  % Close al figures
clear all;                  % Clear all existing variables

% First read the shapefiles for the land areas and the boundary polyline adopted from QGIS and AutoCAD
land_pols = m_shaperead('');
%boundary_line = m_shaperead('');


% Read the grid data of all the relevant subfolders
grid_bb_dir = '';
bb_info = dir(fullfile(grid_bb_dir, 'S*'));
bb_info = natsortfiles (bb_info);
bb_info(~[bb_info.isdir]) = []; % To get rid of any S* that are potentially not folders
subfolders = fullfile (grid_bb_dir,{bb_info.name});

% Use a for loop to load the grid data for each model and create the subsequent mask file
for i = 1:length(subfolders)
    current_folder = subfolders{i};
    mat_info  = dir(fullfile(current_folder,'G*.mat'));
    mat_names = fullfile (current_folder,{mat_info.name});
    current_file = mat_names{1};
    mat_data = load(current_file);

    % Define the geographical coordinates of the four corner of the grid
    if mat_data.grid_variable(5) == 90
        xmin = mat_data.grid_variable(2); xmax = mat_data.grid_variable(1); ymin = mat_data.grid_variable(3); ymax = mat_data.grid_variable(4);

    else if mat_data.grid_variable(5) == 0
            xmin = mat_data.grid_variable(1); xmax = mat_data.grid_variable(2); ymin = mat_data.grid_variable(3); ymax = mat_data.grid_variable(4);

    else if mat_data.grid_variable(5) == -90
            xmin = mat_data.grid_variable(1); xmax = mat_data.grid_variable(2); ymin = mat_data.grid_variable(4); ymax = mat_data.grid_variable(3);

    else if mat_data.grid_variable(5) == 180
            xmin = mat_data.grid_variable(2); xmax = mat_data.grid_variable(1); ymin = mat_data.grid_variable(4); ymax = mat_data.grid_variable(3);
    end
    end
    end
    end

    % Create the 3333X3333 mesh for the grid defined by the 4 corner points
    [x,y] =  meshgrid(linspace(xmin,xmax,3333), linspace(ymin,ymax,3333));

    % Define the resolution and create the empty mask file
    resolution = [30 30];
    mask = zeros(99990/resolution(1),99990/resolution(2));

    % Loop through polygons in the land area shapefile
    for j = 1:length(land_pols.ncst)                   
        sz = size(mask);
        msk = mask(:);
        %msk=0;
        [in,on] = inpoly2([x(:),y(:)],[land_pols.ncst{j}(:,1),land_pols.ncst{j}(:,2)]);             % Check if each point in the grid is within the current polygon
        msk(in) = 1; 
        mask = reshape(msk,sz);
        mask(in) = 1;                                                                               % Update the mask with the points that are within the polygon
    end
    
    % The boundary values need to be 2 for the SFINCS model. 
    % It appears that inpoly2 function is unable to define the boundary grid cells properly
    % The process that would be implemented is to do 4 sweeps across the grids from all ends
        ... check for 1s and also if it is adjacent to a 0 by checking the elements above, below, to the left and to the right
            ... If both conditions are met, the value of the element is changed from 1 to 2
        for k = 1:4
        % for each sweep, check each element of the grid
        for row = 1:size(mask, 1)
            for col = 1:size(mask, 2)
                % if the current element is a 1 and it is adjacent to a 0,
                % change it to a 2
                if mask(row, col) == 1 && ...
                        ((row > 1 && mask(row-1, col) == 0) || ...
                         (row < size(mask, 1) && mask(row+1, col) == 0) || ...
                         (col > 1 && mask(row, col-1) == 0) || ...
                         (col < size(mask, 2) && mask(row, col+1) == 0))
                    mask(row, col) = 2;
                end
            end
        end
    end
    

    % The edge of the grids should be set to "3=outflow" 
    % This is to ensure that water is not accumulating adjacent to the lateral model boundaries 
    for iside = 1:4
        switch iside
            case 1 %up
               mask(1,mask(1,:)==1)=3;
               
            case 2 %left
                mask(mask(:,1)==1, 1)=3;

            case 3 %right
                mask(mask(:,end)==1, end)=3;

            case 4 %down
                mask(end,mask(end,:)==1)=3;                
        end
    end

      % Save the mask file in the relevant subfolder of the SFINCS model in ASCII format. 
      % This would later be converted to the BIN format 
      mask_name = ['sfincs_ascii.msk', sprintf('%d')];
      filename = fullfile(grid_bb_dir, bb_info(i).name,mask_name);
      writematrix(mask,filename,"Delimiter",' ','FileType','text');
end







