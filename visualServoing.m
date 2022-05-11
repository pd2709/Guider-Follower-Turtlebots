%% Feature detection
close all
clear all


p = imread('straight1.jpg');
img = rgb2gray(p);

% Calculate corner points using Harris Feature detector
cp = detectHarrisFeatures(img);

cp.Location
cp.plot
%%

    BW = imread('Pstraight1.tif');
    BW = I < 100;
    imshow(BW)
    stats = regionprops('table',BW,'Centroid',...
    'MajorAxisLength','MinorAxisLength')
    centers = stats.Centroid;
    diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
    radii = diameters/2;
    hold on
    viscircles (centers, radii);
    hold off
% hax = drawcircle(gca,'Center',[115 69],'Radius', 400);
% mask = createMask(hax);
%% Control

f = 400;
p = length(img)/2;
Z = 50;
l = 0.1; %lambda 

% Populate Observation vector using values from "feature detection section"
% Populate target vector using image size (define your own target size for
% the square)

%% image_1.png
% Target = [250,250;
%           250,750;
%           750,250;
%           750,750];
%       
% Obs = [ 100.4890,  100.4890;
%         100.4890,  598.5110;
%         598.5110,  100.4890;
%         598.5110,  598.5110;];

%% image_2.png
Target = [  446,946;
            446,446;
            946,946;
            946,446
            
    ];

Obs = [313.5,    547.7;
    599.0,    140.2;
    720.9,    833.3;
    1006.4 ,   425.7;];

%%
xy = (Target-p)/f;
Obsxy = (Obs-p)/f;

%%
n = length(Target(:,1));

Lx = [];
for i=1:n;
    Lxi = FuncLx(xy(i,1),xy(i,2),Z);
    Lx = [Lx;Lxi];
end

%%
e2 = Obsxy-xy;
e = reshape(e2',[],1);
de = -e*l;

%%
Lx2 = inv(Lx'*Lx)*Lx';
Vc = -l*Lx2*e