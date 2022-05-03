function [] = main(IPAddress)
    Turtle = TurtlebotFollower(IPAddress);
    Turtle.setVelocity(0,0)
    r = rosrate(10);
    for i = 1:20
        Turtle.pubVelocity;
        waitfor(r);
    end
end

