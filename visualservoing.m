function [Vc] = visualservoing(targetPoints,obsPoints,fakeZ)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% comment out this section when actually getting real values from the main
% targetPoints = [  213,240;
%                                 213,96;
%                                 426,240;
%                                 426,96];
% obsPoints = targetPoints;
% obsPoints(:,2) = targetPoints(:,2) - 50;
%                                     
% %             obsPoints = [163,    290; %make these to the left of target and down abit
% %                             163,    146;
% %                             376,    290;
% %                             376 ,   146];
% 
%          %depth from observed depth image collected
%              % use fake z value for now
%              fakeZ = 50;

%%
% Control (values from Pooja's calibration)
f = [ 630.135394139079153 ; 631.076416145119879 ];
p = [ 307.901145498176732 ; 250.956660551046383 ];
% z = 50; %???
Z = fakeZ;
l = 0.1; %lambda %???

xy(:,1) = (targetPoints(:,1)-p(1))/f(1);
xy(:,2) = (targetPoints(:,2)-p(2))/f(2);

Obsxy(:,1) = (obsPoints(:,1)-p(1))/f(1);
Obsxy(:,2) = (obsPoints(:,2)-p(2))/f(2);

n = length(targetPoints(:,1));

Lx = [];
for i=1:n;
    Lxi = FuncLx(xy(i,1),xy(i,2),Z);
    Lx = [Lx;Lxi];
end

e2 = Obsxy-xy;
e = reshape(e2',[],1);
de = -e*l;

Lx2 = inv(Lx'*Lx)*Lx';
Vc = -l*Lx2*e


end

