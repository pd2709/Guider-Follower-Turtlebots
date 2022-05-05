classdef robot < handle
    % `handle` is important so you can see values inside properties
    % `robot.m` is the name of the file
    % should match the file name

    properties(Access = public)
        odom_msg % storing the subscriber handle
        odom_sub % storing the message handle
        vel_pub % storing the publisher handle
        vel_msg % storing the message handle
    end
    
    methods(Access = public)
        function obj = robot()
            % CONSTRUCTOR
            % Codes in this function is run once at the begining
            % `robot.m` is the name of the file
            % name of constructor should match the file name

            %% pub init
            disp('publish init 2 s');
            obj.vel_pub = rospublisher('/cmd_vel','geometry_msgs/Twist');
            pause(2); % Wait to ensure publisher is registered
            obj.vel_msg = rosmessage(obj.vel_pub); % pub message

            %% sub init
            disp('subscribe init 4 s');
            obj.odom_msg = rosmessage('nav_msgs/Odometry');
            pause(2); % Wait to ensure subscriber is registered
            obj.odom_sub = rossubscriber('/odom',@obj.odom_cb);
            % obj.odom_cb is a callback function
            % it will run in parallel with the main program
            % function will be called everytime there is a new incoming message
 
            disp('init done');
        end
        
        function ret=get_odom_x_y_yaw(obj)
            R_x = obj.odom_msg.Pose.Pose.Position.X;
            R_y = obj.odom_msg.Pose.Pose.Position.Y;
            quat = [obj.odom_msg.Pose.Pose.Orientation.X ...
                obj.odom_msg.Pose.Pose.Orientation.Y ...
                obj.odom_msg.Pose.Pose.Orientation.Z ...
                obj.odom_msg.Pose.Pose.Orientation.W];
            rpy = quat2eul(quat);
            R_yaw = rpy(3);
            R_x_dot = obj.odom_msg.Twist.Twist.Linear.X;
            R_y_dot = obj.odom_msg.Twist.Twist.Linear.X;
            R_yaw_dot = obj.odom_msg.Twist.Twist.Angular.Z;
            ret = [R_x, R_y, R_yaw, R_x_dot, R_y_dot, R_yaw_dot];
        end

        function obj=pub_vel_cmd(obj, v_R, w_R)
            %publishing values to /cmd_vel
            obj.vel_msg.Linear.X = v_R;
            obj.vel_msg.Angular.Z = w_R;
            send(obj.vel_pub,obj.vel_msg);
            % send() is to publish the message
            % what we send is the message
            % using ROS message format
            % this case we send vel_msg
            % it has been formated accordingly
        end
    end
    
    methods(Access = private)
        function obj = odom_cb(obj,~, message)
            obj.odom_msg = message;
        end
    end
end