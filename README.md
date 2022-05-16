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
- getPointsWhite: Function that filters the current obsImg and finds the xy (pixel) centroid coordinates of the largest white object. Currently used in the main.m implementation
- getPointsGreen: Function that filters the current obsImg and finds the xy (pixel) centroid coordinates of the 4 largest green objects. Intended to be used with the 4 green dot marker. Currently not used in the main.m implementation
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


