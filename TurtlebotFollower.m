classdef TurtlebotFollower < handle
    %TURTLEBOTFOLLOWER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        IPAddress           % IP address of the ROS HOST - Saved for possible future use
        velPub              % Velocity Publisher
        velMsg              % Velocity Publisher Message
    end
    
    methods
        % Setup the ROS environment, subscribers, and publishers within the
        % constructor
        function object = TurtlebotFollower(IPInput)
            rosinit(IPInput,11311)
            [object.velPub, object.velMsg] = rospublisher("/cmd_vel", "geometry_msgs/Twist", "DataFormat", "struct");
            object.IPAddress = IPInput;
        end
        
        % Get the command velocity
        function velMsg = getVelocity(object)
            velMsg = object.velMsg;
        end

        % Set the command velocity
        function [ ] = setVelocity(object, input1, input2)
            object.velMsg.Linear.X = input1;
            object.velMsg.Angular.Z = input2;
        end

        % Publish the command velocity
        function [ ] = pubVelocity(object)
            send(object.velPub,object.velMsg);
        end
    end
end

