Setup the subscribers within the TurtlebotFollower class to access camera infomation
Find the focal length and principle point of the camera we're using
	~~Print the checker board~~
	~~Take pictures~~
	~~Run the calibration exercise to find focal length and principle point~~
For the Target point
	Take a photo of the marker in the desired spot in front of the follower turtlebot, use this to find the x,y coordinates of where we want the marker to land on the image
Figure out how to convert image processing outputs into Observed points


Possible change of marker to a large white screen with a single dot. This will result in all the Harris features being concentrated in a single point on the image. Use the points being on the left to drive left, use the points being on the right to drive right, use the depth sensor to tell how far away from the marker we are.
	Use in conjunction with x,y coordinate driving (what Sam is exploring now 3/5/22)
