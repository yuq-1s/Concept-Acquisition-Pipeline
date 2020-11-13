add_subdirectory(pybind11)

include_directories(${PYTHON_INCLUDE_DIRS})

pybind11_add_module(pyst pyst.cc)
