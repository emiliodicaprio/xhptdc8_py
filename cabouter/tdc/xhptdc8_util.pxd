cimport cython
from .xhptdc8_interface cimport xhptdc8_manager_configuration, int64_t
from .crono_interface cimport crono_bool_t

cdef extern from "xhptdc8_util.h":

    cdef int xhptdc8_apply_yaml(xhptdc8_manager_configuration *cfg, const char *yaml_string)
    cdef const char *xhptdc8_get_all_error_messages(crono_bool_t include_ok, crono_bool_t fixed_length)
    cdef const char *xhptdc8_get_err_message(int err_code)
    cdef int xhptdc8_updage_config_for_grouping_mode(int index, xhptdc8_manager_configuration *mgr_cfg, float threshold, int64_t range_start, int64_t range_stop, crono_bool_t rising, crono_bool_t ingore_empty_events)
