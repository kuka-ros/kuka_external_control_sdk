cmake_minimum_required(VERSION 3.13)

project(kuka_external_control_sdk_common)

set(common_directory ${CMAKE_CURRENT_SOURCE_DIR})
set(utils_directory ${CMAKE_CURRENT_SOURCE_DIR}/utils)

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "$ENV{HOME}/.local" CACHE PATH "default install path" FORCE)
endif()
set(CMAKE_INSTALL_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

find_package(Threads REQUIRED)

set(sources
  ${common_directory}/src/status.cc
  ${utils_directory}/src/os-core-udp-communication/replier.cc
  ${utils_directory}/src/os-core-udp-communication/socket.cc
  ${utils_directory}/src/os-core-udp-communication/publisher.cc
  ${utils_directory}/src/os-core-udp-communication/subscriber.cc
  ${utils_directory}/src/os-core-udp-communication/dissector.cc
  ${utils_directory}/src/os-core-udp-communication/tcp_client.cc
  ${utils_directory}/src/os-core-udp-communication/requester.cc
  ${utils_directory}/src/os-core-udp-communication/secure_replier.cc
  ${utils_directory}/src/os-core-udp-communication/secure_socket.cc
)

set(target_name "kuka-external-control-sdk-common")

add_library(${target_name} STATIC ${sources})

target_include_directories(${target_name} PUBLIC
  "$<BUILD_INTERFACE:${common_directory}/include>"
  "$<BUILD_INTERFACE:${utils_directory}/include>"
  "$<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/include>"
)

target_link_libraries(${target_name}
  PUBLIC Threads::Threads
)

target_compile_features(${target_name} INTERFACE cxx_std_17 PRIVATE cxx_std_17)

install(TARGETS ${target_name} EXPORT SdkExport
    ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR})

install(EXPORT SdkExport NAMESPACE Kuka::
    FILE kuka_external_control_sdk_commonTargets.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/kuka_external_control_sdk_common
)

install(FILES
    ${CMAKE_CURRENT_LIST_DIR}/cmake/kuka_external_control_sdk_commonConfig.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/kuka_external_control_sdk_common
)

install(DIRECTORY ${common_directory}/include/ ${utils_directory}/include/
      DESTINATION ${CMAKE_INSTALL_PREFIX}/include
      FILES_MATCHING PATTERN "*.h" PATTERN "*.hh")

# Install package.xml file so this package can be processed by ROS toolings
# See REP 136 for details
# Installing this in non-ROS environments won't have any effect, but it won't harm, either.
install(FILES package.xml DESTINATION share/${PROJECT_NAME})

#### Begin import ####
# Imported from ros-industrial/ros_industrial_cmake_boilerplate
# Copyright (C) 2018 by George Cave - gcave@stablecoder.ca
# Copyright (c) 2020, Southwest Research Institute
# Licensed under Apache-2.0 license

# Allows Colcon to find non-Ament packages when using workspace underlays
file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/share/ament_index/resource_index/packages/${PROJECT_NAME} "")
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/share/ament_index/resource_index/packages/${PROJECT_NAME}
    DESTINATION share/ament_index/resource_index/packages
)
file(WRITE
    ${CMAKE_CURRENT_BINARY_DIR}/share/${PROJECT_NAME}/hook/ament_prefix_path.dsv
    "prepend-non-duplicate;AMENT_PREFIX_PATH;"
)
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/share/${PROJECT_NAME}/hook/ament_prefix_path.dsv
    DESTINATION share/${PROJECT_NAME}/hook
)
file(WRITE
    ${CMAKE_CURRENT_BINARY_DIR}/share/${PROJECT_NAME}/hook/ros_package_path.dsv
    "prepend-non-duplicate;ROS_PACKAGE_PATH;"
)
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/share/${PROJECT_NAME}/hook/ros_package_path.dsv
    DESTINATION share/${PROJECT_NAME}/hook
)
#### End import ####
