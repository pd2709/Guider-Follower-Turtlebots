%% file conversion
% f=dir('straight2.jpg');
% fil={f.name};  
% for k=1:numel(fil)
%   file=fil{k};
%   new_file=strrep(strcat('P',file),'.jpg','.tif');
%   im=imread(file);
%   imwrite(im,new_file);
% end

%% SURF feature detection method
clear;
clf;
clc;
R = imread('Pstraight1.tif');
I = rgb2gray(R);
% points = detectSURFFeatures(I);
% points =detectMinEigenFeatures(I);
% points = detectFASTFeatures(I);
% points = detectBRISKFeatures(I);
points = detectKAZEFeatures(I); %works
[ref_f, ref_vp] = extractFeatures(I, points);
figure; imshow(I);
hold on;
plot(points.selectStrongest(50))

%% Visual
figure;
subplot(5,5,3); title('First 25 Features');
for i=1:15
    scale = points(i).Scale;
    image = imcrop(R,[points(i).Location-10*scale 20*scale 20*scale]);
    subplot(5,5,i);
    imshow(image);
    hold on;
    rectangle('Position',[5*scale 5*scale 10*scale 10*scale],'Curvature',1,'EdgeColor','g');
end

%% Compare to video frame
image = imread ('left.jpg');
VI = rgb2gray(image);
% detect features
% VI_pts = detectSURFFeatures(VI);
VI_pts = detectKAZEFeatures(VI);
% VI_pts = detectFASTFeatures(VI);
[VI_f, VI_vp] = extractFeatures(VI, VI_pts);
figure; imshow(image);
hold on;
plot(VI_pts.selectStrongest(30));

%% Compare pattern image to camera video frame
index_pairs = matchFeatures(ref_f, VI_f);
ref_matched_pts = ref_vp(index_pairs(:,1)).Location;
VI_matched_pts = VI_vp(index_pairs(:,2)).Location;
figure; showMatchedFeatures(VI, I, VI_matched_pts, ref_matched_pts, 'montage');
title('all matches');

%% Define Geometric Transformation Objects 

% [tform_matrix,ref_inlier_pts ,VI_inlier_pts ] = estimateGeometricTransform(ref_matched_pts, VI_matched_pts, 'similarity')
% % gte = estimateGeometricTransform(VI_matched_pts, ref_matched_pts, 'similarity')
% % gte. = 'Random Sample Consensus (RANSAC)';
% % [tform_matrix, inlierIdx] = step(ref_matched_pts, VI_matched_pts);

% figure;showMatchedFeatures(image,R,VI_inlier_pts,ref_inlier_pts);
% title('inliers only');
[tform_matrix, ref_inlier_pts, VI_inlier_pts] = estimateGeometricTransform...
    (ref_matched_pts, VI_matched_pts, 'affine'); 
% ref_inlier_pts = ref_matched_pts(inlierIdx,:);
% VI_inlier_pts = VI_matched_pts(inlierIdx,:);
% Draw the lines to matched points
figure; showMatchedFeatures(VI, I, VI_inlier_pts, ref_inlier_pts);
title('Showing match only with inliers');
%% Transform corner points
% tform = maketform('affine',double(tform_matrix));
% [width, height,~] = size(R);
% corners = [0,0;height,0;height,width;0,width];
% new_corners = tformfwd(tform, corners(:,1),corners(:,2));
% figure;imshow(image);
% patch(new_corners(:,1),new_corners(:,2),[0 1 0],'FaceAlpha',0.5);

T = maketform('affine',double(tform_matrix.T)); 
[width, height] = size(R);
corners = [0, 0; 
    height, 0;
    height, width;
    0, width];
new_corners = tformfwd(T, corners(:,1), corners(:,2));
figure; imshow(VI);
patch(new_corners(:,1), new_corners(:,2), [0 1 0], 'FaceAlpha', 0.5);