import yaml

from xhptdc8_py.tdc.driver_interface import (
    close_tdc,
    get_grouping,
    initialize_tdc,
)
from xhptdc8_py.tdc.tdc_util import apply_yaml_manager_configuration

# print(get_default_configuration())
initialize_tdc(8 * 1024 * 1024)
print(f"grouping enabled is {get_grouping()}")
print(f"grouping enabled is {get_grouping()}")
print(f"grouping enabled is {get_grouping()}")
with open("tests/config.yaml", "r") as f:
    config_yaml = yaml.load(f, yaml.CLoader)

print("Attempting to set config...")
apply_yaml_manager_configuration(yaml.dump(config_yaml, encoding="utf-8"))
print(f"grouping enabled is {get_grouping()}")
print(f"grouping enabled is {get_grouping()}")
close_tdc()
