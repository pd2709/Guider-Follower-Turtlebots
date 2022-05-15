# Guider-Follower-Turtlebots using a 4-Dot Marker
SCMS-AUT2022
This project uses MATLAB and ROS to control a Turtlebot3 waffle. By using an RGB-D camera on the follower turtlebot the robot is able to track the white marker on the leader turtlebot and follow it while keeping a set distance away. Marker position within the image frame determines angular velocity, and the depth value on the marker position determines the linear velocity. Unused code includes the ability to find 4 green dots for use within the visualServoing function, this code resulted in choppy turtlebot motion and was ultimately replaced with the simpler white dot / depth sensor functionality.

This program is intended to be run on a remote computer using Turtlebot captured data due to the limited processing power of the Turtlebot SBC.

## Individual Contribution
The team has equally shared code implementation, debugging, and testing responsibilities. Actual code contributions listed below:
- Juan Hermosisima, 33%: Drive code, ROS implementation code, marker detection, overall functional testing
- Poojaben Darji, 33%: Marker detection, feature detection, drive code testing, overall functional testing
- Samantha Dalusag, 33%: Visual servoing code, drive code testing, overall functional testing

# Dependencies
<b> <i>Required Software: </i></b>
- Ubuntu 20.04
- MATLAB
- ROS Noetic

<b> <i>MATLAB Add-ons: </i></b>
- ROS Toolbox
- Image Processing Toolbox

<b> <i>Additional Dependencies: </i></b>
For additional ROS and Turtlebot3 dependiencies, follow the steps listed in the [Turtlebot3 Quick Start Guide](https://emanual.robotis.com/docs/en/platform/turtlebot3/quick-start/) and [Turtlebot3 RealSense Guide](https://emanual.robotis.com/docs/en/platform/turtlebot3/appendix_realsense/).

# Intended Functionality and Program Operation
1. Place a large white marker in front of the target turtlebot
2. ssh into the Turtlebot3 SBC and run the Turtlebot Bringup package. Follow steps detailed in the [Turtlebot3 Quick Start Bringup Guide](https://emanual.robotis.com/docs/en/platform/turtlebot3/bringup/#bringup).
3. ssh into the Turtlebot3 SBC on a seperate terminal and run the Realsense Default Nodelet by following step 13.1.10.2 on the [Turtlebot3 RealSense Guide](https://emanual.robotis.com/docs/en/platform/turtlebot3/appendix_realsense/)
4. On a separate terminal on the remote PC, open MATLAB and run the 'main' function giving the remote PC IP address as an input (string format)
5. The turtlebot will begin following the white marker

# Structure of the Code
The code functinoality is split in two sections:
- TurtlebotFollower.m: A controller object capable of reading Turtlebot published RGB and Depth images, processing those images, and writing command velocities that will be followed by connected Turtlebots
- main.m: A function that takes the ROS Master IP address and enables the Turtlebot following/driving functionality

## main.m - Logic
The main function creates an instance of the TurtlebotFollower class, and waits for images to be recieved before beginning the main loop. The main loop follows the below logic:
1. Update RGB and Depth images captured by the Turtlebot RealSense camera
2. Calculate the centroid of the white marker within the RGB image
3. Calculate the angular velocity as a percentage of the max angular speed. Percentage is determined by the centroid distance from centre divided by the maximum possible distance from centre.
4. Read the depth image at the location of the marker centroid (taking into account the difference of resolution between the RGB and depth images)
5. Calculate the linear velocity as a percentage of the max linear speed. Percentage is determined by the error between the depth and goal depth, divided by the goal depth
6. Publish both linear and angular velocities

## TurtlebotFollower.m - Properties and Methods
### Properties (Constant) - Static properties that do not need changing
- CAMERA_CC: RealSense Camera principle point
- IMAGE_SIZE: Resolution of the RealSense RGB camera
- MAX_SPEED: Maximum linear and angular speed of the Turtlebot

### Properties
- IPAddress: IP Address of the ROS HOST
- velPub, ROS publisher: ROS Publisher of the cmd_vel topic
- velMsg, velocity message: Message that gets sent by the velPub publisher
- imgSub, ROS subscriber: ROS Subscriber of the camera/rgb/image_raw/compressed topic
- imgMsg, image message: Variable that stores the message recieved by the imgSub subscriber
- depthSub, ROS subscriber: ROS Subscriber of the camera/depth/image_raw topic
- depthMsg, image message: Variable that stores the message recieved by the depthSub subscriber
- obsImg, RGB image: The RGB image obtained by the RGB camera, pulled from the imgMsg variable
- obsDepth, GS image: The depth image obatined by the depth camera, pulled from the depthMsg variable

### Methods
- TurtlebotFollower(IPInput): Constructor of the TurtlebotFollower class. Input is used to set the ROS Host IP address, taken as a string input. This constructor sets up the MATLAB/ROS environment (after first shutting down any existing MATLAB ROS node), sets up publishers and subscribers, and sets the initial Turtlebot velocity to 0
- stopVelocity: Sets the velMsg to stop the Turtlebot and publishes the message immediately
- getPoints: Function that filters the current obsImg and finds the xy (pixel) centroid coordinates of the largest white object
- visualServoing: given 4 observed points, finds the 6DOF velocity vector to obtain the hardcoded goal points. Not used within the current (submitted) project implementation.
- getVelocity: Getter for the internally stored velMsg
- setVelocity: Setter for the internally stored velMsg. Checks the values of the linear and angular velocities, if both are near 0 then the function sets both velocities at 0
- pubVelocity: Function that broadcasts the currently stored velMsg to the cmd_vel topic
- getRGB: Getter for the internally stored imgMsg
- updateRGB: Function that updates the currently stored imgMsg with the latest message from the camera/rgb/image_raw/compressed topic
- getDepth: Getter for the internally stored depthMsg
- updateDepth: Function that updates the currently stored depthMsg with the latest message from the camera/depth/image_raw topic
- updateObsImg: Function that updates the currently stored obsImg with the data from the stored imgMsg
- updateDepthImg: Function that updates the currently stored depthImg with the data from the stored depthMsg


🙂 Start each day off right

Begin every day by pulling or fetching from the master to your local master.

  -> Pulling will automatically try to merge the recent commits from master and throw errors if there are any conflicts

  -> Fetching will gather the most recent commits in a branch which you can then view and decide to merge or not

  -> Once you have all the most recent updates on your master you can then merge those changes into your branch:

    git checkout <branch you want to update>

    git merge <branch name you’re merging from>

You may have to handle merge conflicts at this point. Note that files with merge conflicts are usually a different color in the sidebar.

Create a new branch

    git checkout -b <new branch name>

  This branch will start off with a copy of the branch you were on.


👮Clone the New Repository to your Local Machine(s)

  Note: Each team member will need to perform this step.

  On GitHub, navigate to the project repo:

   Press the green Clone or download button.
   Ensure that clone with HTTPS is selected. (If you setup GitHub to use SSH key and passphrase, you may select that option, but these instructions assume you are using HTTPS.)
   Copy the URL provided.

In your local terminal, from the top level folder under which you want to place your repo:

    $ git clone paste-copied-url-here

🆕 Create a new branch for each new feature

From this point, each member of the group will create a new branch for any feature they are adding to the project. Do this by entering either of these two options:

    git checkout -b branchName – This creates the branch and checks it out

or

    git checkout branchName – This checks out the branch

Be sure to always check which branch you are on using “git status” before you begin working!

☁️ Merge your branch

Once your branch is ready to be merged to master, follow these steps.

   While in your branch you will 

    git add . 

    git commit -m “message”

    git push origin <branch name> – This creates the branch remotely and pushes to that branch on GitHub

  Go to GitHub and create a new pull request

   You can compare your branch to any other branch, but you will most likely be comparing to master
   You can assign a specific person or not
   You will not be able to approve your own pull request 

   Once someone reviews the pull request. they will resolve any issues or conflicts that come up and approve the pull request to be merged into the master


for more: 
https://www.digitalcrafts.com/blog/learn-how-start-new-group-project-github (please ready this carfully)
https://medium.com/anne-kerrs-blog/using-git-and-github-for-team-collaboration-e761e7c00281 (its an important reading!)
