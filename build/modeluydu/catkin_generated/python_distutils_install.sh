#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/tan/Desktop/ROS/workspace/src/modeluydu"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/tan/Desktop/ROS/workspace/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/tan/Desktop/ROS/workspace/install/lib/python2.7/dist-packages:/home/tan/Desktop/ROS/workspace/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/tan/Desktop/ROS/workspace/build" \
    "/usr/bin/python2" \
    "/home/tan/Desktop/ROS/workspace/src/modeluydu/setup.py" \
     \
    build --build-base "/home/tan/Desktop/ROS/workspace/build/modeluydu" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/tan/Desktop/ROS/workspace/install" --install-scripts="/home/tan/Desktop/ROS/workspace/install/bin"
