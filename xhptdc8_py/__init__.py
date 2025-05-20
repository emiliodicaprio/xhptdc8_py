import ctypes
import os

dirname = os.path.dirname(__file__)
dll_fp = os.path.join(dirname, "xhptdc8_babel/bin/xhptdc8_driver_64.dll")
ctypes.CDLL(dll_fp)
