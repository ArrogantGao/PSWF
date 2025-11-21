#include <pswf.h>
#include <pybind11/pybind11.h>

namespace py = pybind11;

PYBIND11_MODULE(pypswf, m) {
    m.doc() = "Python bindings for the Prolate Spheroidal Wave Function utilities.";

    m.def(
        "prolate0_eval",
        &prolate0_eval,
        py::arg("c"),
        py::arg("x"),
        "Evaluate the zero-order prolate spheroidal wave function \\u03c8_0^c(x)."
    );

    m.def(
        "prolate0_eval_derivative",
        &prolate0_eval_derivative,
        py::arg("c"),
        py::arg("x"),
        "Evaluate the derivative of the zero-order prolate spheroidal wave function at x."
    );

    m.def(
        "prolate0_int_eval",
        &prolate0_int_eval,
        py::arg("c"),
        py::arg("r"),
        "Evaluate the integral \\int_0^r \\psi_0^c(x) dx."
    );

    m.def(
        "prolate0_lambda",
        &prolate0_lambda,
        py::arg("c"),
        "Compute the eigenvalue \\u03bb_0^c associated with the zero-order function."
    );
}
