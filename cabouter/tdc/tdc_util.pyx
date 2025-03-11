# import yaml
from .xhptdc8_util cimport xhptdc8_apply_yaml
from .xhptdc8_interface cimport xhptdc8_manager_configuration, xhptdc8_get_default_configuration, xhptdc8_configure, xhptdc8_get_last_error_message, XHPTDC8_OK
from libc.stdio cimport printf

cdef catch_errs(int status, const char *message):
    if status == XHPTDC8_OK:
        return status
    
    printf("TDC ERROR: %s: %s\n", message, xhptdc8_get_last_error_message(0))
    return

def apply_yaml_manager_configuration(yaml_str: bytes):

    cdef xhptdc8_manager_configuration cfg
    cdef char *yaml_string = yaml_str
    xhptdc8_get_default_configuration(&cfg)
    xhptdc8_apply_yaml(&cfg, yaml_string)
    xhptdc8_configure(&cfg)
    
