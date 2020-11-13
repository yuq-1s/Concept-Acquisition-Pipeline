#include <pybind11/pybind11.h>
#include "myst.h"

namespace py = pybind11;

PYBIND11_MODULE(suffix_tree, m) {
    py::class_<SuffixTree<wchar_t>>(m, "SuffixTree")
        .def(py::init<const char*>())
        .def("count_occurance", &SuffixTree<wchar_t>::count_occurance);
}
