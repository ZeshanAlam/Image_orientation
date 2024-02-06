% Close all figures and clear workspace
close all;
clear all;

% Define the data path
datapath = '.\data';

% Retrieve lists of image and depth map files
imageFiles = dir(fullfile(datapath, '*.jpg'));
depthMapFiles = dir(fullfile(datapath, '*.png')); 

% Predefined input angles
Input_angle = [90, 0, 0, 0, 0, 270, 270, 0, 0, 0, 270, 270];

% Initialize output angles array
Angle_theta = [];

% Load image and depth map
for i = 1:length(imageFiles)
    % Read the current image and depth map
    image = imread(fullfile(datapath, imageFiles(i).name));
    depthMap = imread(fullfile(datapath, depthMapFiles(i).name));

    % Convert depth map to grayscale if it's in color
    if size(depthMap, 3) == 3
        depthMap = rgb2gray(depthMap);
    end

    % Adjust depth map if minimum depth is 0
    minD = min(min(depthMap));
    if minD == 0
        depthMap = depthMap + 1;
    end

    % Rotate image and depth map according to the predefined input angles
    imtilt = imrotate(image, Input_angle(i));
    drot = imrotate(depthMap, Input_angle(i));

    % Display the original rotated image
    figure, imshow(imtilt); title('Input_image');

    % Initialize counter for theta
    count_theta = 0;

    % Compute the angle using Main_angle_outer function
    Theta_out = Main_angle_outer(drot);

    % Display the corrected image after adjusting for Theta_out
    figure, imshow(imrotate(imtilt, -Theta_out, "loose")); title('Fixed_image');
end
 
    