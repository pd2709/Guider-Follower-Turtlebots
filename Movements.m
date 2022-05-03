%% Turtlebot movement

% launch gazebo simulator and rViz!
clear all
clc
rosshutdown
rosinit

%tbot = turtlebot('192.168.0.22');

% get rgb and depth from ROS (look at this stuff later)
rgb = rossubscriber('/camera/rgb/image_raw');
depth = rossubscriber ('/camera/depth/image_raw');




% move Turtlebot forward for 1 metre
linearvelocity = 0.1;     % meters per second
robotCmd = rospublisher("/cmd_vel","DataFormat","struct") ;
velMsg = rosmessage(robotCmd);
velMsg.Linear.X = linearvelocity;
send(robotCmd,velMsg)
pause(10)
velMsg.Linear.X = 0;
send(robotCmd,velMsg)

%view type of message published by the velocity topic:
rostopic type /cmd_vel

%The following command lists the publishers and subscribers for the velocity topic
rostopic info /cmd_vel

% get pose of Turtlebot
% Create a subscriber for the odometry messages
odomSub = rossubscriber('/odom','DataFormat','struct');
odomMsg = receive(odomSub,3);
pose = odomMsg.Pose.Pose;
%position
x = pose.Position.X;
y = pose.Position.Y;
z = pose.Position.Z;
turtlebot_position = [x y z];
%orientation
quat = pose.Orientation;
angles = quat2eul([quat.W quat.X quat.Y quat.Z]);
theta = rad2deg(angles(1))


%move turtlebot to a target point (maybe use Twist) http://wiki.ros.org/turtlesim/Tutorials/Go%20to%20Goal
% create a while loop which has while turtlbot pose does not equal target
% p

target_pose_x = 4;
target_pose_y = 2;





%rostopic type /cmd_vel
%rostopic info /cmd_vel