include(CMakeFindDependencyMacro)

find_dependency(Threads REQUIRED)
find_dependency(tinyxml2 REQUIRED)

include("${CMAKE_CURRENT_LIST_DIR}/kuka-external-control-sdk-iiqka2Targets.cmake")
