juan@juan-Inspiron-13-5368:~$ rostopic lists
rostopic is a command-line tool for printing information about ROS Topics.

Commands:
	rostopic bw	display bandwidth used by topic
	rostopic delay	display delay of topic from timestamp in header
	rostopic echo	print messages to screen
	rostopic find	find topics by type
	rostopic hz	display publishing rate of topic    
	rostopic info	print information about active topic
	rostopic list	list active topics
	rostopic pub	publish data to topic
	rostopic type	print topic or field type

Type rostopic <command> -h for more detailed usage, e.g. 'rostopic echo -h'

juan@juan-Inspiron-13-5368:~$ rostopic list
/camera/color/camera_info
/camera/color/image_raw
/camera/color/image_raw/compressed
/camera/color/image_raw/compressed/parameter_descriptions
/camera/color/image_raw/compressed/parameter_updates
/camera/color/image_raw/compressedDepth
/camera/color/image_raw/compressedDepth/parameter_descriptions
/camera/color/image_raw/compressedDepth/parameter_updates
/camera/color/image_raw/theora
/camera/color/image_raw/theora/parameter_descriptions
/camera/color/image_raw/theora/parameter_updates
/camera/depth/camera_info
/camera/depth/image_raw
/camera/depth/image_raw/compressed
/camera/depth/image_raw/compressed/parameter_descriptions
/camera/depth/image_raw/compressed/parameter_updates
/camera/depth/image_raw/compressedDepth
/camera/depth/image_raw/compressedDepth/parameter_descriptions
/camera/depth/image_raw/compressedDepth/parameter_updates
/camera/depth/image_raw/theora
/camera/depth/image_raw/theora/parameter_descriptions
/camera/depth/image_raw/theora/parameter_updates
/camera/depth/points
/camera/driver/parameter_descriptions
/camera/driver/parameter_updates
/camera/ir/camera_info
/camera/ir/image_raw
/camera/ir/image_raw/compressed
/camera/ir/image_raw/compressed/parameter_descriptions
/camera/ir/image_raw/compressed/parameter_updates
/camera/ir/image_raw/compressedDepth
/camera/ir/image_raw/compressedDepth/parameter_descriptions
/camera/ir/image_raw/compressedDepth/parameter_updates
/camera/ir/image_raw/theora
/camera/ir/image_raw/theora/parameter_descriptions
/camera/ir/image_raw/theora/parameter_updates
/camera/ir2/camera_info
/camera/ir2/image_raw
/camera/ir2/image_raw/compressed
/camera/ir2/image_raw/compressed/parameter_descriptions
/camera/ir2/image_raw/compressed/parameter_updates
/camera/ir2/image_raw/compressedDepth
/camera/ir2/image_raw/compressedDepth/parameter_descriptions
/camera/ir2/image_raw/compressedDepth/parameter_updates
/camera/ir2/image_raw/theora
/camera/ir2/image_raw/theora/parameter_descriptions
/camera/ir2/image_raw/theora/parameter_updates
/camera/nodelet_manager/bond
/rosout
/rosout_agg
/tf
/tf_static
juan@juan-Inspiron-13-5368:~$ rqt_image_view
^Cjuan@juan-Inspiron-13-5368:~$ rostopic info /camera/color/image_raw/compressed
Type: sensor_msgs/CompressedImage

Publishers: 
 * /camera/nodelet_manager (http://172.19.131.82:45287/)

Subscribers: None


juan@juan-Inspiron-13-5368:~$ rosmsg info sensor_msgs/CompressedImage
std_msgs/Header header
  uint32 seq
  time stamp
  string frame_id
string format
uint8[] data

