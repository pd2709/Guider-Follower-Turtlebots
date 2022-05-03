% This work is done in preparation for Week 1, we were instructed to
% get comfortable with capturing video and pictures with the webcam 
% using MATLAB

clear;
clc;

% Show the available webcams using the following:
webcamlist

% The above command will give an 'ans' variable which will be a column
% vector of available webcams, this list can also be automatically accessed
% with 'webcam' or 'webcam(x)' to access the xth webcam on the list. With
% no input it defaults to the first webcam
cam = webcam

% We can preview live a live camera feed with the following command on the
% cam object
preview(cam)

% We can show available resolutions with the following command:
cam.AvailableResolutions

% We can close the preview with the following command, commented out in
% this case because we're running in a script:
% closePreview(cam)

% We can capture a single image using the following command:
img = snapshot(cam);

% And we can show the captured picture with either of the following
% commands, one of them is commented out for the sake of the script:
% imshow(img)
image(img)

% Clean up by clearing the object
% clear('cam');