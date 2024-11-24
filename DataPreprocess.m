%% Clear Environment Variables
warning off; % Disable warning messages
close all; % Close all figure windows
clear; % Clear all variables
clc; % Clear the command window

%% Import Data
data = xlsread('posad.xlsx');

% Preprocess each column (feature) in the dataset
for j = 1:size(data, 2)
% Calculate the mean of non-NaN values in the column
col_mean = mean(data(~isnan(data(:, j)), j));

% Replace NaN values with the mean
data(isnan(data(:, j)), j) = col_mean;

% Calculate the standard deviation of the column
col_std = std(data(:, j));

% Replace values exceeding three standard deviations from the mean with the mean
data(abs(data(:, j) - col_mean) > 3 * col_std, j) = col_mean;
end

%% Save Processed Dataset
% Write the processed dataset to an Excel file
writetable(array2table(data), 'processed_PosAd.xlsx');