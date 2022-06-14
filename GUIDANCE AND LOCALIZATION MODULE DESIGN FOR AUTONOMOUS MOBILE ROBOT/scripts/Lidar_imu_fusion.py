#! /usr/bin/env python

import rospy
from sensor_msgs.msg import LaserScan
import sensor_msgs.msg
import numpy as np
from std_msgs.msg import Float64 
teta=0

#pub = rospy.Publisher('/revised_scan', LaserScan, queue_size = 10)

def callback2(msg2):
	global teta
	x = msg2.data
	teta = np.float64(x)
	#print(x,teta)





def callback(msg):
    global teta
    scann = LaserScan()
    #print(len(msg.ranges)) len is 2019 from 0-360
    current_time = rospy.Time.now()
    scann.header.stamp = msg.header.stamp
    scann.header.frame_id = msg.header.frame_id
    scann.angle_min = msg.angle_min
    scann.angle_max = msg.angle_max
    scann.angle_increment = msg.angle_increment
    scann.time_increment = msg.time_increment
    scann.range_min = msg.range_min
    scann.range_max = msg.range_max
    scann.ranges = msg.ranges
    scann.intensities = np.float64(msg.intensities)*np.cos(teta*3.14159/180)
    #print(scann.intensities)
#scann.intensities = msg.intensities*np.cos(10*3.14159/180)
    print(len(msg.intensities))
    pub = rospy.Publisher('/revised_scan',LaserScan, queue_size=10)
    rate=rospy.Rate(10)
    pub.publish(scann)



if __name__ == '__main__':
    rospy.init_node('revised_scan', anonymous=True)
    sub = rospy.Subscriber('/scan', LaserScan, callback)
    sub2 = rospy.Subscriber('/rpy', Float64, callback2)
    rospy.spin()
