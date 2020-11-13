add_subdirectory(pybind11)

include_directories(${PYTHON_INCLUDE_DIRS})

pybind11_add_module(pyst pyst.cc)

target_link_libraries(pyst PUBLIC myst)
target_link_libraries(pyst PUBLIC -lmyst -L"${PROJECT_BINARY_DIR}/src")