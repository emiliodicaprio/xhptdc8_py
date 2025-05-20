import yaml

from xhptdc8_py.tdc import (
    close,
    device_state_to_str,
    get_default_init_parameters,
    get_fast_info,
    init_xhptdc8,
    start_capture,
)
from xhptdc8_py.util import apply_yaml_manager_configuration

with open("tests/config.yaml", "rb") as f:
    mgr_config_yaml = f.read()

print(f"Device state before init: {device_state_to_str(get_fast_info(0).state)}")
params = get_default_init_parameters()
init_xhptdc8(params)
print(f"Device state after init: {device_state_to_str(get_fast_info(0).state)}")
apply_yaml_manager_configuration(mgr_config_yaml)
print(
    f"Device state after manager_config: {device_state_to_str(get_fast_info(0).state)}"
)
close()
