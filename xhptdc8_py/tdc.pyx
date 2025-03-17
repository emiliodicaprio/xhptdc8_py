cimport cython
from .xhptdc8_interface cimport *
from .crono_interface cimport *
from libc.stdio cimport printf

cpdef py_print_error():
    return

cdef int py_error_wrapper(int status, const char *message) except -1:
    if status == XHPTDC8_OK:
        return 0
    else:
        py_err_message = str(message, encoding="utf-8")
        py_tdc_message = str(xhptdc8_get_last_error_message(0), encoding="utf-8")
        raise RuntimeError(f"TDC error: {py_err_message}: {py_tdc_message}\n")

cdef catch_errs(int status, const char *message):
    if status == XHPTDC8_OK:
        return status
    
    printf("TDC ERROR: %s: %s\n", message, xhptdc8_get_last_error_message(0))
    return

cpdef get_grouping():
    cdef xhptdc8_manager_configuration mgr
    err = xhptdc8_get_current_configuration(&mgr)

    return mgr.grouping.enabled

cpdef initialize_tdc(int buffer_size):
    cdef xhptdc8_manager_init_parameters params
    xhptdc8_get_default_init_parameters(&params)
    params.buffer_size = buffer_size

    cdef int error_code
    cdef char *error_msg = NULL
    error_code = xhptdc8_init(&params)
    catch_errs(error_code, error_msg)
    return error_code

cpdef get_default_configuration():
    cdef xhptdc8_manager_configuration default_manager

    error_message = xhptdc8_get_default_configuration(&default_manager)

    if error_message == 0:
        print("Heuj")

    return default_manager.grouping.enabled

def start_capture() -> None:
    """Start data acquisition.
    Device manager must be initialized.
    """
    py_error_wrapper(xhptdc8_start_capture(), "Could not start capture")

def pause_capture() -> None:
    """Pauses data acquisition. This does not allow for a change in configuration."""
    py_error_wrapper(xhptdc8_pause_capture(), "Could not pause capture")

def continue_capture() -> None:
    """Continues data acquisition. This does not allow for a change in configuration."""
    py_error_wrapper(xhptdc8_continue_capture(), "Could not continue capture")

def stop_capture() -> None:
    """Stop data acquision.
    Device manager must be initialized.
    """
    py_error_wrapper(xhptdc8_stop_capture(), "Could not stop capture")

def software_trigger(index: int) -> None:
    """Generates a software trigger event.
    """
    py_error_wrapper(xhptdc8_software_trigger(index), "Could not generate software trigger.")

cdef class Static_info:
    # cdef xhptdc8_static_info info
    cdef xhptdc8_static_info info

    def __init__(self):
        return
    
    @property
    def version(self) -> int:
        return self.info.version
    
    @property
    def board_id(self) -> int:
        return self.info.board_id
    
    @property
    def driver_revision(self) -> int:
        return self.info.board_revision
    
    @property
    def driver_build_revision(self) -> int:
        return self.info.driver_build_revision

    @property
    def firmware_revision(self) -> int:
        return self.info.firmware_revision
    
    @property
    def board_revision(self) -> int:
        return self.info.board_revision
    
    @property
    def board_configuration(self) -> int:
        return self.info.board_configuration
    
    @property
    def subversion_revision(self) -> int:
        return self.info.subversion_revision
    
    @property
    def chip_id(self) -> list:
        return self.info.chip_id

    @property
    def board_serial(self) -> int:
        return self.info.board_serial
    
    @property
    def flash_serial_high(self) -> int:
        return self.info.flash_serial_high

    @property
    def flash_serial_low(self) -> int:
        return self.info.flash_serial_low
    
    @property
    def flash_valid(self) -> bool:
        return self.info.flash_valid
    


def get_static_info(index: int) -> None:
    """Returns static information about the device.
    """
    cdef Static_info py_static_info = Static_info()
    cdef xhptdc8_static_info *static_info = &py_static_info.info
    py_error_wrapper(xhptdc8_get_static_info(index, static_info), "Could not get static info.")
    return py_static_info

def close() -> None:
    """Finalize the driver for this device.
    """
    py_error_wrapper(xhptdc8_close(), "Could not close driver")

def start_tiger(index: int) -> None:
    """Start the timing generator of an individual board. 
    This can be done independently of the state of the data acquisition."""
    py_error_wrapper(xhptdc8_start_tiger(index), "Could not start TiGer")

def stop_tiger(index: int) -> None:
    """Stops the timing generator of an individual board.
    This can be done independently of the state of the data acquisition."""
    py_error_wrapper(xhptdc8_stop_tiger(index), "Could not stop TiGer")

cpdef print_device_info():
    cdef xhptdc8_static_info static_info
    xhptdc8_get_static_info(0, &static_info)
    print(f"Board Serial: {static_info.board_serial}")

def count_devices() -> int:
    """Returns the number of boards present in the system that are supported by the current driver."""
    cdef int n_devices
    cdef int error_code
    cdef char *error_msg = NULL
    n_devices = xhptdc8_count_devices(&error_code, &error_msg)
    catch_errs(error_code, error_msg)

    return n_devices

def get_driver_revision() -> int:
    """ Returns the driver version, same format as static_info.driver_revision. 
    This function does not require a xHPTDC8_PCIe board to be present."""

    cdef int driver_revision
    driver_revision = xhptdc8_get_driver_revision()
    return driver_revision

def get_driver_revision_str() -> str:
    """ Returns the driver version, including SVN build revision as a string.
    This function does not require a xHPTDC8_PCIe board to be present."""
    cdef const char *driver_revision = xhptdc8_get_driver_revision_str()

    return str(driver_revision, encoding="utf-8")

def device_state_to_str(state: int) -> str:
    """ Returns the device state in string format. """
    cdef const char *device_state_str = xhptdc8_device_state_to_str(state)

    return str(device_state_str, encoding="utf=8")