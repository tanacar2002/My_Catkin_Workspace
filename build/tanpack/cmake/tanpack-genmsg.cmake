# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "tanpack: 1 messages, 0 services")

set(MSG_I_FLAGS "-Itanpack:/home/tan/Desktop/ROS/workspace/src/tanpack/msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(tanpack_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/tan/Desktop/ROS/workspace/src/tanpack/msg/tanmsg.msg" NAME_WE)
add_custom_target(_tanpack_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "tanpack" "/home/tan/Desktop/ROS/workspace/src/tanpack/msg/tanmsg.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(tanpack
  "/home/tan/Desktop/ROS/workspace/src/tanpack/msg/tanmsg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tanpack
)

### Generating Services

### Generating Module File
_generate_module_cpp(tanpack
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tanpack
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(tanpack_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(tanpack_generate_messages tanpack_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tan/Desktop/ROS/workspace/src/tanpack/msg/tanmsg.msg" NAME_WE)
add_dependencies(tanpack_generate_messages_cpp _tanpack_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tanpack_gencpp)
add_dependencies(tanpack_gencpp tanpack_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tanpack_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(tanpack
  "/home/tan/Desktop/ROS/workspace/src/tanpack/msg/tanmsg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tanpack
)

### Generating Services

### Generating Module File
_generate_module_eus(tanpack
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tanpack
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(tanpack_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(tanpack_generate_messages tanpack_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tan/Desktop/ROS/workspace/src/tanpack/msg/tanmsg.msg" NAME_WE)
add_dependencies(tanpack_generate_messages_eus _tanpack_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tanpack_geneus)
add_dependencies(tanpack_geneus tanpack_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tanpack_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(tanpack
  "/home/tan/Desktop/ROS/workspace/src/tanpack/msg/tanmsg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tanpack
)

### Generating Services

### Generating Module File
_generate_module_lisp(tanpack
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tanpack
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(tanpack_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(tanpack_generate_messages tanpack_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tan/Desktop/ROS/workspace/src/tanpack/msg/tanmsg.msg" NAME_WE)
add_dependencies(tanpack_generate_messages_lisp _tanpack_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tanpack_genlisp)
add_dependencies(tanpack_genlisp tanpack_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tanpack_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(tanpack
  "/home/tan/Desktop/ROS/workspace/src/tanpack/msg/tanmsg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tanpack
)

### Generating Services

### Generating Module File
_generate_module_nodejs(tanpack
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tanpack
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(tanpack_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(tanpack_generate_messages tanpack_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tan/Desktop/ROS/workspace/src/tanpack/msg/tanmsg.msg" NAME_WE)
add_dependencies(tanpack_generate_messages_nodejs _tanpack_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tanpack_gennodejs)
add_dependencies(tanpack_gennodejs tanpack_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tanpack_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(tanpack
  "/home/tan/Desktop/ROS/workspace/src/tanpack/msg/tanmsg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tanpack
)

### Generating Services

### Generating Module File
_generate_module_py(tanpack
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tanpack
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(tanpack_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(tanpack_generate_messages tanpack_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tan/Desktop/ROS/workspace/src/tanpack/msg/tanmsg.msg" NAME_WE)
add_dependencies(tanpack_generate_messages_py _tanpack_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tanpack_genpy)
add_dependencies(tanpack_genpy tanpack_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tanpack_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tanpack)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tanpack
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(tanpack_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tanpack)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tanpack
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(tanpack_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tanpack)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tanpack
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(tanpack_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tanpack)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tanpack
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(tanpack_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tanpack)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tanpack\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tanpack
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(tanpack_generate_messages_py std_msgs_generate_messages_py)
endif()
