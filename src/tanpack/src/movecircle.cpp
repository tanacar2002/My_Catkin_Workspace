#include <ros/ros.h>
#include "move/Handler.hpp"
#include <vector>
#include "vector3/vector3.hpp"
#include <cmath>

#define MOVEMENT_DELAY 1.0 //0.5

#define HEIGHT 10.0f
#define RADIUS 5

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
    const int polyind = 20;
    vertices.reserve(polyind+3);
    vertices.emplace_back(0.0f,0.0f,HEIGHT);
    for(int i = 0;i <= polyind; i++)
    {
        vertices.emplace_back(RADIUS*cos(2*i*M_PI/polyind),RADIUS*sin(2*i*M_PI/polyind),HEIGHT);
    }
    vertices.emplace_back(0.0f,0.0f,HEIGHT);

    ros::init(argc,argv,"tanpub");
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

    ROS_INFO("Drawing a circle!");
    drone.moveGlobal(vertices[0].getPos());
    ros::Duration(5.0).sleep();
    for(Vector3& vertex : interpolpath(vertices,2))
    {
        drone.moveGlobal(vertex.getPos());
        ros::Duration(MOVEMENT_DELAY).sleep();
    }

    ros::Duration(5.0).sleep();
    ROS_INFO("Landing");
    if(!drone.land())drone.moveGlobal({0.0f,0.0f,0.0f,false});
}