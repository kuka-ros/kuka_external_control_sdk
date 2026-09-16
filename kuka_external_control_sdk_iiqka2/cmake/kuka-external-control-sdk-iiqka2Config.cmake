include(CMakeFindDependencyMacro)

find_dependency(Threads REQUIRED)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")
find_package(tinyxml2 QUIET)
if(NOT tinyxml2_FOUND)
  find_dependency(tinyxml2_vendor REQUIRED)
endif()
find_dependency(kuka_external_control_sdk_common REQUIRED)

include("${CMAKE_CURRENT_LIST_DIR}/kuka-external-control-sdk-iiqka2Targets.cmake")
