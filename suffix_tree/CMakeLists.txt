cmake_minimum_required(VERSION 3.17)
project(pyst VERSION 0.0.1)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# add_library(pyst python/pyst.cc)
# add_library(myst src/myst.cc include/myst.h)
add_subdirectory(src)
add_subdirectory(python)
target_link_libraries(pyst PUBLIC myst)
# target_link_libraries(suffix_tree PUBLIC pyst)

# target_include_directories(myst PUBLIC
#                            "${PROJECT_SOURCE_DIR}/include"
#                            ${EXTRA_INCLUDES}
#                            )