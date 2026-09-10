include(CMakeFindDependencyMacro)

find_dependency(Threads REQUIRED)
find_dependency(tinyxml2 REQUIRED)
find_dependency(kuka_external_control_sdk_common REQUIRED)

include("${CMAKE_CURRENT_LIST_DIR}/kuka-external-control-sdk-iiqka2Targets.cmake")
