function [] = main(IPAddress)
    Turtle = TurtlebotFollower(IPAddress);
    Turtle.setVelocity(0.2,0.1)
    r = rosrate(10);
    while(1)
        Turtle.pubVelocity;
        waitfor(r);
    end
end

