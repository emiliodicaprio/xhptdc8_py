import yaml

from xhptdc8_py.tdc import close, device_state_to_str, get_static_info, initialize_tdc

# print(get_default_configuration())
initialize_tdc(8 * 1024 * 1024)
state = get_static_info(0).flash_valid
# print(device_state_to_str(state))
print(state)
close()
