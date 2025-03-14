"""
Python bindings for the cronologic XHPTDC8 Driver.
"""

from .crono_interface import *
from .xhptdc8_interface import *

def py_print_error():  # -> None:
    ...
def get_grouping():  # -> unsigned char:
    ...
def initialize_tdc(buffer_size: int):  # -> int:
    """Initialized XHPTDC8 with default parameters"""
    ...

def get_default_configuration():  # -> unsigned char:
    ...
def start_capture() -> None:  # -> None:
    """Starts Capture"""
    ...

def stop_capture():  # -> None:
    """Stops Capture"""
    ...

def close_tdc():  # -> None:
    ...
def print_device_info():  # -> None:
    ...
