#!/usr/bin/env python
import rospy
from geometry_msgs.msg import Twist
import tf2_ros
from ceng460hw1.srv import *
from ceng460hw1_utils import *
import numpy as np
from tf2_msgs.msg import TFMessage

class Mat:
    shape = (0,0)
    cont = []
    def __init__(self,shape):
        self.shape = shape
        for i in range(shape[0]):
            temp = []
            for j in range(shape[1]):
                temp.append(None)
            self.cont.append(temp)

    def __getitem__(self,idx):
        return self.cont[idx[0]][idx[1]]

    def __setitem__(self,idx,value):
        self.cont[idx[0]][idx[1]] = value

    def __str__(self):
        return self.cont.__str__()

def look(mat,col):
    for i in range(mat.shape[0]):
        if hasattr(mat[i,col],"shape"):
            if i == 0:
                return mat[i,col]
            matrix = look(mat,i)
            if hasattr(matrix,"shape"):
                return np.matmul(matrix,mat[i,col])
    return None


class Robot:

    def __init__(self):
        rospy.init_node('robot')
        self.tfBuffer = tf2_ros.Buffer()
        self.listener = tf2_ros.TransformListener(self.tfBuffer)
        self.pub = rospy.Publisher('cmd_vel',Twist,queue_size=10)
        self.zeroTime = rospy.Time()
    
    def send_diff_drive_vel_msg(self, linear, angular):
        msg = Twist()
        msg.linear.x = linear
        msg.angular.z = angular
        self.pub.publish(msg)
    
    def get_global_transformStamped(self):
        try:
            trans = self.tfBuffer.lookup_transform("odom", "base_footprint", self.zeroTime)
            return trans
        except (tf2_ros.LookupException, tf2_ros.ConnectivityException, tf2_ros.ExtrapolationException):
            return None

    def move_to(self, x_goal, y_goal, P_vel, P_angular, rate=20, tolerance=0.02):
        rate = rospy.Rate(rate)

        tf_transform = self.get_global_transformStamped()
        transMatrix = TransformStamped_to_transform_matrix(tf_transform)

        alpha = np.arctan2(transMatrix[1,0],transMatrix[0,0])
        diff = np.array([x_goal,y_goal])-np.transpose(transMatrix[:2,3])
        a_goal = np.arctan2(diff[1],diff[0])

        ang_err = (a_goal - alpha)
        if ang_err < -np.pi:
            ang_err += 2*np.pi
        elif ang_err > np.pi:
            ang_err -= 2*np.pi
        
        diff_mag = np.sqrt(diff.dot(diff))

        while diff_mag > tolerance:
            self.send_diff_drive_vel_msg(min(1,P_vel*diff_mag),min(1,P_angular*ang_err))
            tf_transform = self.get_global_transformStamped()
            transMatrix = TransformStamped_to_transform_matrix(tf_transform)
            alpha = np.arctan2(transMatrix[1,0],transMatrix[0,0])
            diff = np.array([x_goal,y_goal])-np.transpose(transMatrix[:2,3])
            diff_mag = np.sqrt(diff.dot(diff))
            a_goal = np.arctan2(diff[1],diff[0])
            ang_err = (a_goal - alpha)
            if ang_err < -np.pi:
                ang_err += 2*np.pi
            elif ang_err > np.pi:
                ang_err -= 2*np.pi
            rate.sleep()
        self.send_diff_drive_vel_msg(0,0)
    
    def rotate_to(self, x_goal, y_goal, P_angular, rate=20, tolerance=0.02):
        rate = rospy.Rate(rate)
        tf_transform = self.get_global_transformStamped()
        transMatrix = TransformStamped_to_transform_matrix(tf_transform)
        alpha = np.arctan2(transMatrix[1,0],transMatrix[0,0])
        diff = np.array([x_goal,y_goal])-np.transpose(transMatrix[:2,3])
        a_goal = np.arctan2(diff[1],diff[0])
        err = (a_goal - alpha)
        if err < -np.pi:
            err += 2*np.pi
        elif err > np.pi:
            err -= 2*np.pi
        while abs(err) > tolerance:
            self.send_diff_drive_vel_msg(0,P_angular*err)
            tf_transform = self.get_global_transformStamped()
            transMatrix = TransformStamped_to_transform_matrix(tf_transform)
            alpha = np.arctan2(transMatrix[1,0],transMatrix[0,0])
            err = (a_goal - alpha)
            if err < -np.pi:
                err += 2*np.pi
            elif err > np.pi:
                err -= 2*np.pi
            rate.sleep()
        self.send_diff_drive_vel_msg(0,0)
    
    def main(self):
        rospy.wait_for_message('tf', TFMessage)
        rospy.wait_for_service('spot_announcement')
        announce_spot = rospy.ServiceProxy('spot_announcement', SpotAnnouncement)

        rospy.sleep(3)
        rospy.loginfo("Starting!")

        first_announcement = SpotAnnouncementRequest()
        first_announcement.spot.child_frame_id = "0"
        resp = announce_spot(first_announcement)
        if not resp.success:
            rospy.logerr('something is wrong!')
            exit()

        nodes = {}
        checklist = {}

        matrix = Mat((15,15))

        done = False
        while not done:
            for clue in resp.clues:
                matrix[int(clue.header.frame_id),int(clue.child_frame_id)] = TransformStamped_to_transform_matrix(clue)
                if not clue.child_frame_id in checklist:
                    checklist.update({clue.child_frame_id:False})
            nodesLeft = list(filter(lambda key:not checklist[key],checklist))
            nodesLeft.sort()
            for node in nodesLeft:
                transmat = look(matrix,int(node))
                if hasattr(transmat,"shape"):
                    checklist[node] = True
                    announcement = SpotAnnouncementRequest()
                    announcement.spot = transform_matrix_to_TransformStamped(transmat,"0","{}".format(node))
                    break
            
            self.rotate_to(transmat[0,3],transmat[1,3],1.5)
            self.move_to(transmat[0,3],transmat[1,3],0.6,1.5)

            resp = announce_spot(announcement)

            done = not nodesLeft

        rospy.loginfo("Exiting Loop!")

if __name__ == "__main__":
    try:
        robot = Robot()
        robot.main()
    except rospy.ROSInterruptException:
        pass