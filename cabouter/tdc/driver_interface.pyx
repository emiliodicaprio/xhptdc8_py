cimport cython
from .xhptdc8_interface cimport *
from .crono_interface cimport *
from libc.stdio cimport printf

cpdef py_print_error():
    return

cdef catch_errs(int status, const char *message):
    if status == XHPTDC8_OK:
        return status
    
    printf("%s: %s\n", message, xhptdc8_get_last_error_message(0))
    return

cpdef initialize_tdc(int buffer_size):
    cdef xhptdc8_manager_init_parameters params
    xhptdc8_get_default_init_parameters(&params)
    params.buffer_size = buffer_size

    cdef int error_code
    cdef char *error_msg = NULL
    error_code = xhptdc8_init(&params)
    catch_errs(error_code, error_msg)
    return error_code

# cdef xhptdc8_manager_configuration default_manager
cpdef get_default_configuration():
    cdef xhptdc8_manager_configuration default_manager

    error_message = xhptdc8_get_default_configuration(&default_manager)

    if error_message == 0:
        print("Heuj")

    return default_manager.grouping.enabled

def start_capture():
    err = xhptdc8_start_capture()