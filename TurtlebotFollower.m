classdef TurtlebotFollower < handle
    %TURTLEBOTFOLLOWER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        IPAddress           % IP address of the ROS HOST - Saved for possible future use
        velPub              % Velocity Publisher
        velMsg              % Velocity Publisher Message
        imgSub              % Image Subscriber
        imgMsg              % Saved rbg image message
        depthSub            % Depth Subscriber
        depthMsg            % Saved depth image message

        obsImg              % Saved rgb image, converted from ROS message to imread style image
        obsDepth            % Saved depth image, converted from ROS message to imread style image
    end
    
    methods
        % Setup the ROS environment, subscribers, and publishers within the
        % constructor
        function object = TurtlebotFollower(IPInput)
            rosshutdown
            rosinit(IPInput,11311)
            [object.velPub, object.velMsg] = rospublisher("/cmd_vel", "geometry_msgs/Twist", "DataFormat", "struct");
            object.imgSub = rossubscriber("/camera/color/image_raw/compressed","sensor_msgs/CompressedImage","DataFormat","struct");
            object.depthSub = rossubscriber("camera/depth/image_raw","sensor_msgs/Image","DataFormat","struct");
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

        % Get the rgb image message
        function rgb = getRGB(object)
            rgb = object.imgMsg;
        end

        % Function to update the rgb image
        function [ ] = updateRGB(object)
            object.imgMsg = object.imgSub.LatestMessage;
        end

        % Get the depth image message
        function depth = getDepth(object)
            depth = object.depthMsg;
        end

        % Function to update the depth image
        function [ ] = updateDepth(object)
            object.depthMsg = object.depthSub.LatestMessage;
        end

        % Update usable rgb image
        function [ ] = updateObsImg(object)
            object.updateRGB();
            object.obsImg = rosReadImage(object.imgMsg);
        end

        % Update usable depth image
        function [ ] = updateObsDepth(object)
            object.updateDepth();
            object.obsDepth = rosReadImage(object.depthMsg);
        end

        function [ ] = updateCmdVel(object)
            img = object.obsImg;
            depth = object.obsDepth;

            % VISUAL SERVOING CODE %

            cmdVel = zeros(1,6);

            object.setVelocity(cmdVel(1),cmdVel(6));
        end
    end
end

