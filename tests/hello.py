import yaml

from xhptdc8_py.tdc import (
    close,
    device_state_to_str,
    get_default_init_parameters,
    get_fast_info,
    init_xhptdc8,
)

# initialize_tdc(1024 * 200)
print(f"Device state before init: {device_state_to_str(get_fast_info(0).state)}")
params = get_default_init_parameters()
init_xhptdc8(params)
close()
