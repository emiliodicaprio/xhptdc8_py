import yaml

from xhptdc8_py.tdc import close, device_state_to_str, get_fast_info, initialize_tdc

# print(get_default_configuration())
initialize_tdc(8 * 1024 * 1024)
state = get_fast_info(0).state
print(device_state_to_str(state))
close()
