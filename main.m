function [] = main(IPAddress)
    Turtle = TurtlebotFollower(IPAddress);
    Turtle.setVelocity(0,0)
    r = rosrate(2);

    receive(Turtle.imgSub); % Wait to receive an image message before starting the loop
    receive(Turtle.depthSub);

    while(1) % for i = 1:20
        Turtle.updateObsImg;
        Turtle.updateObsDepth;
        xy = Turtle.getPoints;
        Vc = Turtle.visualservoing(xy);
        Turtle.setVelocity(Vc(1)/10,Vc(6));  
        %Turtle.setVelocity(0.0, Vc(6));
        Turtle.pubVelocity;
        waitfor(r);
    end
end

