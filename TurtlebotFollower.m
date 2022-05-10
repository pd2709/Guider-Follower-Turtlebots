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
            if ((abs(input1) < 0.005) && (abs(input2) < 0.005))
                object.velMsg.Linear.X = 0.0;
                object.velMsg.Angular.Z = 0.0;
            else
                object.velMsg.Linear.X = input1;
                object.velMsg.Angular.Z = input2;
            end
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

        % This function will only work if object.obsImg is updated from
        % object.updateObsImg function beforehand
        function [xy] = getPoints(object)
            % Extract channels channels so we can apply a mask
            redChannel = Turtle.obsImg(:, :, 1);
            greenChannel = Turtle.obsImg(:, :, 2);
            blueChannel = Turtle.obsImg(:, :, 3);

            % Threshold to find the blobs
            redMask = redChannel < 128;
            greenMask = greenChannel > 90;
            blueMask = blueChannel < 128;
            mask = redMask + greenMask + blueMask;
            mask = mask > 2;
            % Extract only the 4 largest blobs.
            mask = bwareafilt(mask, 4);
            % Find centroids.
            props = regionprops(mask, 'Centroid');
            % Extract centroids from structure into a double array.
            xy = vertcat(props.Centroid);
        end
        
        function [Vc] = visualservoing(obsPoints)
            %UNTITLED Summary of this function goes here
            %   Detailed explanation goes here
            
            % Hard coded target points from the target.jpg image
            targetPoints = [    213,240;
                                213,96;
                                426,240;
                                426,96];
            
            %%
            % Control (values from Pooja's calibration)
            f = [ 630.135394139079153 ; 631.076416145119879 ];
            p = [ 307.901145498176732 ; 250.956660551046383 ];
            Z = 50;
            l = 0.1;
            
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


    end
end

