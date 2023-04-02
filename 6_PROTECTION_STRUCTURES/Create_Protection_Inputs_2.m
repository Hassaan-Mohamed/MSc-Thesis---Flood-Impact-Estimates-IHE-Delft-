%% Incorporating the protection structures within the SFINCS models (Script 2 of 6)  
% Generating the missing data for the protection levels 
% Name: Hassaan Mohamed 
% Student Number: 1070154

clc;                        % Clear the command window 
close all;                  % Close all figures 
clear all;                  % Clear all existing variables

% The ESL data does not cover all the protection levels provided for the European coastline
% ESL data for RP2 and RP30 are not available, hence Z values for protection level 2 and 30 need to be generated 
% A polynomial fit is going to be utilized to interpolate these return period values from the ones that are available
% RP1, RP5, RP10, RP20, RP50, RP100, RP200 are the available ESL data 

% Import the ESL data needed to set the protection levels 
ESL_RP1    = table2array (readtable('ESL1_RPs_Baseline_median_RP1_reprojected.csv')); 
ESL_RP5    = table2array (readtable('ESL1_RPs_Baseline_median_RP5_reprojected.csv')); 
ESL_RP10   = table2array (readtable('ESL1_RPs_Baseline_median_RP10_reprojected.csv')); 
ESL_RP20   = table2array (readtable('ESL1_RPs_Baseline_median_RP20_reprojected.csv')); 
ESL_RP50   = table2array (readtable('ESL1_RPs_Baseline_median_RP50_reprojected.csv')); 
ESL_RP100  = table2array (readtable('ESL1_RPs_Baseline_median_RP100_reprojected.csv')); 
ESL_RP200  = table2array (readtable('ESL1_RPs_Baseline_median_RP200_reprojected.csv'));          

% Ensure that the line passes through all the 7 points of the data or is the best fit 
% Y-axis is the ESL and the x-axis is the log of the return periods
% A for loop is implemented to the get the RP2 and RP30 values

for i = 1:length(ESL_RP1)
    % Define the data for the available return periods 
    x = [1 5 10 20 50 100 200];
    y = [ESL_RP1(i,5), ESL_RP5(i,5), ESL_RP10(i,5), ESL_RP20(i,5), ESL_RP50(i,5), ESL_RP100(i,5), ESL_RP200(i,5)];

    % Use log(x) on the x-axis
    xlog = log(x);

    % Fit a polynomial of degree 6 to the data
    p = polyfit(xlog,y,6);

    % Evaluate the polynomial at log(x)=log(30)
    xlog30 = log(30);
    ESL_RP30(i) = polyval(p, xlog30); 
end 

for i = 1:length(ESL_RP1)
    % Define the data for the available return periods 
    x = [1 5 10 20 50 100 200];
    y = [ESL_RP1(i,5), ESL_RP5(i,5), ESL_RP10(i,5), ESL_RP20(i,5), ESL_RP50(i,5), ESL_RP100(i,5), ESL_RP200(i,5)];

    % Use log(x) on the x-axis
    xlog = log(x);

    % Fit a polynomial of degree 6 to the data
    p = polyfit(xlog,y,2);

    % Evaluate the polynomial at log(x)=log(2)
    xlog2 = log(2);
    ESL_RP2(i) = polyval(p, xlog2); 
end 

% Make the full matrices for the ESL_RP2 and ESL_RP30
% Then save them as CSV file in the directory to be used in the next script 
ESL_RP2 = [ESL_RP1(:,1:4), ESL_RP2.']; 
ESL_RP30 = [ESL_RP1(:,1:4), ESL_RP30.']; 

writematrix(ESL_RP2, 'ESL1_RPs_Baseline_median_RP2_reprojected.csv');
writematrix(ESL_RP30, 'ESL1_RPs_Baseline_median_RP30_reprojected.csv');






%% Plot tp see the results and check the best fit 

% Plot the data and polynomial
scatter(xlog,y)
hold on
xxlog = linspace(min(xlog),max(xlog),100); % x values for plotting the polynomial
yylog = polyval(p,xxlog); % y values for plotting the polynomial
plot(xxlog,yylog)
xlabel('log(x)')
ylabel('y')
title('Best-fit polynomial of degree 2 for log(x) and y data')
legend('Data','Best-fit polynomial')


% Limited sample size: The sample size of the data used to estimate the parameters might be small, leading to imprecise estimates of the parameters. 
% With a larger sample size, the estimates might be more accurate and the result for y at x = 2 & x = 30



































