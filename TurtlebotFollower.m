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
            rosinit(IPInput,11311)
            [object.velPub, object.velMsg] = rospublisher("/cmd_vel", "geometry_msgs/Twist", "DataFormat", "struct");
            object.imgSub = rossubscriber("/camera/rgb/image_raw","sensor_msgs/Image","DataFormat","struct");
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
        function [ ] = udpateObsDepth(object)
            object.updateDepth();
            object.obsDepth = rosReadImage(object.depthMsg);
        end

        function [ ] = updateCmdVel(object)
            img = object.obsImg
            depth = object.obsDepth

            % VISUAL SERVOING CODE %

            cmdVel = ;

            object.updateCmdVel(cmdVel);
        end

        
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


    end
end

