# xhptdc8_py
Python bindings for (most of) the [xHPTDC8](https://www.cronologic.de/product/xhptdc8-pcie) driver and utility functions.

Currently, xhptdc8_py does not support setting the xHPTDC8 manager configuration through the 'normal' driver functions, as I have not figured out a non-ugly way to handle wrapping the nested structs that the code depends on. As a workaround, configuration can be done with yaml through the `apply_yaml` utility functions.

## Installation
Clone the repo somewhere, update the submodules by running
```
git submodule init
git submodule update
```
and then install with  ```uv sync``` or ```pip install .```, probably.
