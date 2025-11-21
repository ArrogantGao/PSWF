# Prolate Spheroidal Wave Function

[![tests](https://github.com/ArrogantGao/PSWF/actions/workflows/ci.yml/badge.svg)](https://github.com/ArrogantGao/PSWF/actions/workflows/ci.yml)

A C++ implementation of the prolate spheroidal wave function.

## Python bindings

The project includes optional Python bindings powered by [pybind11](https://github.com/pybind/pybind11).
Enable them with CMake and build the `pypswf` module:

```bash
cmake -S . -B build -DBUILD_PYTHON=ON -DPYTHON_EXECUTABLE=/path/to/python
cmake --build build --target pypswf
```

You can then import the module from Python (ensure `build` is on your `PYTHONPATH`):

```python
import sys
sys.path.append("build")
import pypswf

value = pypswf.prolate0_eval(6.0, 0.5)
```