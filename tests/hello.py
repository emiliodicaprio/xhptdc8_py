import yaml

from xhptdc8_py.tdc import close, get_static_info, initialize_tdc

# print(get_default_configuration())
initialize_tdc(8 * 1024 * 1024)
print(get_static_info(0).chip_id)
close()
