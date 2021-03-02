#pragma once

struct Vector3
{
    float x,y,z;

    Vector3 ();
    Vector3 (float,float,float);

    float getRlength () const;
    Vector3 getNormalized() const;
    auto getPos () const;

    Vector3 operator+ (const Vector3&) const;
    Vector3 operator- (const Vector3&) const;
    template<typename T>
    Vector3 operator* (const T&) const;
    template<typename T>
    Vector3 operator/ (const T&) const;

    float& operator[] (int);
};

template<typename T>
Vector3 Vector3::operator*(const T& other) const
{
    return {this->x*other,this->y*other,this->z*other};
}

template<typename T>
Vector3 Vector3::operator/(const T& other) const
{
    return {this->x/other,this->y/other,this->z/other};
}