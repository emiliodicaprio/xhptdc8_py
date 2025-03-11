# import yaml
from .xhptdc8_util cimport xhptdc8_apply_yaml
from .xhptdc8_interface cimport xhptdc8_manager_configuration, xhptdc8_get_default_configuration, xhptdc8_configure

def apply_yaml_manager_configuration(yaml_str: str):

    cdef xhptdc8_manager_configuration *cfg
    xhptdc8_get_default_configuration(cfg)
    xhptdc8_apply_yaml(cfg, yaml_str)
    xhptdc8_configure(cfg)
    
