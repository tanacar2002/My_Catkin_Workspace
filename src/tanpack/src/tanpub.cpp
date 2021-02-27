#include "ros/ros.h"
#include "tanpack/tanmsg.h"
#include <iostream>
#define Log(x) std::cout << x << std::endl

int main(int argc,char** argv)
{
    ros::init(argc,argv,"tanpub");
    ros::NodeHandle n;

    ros::Publisher pub = n.advertise<tanpack::tanmsg>("tantopic",1000);
    ros::Rate freq(1);

    tanpack::tanmsg msg;
    msg.x = 1.0F;
    msg.y = 2.0F;
    msg.z = 2.0F;
    
    Log("Initialized!");

    while(ros::ok()){
        ROS_INFO("Just sent the values:%f,%f,%f", msg.x,msg.y,msg.z);

        pub.publish(msg);

        ros::spinOnce();
        freq.sleep();
    }
}