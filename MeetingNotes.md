Setup the subscribers within the TurtlebotFollower class to access camera infomation
Find the focal length and principle point of the camera we're using:
	- ~~Print the checker board~~
	- ~~Take pictures~~
	- ~~Run the calibration exercise to find focal length and principle point~~
	
For the Target point
	Take a photo of the marker in the desired spot in front of the follower turtlebot, use this to find the x,y coordinates of where we want the marker to land on the image
Figure out how to convert image processing outputs into Observed points


Possible change of marker to a large white screen with a single dot. This will result in all the Harris features being concentrated in a single point on the image. Use the points being on the left to drive left, use the points being on the right to drive right, use the depth sensor to tell how far away from the marker we are.
	Use in conjunction with x,y coordinate driving (what Sam is exploring now 3/5/22)
	
10 May 2022
To Do List:
	- Code
		- Make the command velocity sensible values, if outside of the usable range then it clips.
		- Clean up the code after copy pasting
		- Functionality
			- Choppy movement, this is probably a result of bad visual servoing code
			- Visual servoing code doesn't reliably find the 4 points
		- Todo
			- Description of code (structure, readme)
			- Individual contribution
	- Video
		- "Demonstrate what has been achieved in the project, with a readme document"
			- Quick description of our code, how we recieve images and publish velocity
			- Images of point recognition
			- Calculation of velocity
			- Show an idealised loop of code
				- collect a good image of the points at a distance
				- calculate sensible velocities
				- Publish that velocity
		- readme document
			- short description of the video
			- Individual contributions on the video
		- Record a powerpoint presentation and voiceover				
	- Class Presentation
		- Similar content to the video
		- Flowcharts of logic
		- Camera calibration
		- Images of point recognition
			- SURF
			- Harris detection
			- Current implementation - green dot
		- Implementation of visual servoing to find command velocities
			- command velocities found in 6DOF, but turtlebot is only 2DOF
		- If we get simplified control working, then show the methodology behind both the simplified control and visual servoing control
	- Final Report
		- "Proper documetation (including necessary flowcharts) of the project and a written report"
		- How the code works and how to operate it
		- Progress
		- Current functionality
		
		
