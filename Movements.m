%% Turtlebot movement

% launch gazebo simulator and rViz!
clear all
clc
rosshutdown
rosinit

% get rgb and depth from ROS
rgb = rossubscriber('/camera/rgb/image_raw');
depth = rossubscriber ('/camera/depth/image_raw');



% move Turtlebot forward for 1 metre
velocity = 0.1;     % meters per second
robotCmd = rospublisher("/cmd_vel","DataFormat","struct") ;
velMsg = rosmessage(robotCmd);
velMsg.Linear.X = velocity;
send(robotCmd,velMsg)
pause(10)
velMsg.Linear.X = 0;
send(robotCmd,velMsg)


% get pose of Turtlebot
odom = rossubscriber('/odom');
msgOdo = receive(odom);
xposition = msgOdo.Pose.Pose.Orientation.X;
yposition = msgOdo.Pose.Pose.Orientation.Y;
zposition = msgOdo.Pose.Pose.Orientation.Z;

%rostopic type /cmd_vel
%rostopic info /cmd_vel