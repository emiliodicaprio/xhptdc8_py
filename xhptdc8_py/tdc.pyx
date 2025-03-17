cimport cython
from .xhptdc8_interface cimport *
from .crono_interface cimport *
from libc.stdio cimport printf
from libc.stdlib cimport free

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
    """Structure containing static information about the board that does not change during run time. 
    It is provided by the function get_static_info()
    """
    cdef xhptdc8_static_info info

    def __init__(self):
        return
    
    @property
    def version(self) -> int:
        """A version number which increases when the definition of the structure is changed"""
        return self.info.version
    
    @property
    def board_id(self) -> int:
        """ID of the board. All xHPTDC8-PCIe boards in the system are numbered in order of serial number,
        starting at zero."""
        return self.info.board_id
    
    @property
    def driver_revision(self) -> int:
        """Encoded version number for the driver.
        The lower three bytes contain a triple level hierarchy of version
        numbers. E.g. 0x010103 codes version 1.1.3.
        
        A change in the first digit generally requires a recompilation of
        user applications. Change in the second digit denote significant
        improvements or changes that don't break compatibility and the third
        digit changes with minor bugfixes and the like."""
        return self.info.board_revision
    
    @property
    def driver_build_revision(self) -> int:
        """The build number of the driver according to cronologic's internal versioning system."""
        return self.info.driver_build_revision

    @property
    def firmware_revision(self) -> int:
        """Revision number of the FPGA configuration."""
        return self.info.firmware_revision
    
    @property
    def board_revision(self) -> int:
        """Board revision number.
        The board revision number can be read from a register. It is a four
        bit number that changes when the schematic of the board is changed.
        - 0: Experimental first board Version. Labeled "Rev. 1"
        - 2: First commercial Version. Labeled "Rev. 2"
        """
        return self.info.board_revision
    
    @property
    def board_configuration(self) -> int:
        """Describes the schematic configuration of the board.

        The same board schematic can be populated in multiple variants. This is a eight bit-code that can be read from a register.
        """
        return self.info.board_configuration
    
    @property
    def subversion_revision(self) -> int:
        """Subversion revision id of the FPGA configuration.
        A number to track builds of the firmware in more detail than the firmware revision. It changes with every change in the firmware, even if there is no visible effect for the user. The subversion revision number can be read from a register."""
        return self.info.subversion_revision
    
    @property
    def chip_id(self) -> list:
        """16bit factory ID of the TDC chip.
        
        This is the chipID as read from the 16 bit TDC chip id register."""
        return self.info.chip_id

    @property
    def board_serial(self) -> int:
        """Serial number

        With year and number running in 8.24 format. The number is identical to the one printed on the silvery sticker on the board.
        
        """
        return self.info.board_serial
    
    @property
    def flash_serial_high(self) -> int:
        """High 32 bits of 64 bit manufacturer serial number of the flash chip."""
        return self.info.flash_serial_high

    @property
    def flash_serial_low(self) -> int:
        """Low 32 bits of 64 bit manufacturer serial number of the flash chip."""
        return self.info.flash_serial_low
    
    @property
    def flash_valid(self) -> bool:
        """Calibration data read from flash is valid.
        
        If not 'False', the driver found valid calibration data in the flash on the board and is using it."""
        return self.info.flash_valid

def get_static_info(index: int) -> None:
    """Returns static information about the device.
    """
    cdef Static_info py_static_info = Static_info()
    cdef xhptdc8_static_info *static_info = &py_static_info.info
    py_error_wrapper(xhptdc8_get_static_info(index, static_info), "Could not get static info.")
    return py_static_info

cdef class Fast_info:
    """Structure containing fast dynamic information.
    """
    cdef xhptdc8_fast_info info

    def __init__(self) -> None:
        return
    
    @property
    def version(self) -> int:
        """A version number that is increased when the definition of the structure is changed.
        """
        return self.info.version

    @property
    def fpga_rpm(self) -> int:
        """Speed of the FPGA fan in RPM. Returns 0 if no fan is present
        """
        return self.info.fpga_rpm

    @property
    def alerts(self) -> int:
        """Alert bits from temperature sensor and the system monitor.

        Bit 0 is set if the TDC temperature exceeds 140C. In this case the TDC shuts down and the device needs to be reinitialized.
        """
        return self.info.alerts

    @property
    def pcie_pwr_mgmt(self) -> int:
        """Reports power management configuration of PCIe lanes. Should always be 0.
        """
        return self.info.pcie_pwr_mgmt

    @property
    def pcie_link_width(self) -> int:
        """Number of PCIe lanes the card uses. Should always be 1 for the xHPTDC8-PCIe.
        """
        return self.info.pcie_link_width

    @property
    def pcie_max_payload(self) -> int:
        """Maximum size for a single PCIe transaction in bytes. Depends on system configuration.
        """
        return self.info.pcie_max_payload

    @property
    def state(self) -> int:
        """The current state of the device.
        """
        return self.info.state

def get_fast_info(index: int) -> Fast_info:
    """Returns fast dynamic info about the device

    This call gets a structure that contains dynamic information that can be obtained within a few microseconds.
    """
    cdef Fast_info py_fast_info = Fast_info()
    cdef xhptdc8_fast_info *fast_info = &py_fast_info.info
    py_error_wrapper(xhptdc8_get_fast_info(index, fast_info), "Could not get fast info")
    return py_fast_info

cdef class Param_info:
    """Structure that contains information that may change with configuration.

    Structure is filled by get_param_info()
    This structure contains information that changes indirectly due to configuration changes.
    """
    cdef xhptdc8_param_info info

    def __init__(self) -> None:
        return
    
    @property
    def version(self) -> int:
        """A version number that is increased when the definition of the structure is changed.
        """
        return self.info.version
    @property
    def binsize(self) -> float:
        """Binsize (in ps) of the measured TDC data.

        The TDC main clock runs at a frequency of 76.8 GHz, resulting in a binsize of ~13.0208 ps.
        """
        return self.info.binsize

    @property
    def channels(self) -> int:
        """Number of TDC channels of the board. Currently fixed at 8.
        """
        return self.info.channels

    @property
    def channel_mask(self) -> int:
        """Bit assignment of each enabled input channel. Bint 0 <= n < 8 is set if channel n is enabled."""
        return self.info.channel_mask

    @property
    def total_buffer(self) -> int:
        """The total amount of DMA buffer in bytes.
        """
        return self.info.total_buffer

def get_param_info(index: int) -> Param_info:
    """Returns information that may change with configuration

    Gets a structure that contains information that changes indirectly due to configuration changes.
    """
    cdef Param_info py_param_info = Param_info()
    cdef xhptdc8_param_info *param_info = &py_param_info.info
    py_error_wrapper(xhptdc8_get_param_info(index, param_info), "Could not get param info.")

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