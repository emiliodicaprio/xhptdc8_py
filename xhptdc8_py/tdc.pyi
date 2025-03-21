"""
xhptdc8_py.tdc
----------
Python bindings for the cronologic xHPTDC8-PCIe driver

The `xhptdc8_py.tdc` module wraps and
"""

class Manager_init_parameters:
    """Struct for initialization of the xHPTDC8 manager. Default parameters are obtained from get_default_init_parameters()."""
    def __init__(self) -> None: ...
    @property
    def version(self) -> int:
        """Version number of the xhptdc8_manager_init_parameters structure. Must be left unchanged.

        Returns:
            version (int):
        """
        ...

    @property
    def buffer_size(self) -> int:
        """The minimum size for the DMA buffer. If set to 0, the default size of 16MB is used.

        Returns:
            buffer_size (int):
        """
        ...

    @buffer_size.setter
    def buffer_size(self, buffer_size: int) -> None:
        """
        Args:
            buffer_size (int): minimum buffer size in bytes
        """
        ...
    @property
    def variant(self) -> int:
        """A variant, for reconfiguring the chip for future extension.

        Returns:
            variant (int):
        """
        ...

    @property
    def device_type(self) -> int:
        """A constant for the different devices of cronologic CRONO_DEVICE_*. Initialized by `get_default_init_parameters`, must be left unchanged.

        Returns:
            device_type (int):
        """
        ...

    @property
    def dma_read_delay(self) -> int:
        """The update delay of the writing pointer after a packet has been sent over PCIe. Specified in multiples of 16ns. Should not be changed by the user. The base unit is 16 to 32 ns.

        Returns:
            dma_read_delay (bool):
        """
        ...

    @property
    def multiboard(self) -> bool:
        """Several xHPTDC8-PCIe can be used in sync. If set to True, enable multiboard operation. If set to False, disable multiboard operation.

        Returns:
            multiboard (bool):
        """
        ...

    @multiboard.setter
    def multiboard(self, multiboard: bool) -> None:
        """
        Args:
            multiboard (bool):
        """
        ...
    @property
    def use_ext_clock(self) -> bool:
        """Select external 10 MHz reference. If set to True, use external 10 MHz reference. If set to False, use internal reference.

        Returns:
            use_ext_clock (bool):
        """
        ...

    @use_ext_clock.setter
    def use_ext_clock(self, use_ext_clock: bool) -> None:
        """

        Args:
            use_ext_clock (bool):
        """
        ...
    @property
    def ignore_calibration(self) -> bool:
        """Ignore calibration values read from device flash.

        Returns:
            ignore_calibration (bool):
        """
        ...

    @ignore_calibration.setter
    def ignore_calibration(self, ignore_calibration: bool) -> None:
        """

        Args:
            ignore_calibration (bool):
        """
        ...

def get_default_init_parameters() -> Manager_init_parameters:
    """Sets up the standard parameters.

    Gets a set of default parameters to use for `init_xhptdc8()`. This function must always be used to initialize the Manager_init_parameters structure.

    Returns:
        configuration (Manager_init_parameters): a set of decent default manager parameters
    """
    ...

def init_xhptdc8(manager_init_parameters: Manager_init_parameters) -> None:
    """Opens and initializes all xHPTDC8-PCIe boards.

    Args:
        manager_init_parameters (Manager_init_parameters): must be a fully initialized set of manager initialization parameters. You can use `get_default_init_parameters()` for a decent set of default parameters.
    """
    ...

def start_capture() -> None:
    """Start data acquisition.
    Device manager must be initialized.
    """
    ...

def pause_capture() -> None:
    """Pauses data acquisition. This does not allow for a change in configuration."""
    ...

def continue_capture() -> None:
    """Continues data acquisition. This does not allow for a change in configuration."""
    ...

def stop_capture() -> None:
    """Stop data acquision.
    Device manager must be initialized.
    """
    ...

def software_trigger(index: int) -> None:
    """Generates a software trigger event."""
    ...

class Static_info:
    """Structure containing static information about the board that does not change during run time.
    It is provided by the function get_static_info()
    """
    def __init__(self) -> None: ...
    @property
    def version(self) -> int:
        """A version number which increases when the definition of the structure is changed"""
        ...

    @property
    def board_id(self) -> int:
        """ID of the board. All xHPTDC8-PCIe boards in the system are numbered in order of serial number,
        starting at zero."""
        ...

    @property
    def driver_revision(self) -> int:
        """Encoded version number for the driver.
        The lower three bytes contain a triple level hierarchy of version
        numbers. E.g. 0x010103 codes version 1.1.3.

        A change in the first digit generally requires a recompilation of
        user applications. Change in the second digit denote significant
        improvements or changes that don't break compatibility and the third
        digit changes with minor bugfixes and the like."""
        ...

    @property
    def driver_build_revision(self) -> int:
        """The build number of the driver according to cronologic's internal versioning system."""
        ...

    @property
    def firmware_revision(self) -> int:
        """Revision number of the FPGA configuration."""
        ...

    @property
    def board_revision(self) -> int:
        """Board revision number.
        The board revision number can be read from a register. It is a four
        bit number that changes when the schematic of the board is changed.
        - 0: Experimental first board Version. Labeled "Rev. 1"
        - 2: First commercial Version. Labeled "Rev. 2"
        """
        ...

    @property
    def board_configuration(self) -> int:
        """Describes the schematic configuration of the board.

        The same board schematic can be populated in multiple variants. This is a eight bit-code that can be read from a register.
        """
        ...

    @property
    def subversion_revision(self) -> int:
        """Subversion revision id of the FPGA configuration.
        A number to track builds of the firmware in more detail than the firmware revision. It changes with every change in the firmware, even if there is no visible effect for the user. The subversion revision number can be read from a register."""
        ...

    @property
    def chip_id(self) -> list:
        """16bit factory ID of the TDC chip.

        This is the chipID as read from the 16 bit TDC chip id register."""
        ...

    @property
    def board_serial(self) -> int:
        """Serial number

        With year and number running in 8.24 format. The number is identical to the one printed on the silvery sticker on the board.

        """
        ...

    @property
    def flash_serial_high(self) -> int:
        """High 32 bits of 64 bit manufacturer serial number of the flash chip."""
        ...

    @property
    def flash_serial_low(self) -> int:
        """Low 32 bits of 64 bit manufacturer serial number of the flash chip."""
        ...

    @property
    def flash_valid(self) -> bool:
        """Calibration data read from flash is valid.

        If not 'False', the driver found valid calibration data in the flash on the board and is using it."""
        ...

def get_static_info(index: int) -> None:
    """Returns static information about the device."""
    ...

class Fast_info:
    """Structure containing fast dynamic information."""
    def __init__(self) -> None: ...
    @property
    def version(self) -> int:
        """A version number that is increased when the definition of the structure is changed."""
        ...

    @property
    def fpga_rpm(self) -> int:
        """Speed of the FPGA fan in RPM. Returns 0 if no fan is present"""
        ...

    @property
    def alerts(self) -> int:
        """Alert bits from temperature sensor and the system monitor.

        Bit 0 is set if the TDC temperature exceeds 140C. In this case the TDC shuts down and the device needs to be reinitialized.
        """
        ...

    @property
    def pcie_pwr_mgmt(self) -> int:
        """Reports power management configuration of PCIe lanes. Should always be 0."""
        ...

    @property
    def pcie_link_width(self) -> int:
        """Number of PCIe lanes the card uses. Should always be 1 for the xHPTDC8-PCIe."""
        ...

    @property
    def pcie_max_payload(self) -> int:
        """Maximum size for a single PCIe transaction in bytes. Depends on system configuration."""
        ...

    @property
    def state(self) -> int:
        """The current state of the device."""
        ...

def get_fast_info(index: int) -> Fast_info:
    """Returns fast dynamic info about the device

    This call gets a structure that contains dynamic information that can be obtained within a few microseconds.
    """
    ...

class Param_info:
    """Structure that contains information that may change with configuration.

    Structure is filled by get_param_info()
    This structure contains information that changes indirectly due to configuration changes.
    """
    def __init__(self) -> None: ...
    @property
    def version(self) -> int:
        """A version number that is increased when the definition of the structure is changed."""
        ...

    @property
    def binsize(self) -> float:
        """Binsize (in ps) of the measured TDC data.

        The TDC main clock runs at a frequency of 76.8 GHz, resulting in a binsize of ~13.0208 ps.
        """
        ...

    @property
    def channels(self) -> int:
        """Number of TDC channels of the board. Currently fixed at 8."""
        ...

    @property
    def channel_mask(self) -> int:
        """Bit assignment of each enabled input channel. Bint 0 <= n < 8 is set if channel n is enabled."""
        ...

    @property
    def total_buffer(self) -> int:
        """The total amount of DMA buffer in bytes."""
        ...

def get_param_info(index: int) -> Param_info:
    """Returns information that may change with configuration

    Gets a structure that contains information that changes indirectly due to configuration changes.
    """
    ...

class Temperature_info:
    """Structure containing temperature measurements.
    The TDC temperature diode takes about 2.5us after wakeup from power down to privide a valid measurement.
    Structure is filled by get_temperature_info().
    """
    def __init__(self) -> None: ...
    @property
    def version(self) -> int:
        """Version number that is increased when the definition of the structure is changed."""
        ...

    @property
    def tdc(self) -> list[float]:
        """Temperature for each of the TDC chips in degC."""
        ...

def get_temperature_info(index: int):  # -> Temperature_info:
    """Gets temperature index from multiple sources on the board."""
    ...

class Clock_info:
    """Contains information about the active clock source.

    Structure is filled by get_clock_info()
    """
    def __init__(self) -> None: ...
    @property
    def version(self) -> int:
        """A version number that is increased when the definition of the structure is changed."""
        ...

    @property
    def cdce_locked(self) -> bool:
        """CDCE62005 PLL locked. Set if the jitter cleaning PLL clock synthesizer achieved lock."""
        ...

    @property
    def cdce_version(self) -> int:
        """Version information from the CDCE62005 clock synthesizer."""
        ...

    @property
    def use_ext_clock(self) -> bool:
        """Source for the clock synthesizer is usually the 10MHz on-board oscillator. If False: 10MHz onboard. If True: LEMO clock."""
        ...

    @property
    def fpga_locked(self) -> bool:
        """Set if the FPGA datapath PLLs achieved lock."""
        ...

def get_clock_info(index: int) -> Clock_info:
    """Get information on clocking configuration and status"""
    ...

def get_last_error_message(index: int) -> str:
    """Returns the most recent error message."""
    ...

def get_device_type(index: int) -> int:
    """Returns the type of the device as CRONO_DEVICE_XHPTDC8"""
    ...

def close() -> None:
    """Finalize the driver for this device."""
    ...

def start_tiger(index: int) -> None:
    """Start the timing generator of an individual board.
    This can be done independently of the state of the data acquisition."""
    ...

def stop_tiger(index: int) -> None:
    """Stops the timing generator of an individual board.
    This can be done independently of the state of the data acquisition."""
    ...

def count_devices() -> int:
    """Returns the number of boards present in the system that are supported by the current driver."""
    ...

def get_driver_revision() -> int:
    """Returns the driver version, same format as static_info.driver_revision.
    This function does not require a xHPTDC8_PCIe board to be present."""
    ...

def get_driver_revision_str() -> str:
    """Returns the driver version, including SVN build revision as a string.
    This function does not require a xHPTDC8_PCIe board to be present."""
    ...

def device_state_to_str(state: int) -> str:
    """Returns the device state in string format."""
    ...
