#include <ros/ros.h>
#include "move/Handler.hpp"
#include <vector>
#include "vector3/vector3.hpp"
#include <cmath>

#define MOVEMENT_DELAY 0.5
#define MOVEMENT_HEIGHT 10.0f

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

std::vector<Vector3> approxipolpath(std::vector<Vector3>& points,int npoints)
{
    std::vector<Vector3> res;
    res.reserve(npoints+1);
    float pathlength = 0.0f;
    for(int i = 1;i < points.size();i++)
    {
        pathlength += (points[i]-points[i-1]).getRlength();
    }
    float steplength = pathlength/(npoints+1);
    for(int i = 1;i < points.size();i++)
    {
        Vector3 vec = (points[i]-points[i-1]);
        int step = ceil(vec.getRlength()/steplength);
        for(int j = 0;j < step;j++)
        {
            res.emplace_back(points[i-1]+vec.getNormalized()*steplength*j);
        }
    }
    res.emplace_back(points[points.size()-1]);
    return res;
}

int main(int argc,char** argv)
{
    std::vector<Vector3> vertices;
    vertices.reserve(30);
    vertices.emplace_back(0.0f,0.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-20.0f,40.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-35.0f,50.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-50.0f,40.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-50.0f,0.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-65.0f,-10.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-75.0f,0.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-65.0f,10.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-50.0f,0.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-50.0f,-40.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-35.0f,-50.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-20.0f,-40.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-20.0f,0.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-20.0f,40.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-35.0f,50.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-50.0f,40.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-50.0f,0.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-65.0f,-10.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-75.0f,0.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-65.0f,10.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-50.0f,0.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-50.0f,-40.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-35.0f,-50.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(-20.0f,-40.0f,MOVEMENT_HEIGHT);
    vertices.emplace_back(0.0f,0.0f,MOVEMENT_HEIGHT);

    ros::init(argc,argv,"misyoner");
    ros::Time::init();
    ros::NodeHandle n;
    ros::Rate rate(0.2);
    
    Drone drone = Drone(n);

    ROS_INFO("Arming and waiting...");
    drone.arm();
    ros::Duration(5.0).sleep();

    ROS_INFO("Taking off and waiting...");
    drone.takeoff(MOVEMENT_HEIGHT);
    ros::Duration(5.0).sleep();

    ROS_INFO("Starting!");
    for(Vector3& vertex : approxipolpath(vertices,150))
    {
        drone.moveGlobal(vertex.getPos());
        ros::Duration(MOVEMENT_DELAY).sleep();
    }
    ROS_INFO("Finished!");
    ros::Duration(3.0).sleep();
    ROS_INFO("Landing...");
    if(!drone.land())drone.moveGlobal({0.0f,0.0f,0.0f,false});
}