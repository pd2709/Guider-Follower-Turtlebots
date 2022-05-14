function [] = main(IPAddress)
    Turtle = TurtlebotFollower(IPAddress);
    Turtle.setVelocity(0,0)
    r = rosrate(2);

    receive(Turtle.imgSub); % Wait to receive an image message before starting the loop
    receive(Turtle.depthSub);

    while(1) % for i = 1:20

        % Obtain image and depth sensor data
        Turtle.updateObsImg;
        Turtle.updateObsDepth;

        % Calculate the angular velocity
        xy = Turtle.getPoints;  % Get the marker positions within the camera frame
        location2 = xy(1,1) - Turtle.CAMERA_CC(1);
        angularVelocity = 0.2 * -Turtle.MAX_SPEED(2) * location2/(Turtle.IMAGE_SIZE(1)/2)

        % old visual servoing implementation - Control isn't smooth so
        % switching out to left/right
        Turtle.setVelocity(0.0, angularVelocity);         %Turtle.setVelocity(Vc(1)/10,Vc(6));  
        Turtle.pubVelocity;
        waitfor(r);
    end
end

