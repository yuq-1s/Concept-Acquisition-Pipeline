find_package(Python COMPONENTS Interpreter Development REQUIRED)
add_subdirectory(pybind11)

pybind11_add_module(pyst pyst.cc)

target_link_libraries(pyst PUBLIC myst)