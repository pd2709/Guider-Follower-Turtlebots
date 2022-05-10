%% Extract green channel.
redChannel = Turtle.obsImg(:, :, 1);
greenChannel = Turtle.obsImg(:, :, 2);
blueChannel = Turtle.obsImg(:, :, 3);
%% Threshold to find the bright blobs.
%mask = (redChannel < 128) .* (greenChannel > 128) .* (blueChannel < 128); % or whatever works.
redMask = redChannel < 128;
greenMask = greenChannel > 90;
blueMask = blueChannel < 128;
mask = redMask + greenMask + blueMask;
mask = mask > 2;
%% Extract only the 5 largest blobs.
mask = bwareafilt(mask, 4);
%% Find centroids.
hold off
imshow(mask)
props = regionprops(mask, 'Centroid');
% Extract centroids from structure into a double array.
xy = vertcat(props.Centroid);

% Convert image to grayscale
%imageGray = im2gray(img);

hold on
axis on

%%
for i = 1:length(xy)
    plot(xy(i,1),xy(i,2), 'r+', 'MarkerSize', 30, 'LineWidth', 2);
end