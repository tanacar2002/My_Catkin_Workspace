#include "vector3/vector3.hpp"
#include <cmath>

Vector3::Vector3()
    : x(0), y(0), z(0)
{
}

Vector3::Vector3(float x,float y,float z)
    : x(x), y(y), z(z)
{
}
    
float Vector3::getRlength() const
{
    return sqrt(this->x*this->x+this->y*this->y+this->z*this->z);
}

Vector3 Vector3::getNormalized() const
{
    float r = this->getRlength();
    return (*this)/r;
}

Vector3 Vector3::operator+(const Vector3& other) const
{
    return {this->x+other.x,this->y+other.y,this->z+other.z};
}

Vector3 Vector3::operator-(const Vector3& other) const
{
    return {this->x-other.x,this->y-other.y,this->z-other.z};
}

float& Vector3::operator[](int i)
{
    return *(((float*)this)+i);
}