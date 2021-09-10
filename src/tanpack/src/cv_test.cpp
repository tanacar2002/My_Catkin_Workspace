#include <ros/ros.h>
#include "move/Handler.hpp"
#include <vector>
#include "vector3/vector3.hpp"
#include <cmath>

#include "move/Mesafe.h"

#define HEIGHT 10.0
#define MOVEMENT_DELAY 0.1

auto Vector3::getPos() const
{
    position pos = {this->x,this->y,this->z,false};
    return pos;
}

std::vector<Vector3> interpolpath(std::vector<Vector3>& points,int iter)
{
    std::vector<Vector3> res;
    res.reserve((points.size()-1)*iter);
    for(int i = 1;i < points.size();i++)
    {
        Vector3 step = (points[i]-points[i-1])/iter;
        for(int j = 0;j < iter;j++)
        {
            res.emplace_back(points[i-1]+step*j);
        }
    }
    res.emplace_back(points[points.size()-1]);
    return res;
}





int main(int argc,char** argv)
{
    std::vector<Vector3> vertices;
    vertices.emplace_back(0.0,0.0,HEIGHT);
    vertices.emplace_back(20.0,0.0,HEIGHT);

    bool isObjFound = false;

    ros::init(argc,argv,"cv_test");
    ros::Time::init();
    ros::NodeHandle n;
    ros::Rate rate(0.2);
    
    Drone drone = Drone(n);

    ROS_INFO("Arming and waiting...");
    drone.arm();
    ros::Duration(5.0).sleep();
    ROS_INFO("Taking off and waiting...");
    drone.takeoff(HEIGHT);
    ros::Duration(20.0).sleep();

    for(Vector3& vertex : interpolpath(vertices,50))
    {
        drone.moveGlobal(vertex.getPos());
        ros::Duration(MOVEMENT_DELAY).sleep();
        double object_x,object_y,object_x2,object_y2;
        if(drone.wherePool(object_x,object_y,object_x2,object_y2)){
            ROS_INFO("Object detected");
            drone.moveRelative({object_x,object_y,HEIGHT,false});
            while(sqrt(object_x*object_x+object_y*object_y) > 0.5){
                drone.wherePool(object_x,object_y,object_x2,object_y2);
            }
            drone.moveRelative({object_x2,object_y2,HEIGHT,false});
            while(sqrt(object_x2*object_x2+object_y2*object_y2) > 0.3){
                drone.wherePool(object_x,object_y,object_x2,object_y2);
            }
            ros::Duration(2.0).sleep();
            break;
        }
    }


    drone.land();
}