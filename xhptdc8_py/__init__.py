import ctypes
import os

dirname = os.path.dirname(__file__)
driver_dll_fp = os.path.join(dirname, "xhptdc8_babel/bin/xhptdc8_driver_64.dll")
util_dll_fp = os.path.join(dirname, "xhptdc8_babel/bin/xhptdc8_util.dll")
ctypes.CDLL(driver_dll_fp)
ctypes.CDLL(util_dll_fp)
