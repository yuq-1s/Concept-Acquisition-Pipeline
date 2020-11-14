add_library(myst OBJECT myst.cc)

if(USE_TQDM)
  add_compile_definitions("USE_TQDM")
  list(APPEND EXTRA_INCLUDES "tqdm-cpp")
endif()

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

option(USE_TQDM "Use tqdm" ON)

target_include_directories(myst PUBLIC
                           "${PROJECT_SOURCE_DIR}/include"
                           ${EXTRA_INCLUDES}
                           )