include(CMakeFindDependencyMacro)

find_dependency(Threads REQUIRED)

include("${CMAKE_CURRENT_LIST_DIR}/kuka_external_control_sdk_commonTargets.cmake")
