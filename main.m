function [] = main(IPAddress)
    Turtle = TurtlebotFollower(IPAddress);
    Turtle.setVelocity(0,0)
    r = rosrate(2);

    receive(Turtle.imgSub); % Wait to receive an image message before starting the loop
    receive(Turtle.depthSub);

    while(1) % for i = 1:20
        Turtle.updateObsRGB;
        Turtle.updateObsDepth;

        % function to get points from observed rbg image collected
            %ToDo: Pooja's feature Extraction is able to provide the
            %coordinates of the 4 points from each image
        

         % depth from observed depth image collected
             
        visualservoing(targetPoints,obsPoints,Z)
        
        
        Turtle.updateCmdVel;
        Turtle.pubVelocity;
        waitfor(r);
    end
end

