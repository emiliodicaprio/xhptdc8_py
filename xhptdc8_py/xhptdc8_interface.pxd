cimport cython
from libc.stdint cimport int64_t, int16_t, int32_t, uint8_t, uint16_t, uint32_t, uint64_t
from .crono_interface cimport crono_pcie_info, crono_bool_t

# wrapper for the header of the driver dll
cdef extern from "xhptdc8_interface.h":
    ctypedef struct xhptdc8_manager_init_parameters:
        int version
        int64_t buffer_size
        int variant
        int device_type
        int dma_read_delay
        crono_bool_t multiboard
        crono_bool_t use_ext_clock
        crono_bool_t ignore_calibration
    
    ctypedef struct TDCHit:
        int64_t time
        uint8_t channel
        uint8_t type
        uint16_t bin
        uint32_t reserved

    cdef int xhptdc8_read_hits(TDCHit *hit_buf, size_t read_max)

    cdef int xhptdc8_read_group_matrix(int64_t *absolute_trigger_timestamp, int32_t *hit_counter, int64_t *tdc_array, int32_t *adc_counter, int32_t *adc_value, int32_t number_of_tdcs, int32_t number_of_channels, int32_t number_of_hits)

    cdef int xhptdc8_close()

    cdef int xhptdc8_start_tiger(int index)

    cdef int xhptdc8_stop_tiger(int index)

    cdef int xhptdc8_start_capture()

    cdef int xhptdc8_pause_capture()

    cdef int xhptdc8_continue_capture()

    cdef int xhptdc8_stop_capture()

    cdef int xhptdc8_software_trigger(int index)

    ctypedef struct xhptdc8_static_info:
        int size_t
        int version
        int board_id
        int driver_revision
        int driver_build_revision
        int firmware_revision
        int board_revision
        int board_configuration
        int subversion_revision
        int[2] chip_id
        int board_serial
        uint32_t flash_serial_high
        uint32_t flash_serial_low
        crono_bool_t flash_valid
        char[20] calibration_date
    
    cdef int xhptdc8_get_static_info(int index, xhptdc8_static_info *info)

    ctypedef struct xhptdc8_fast_info:
        int size
        int version
        int fpga_rpm
        int alerts
        int pcie_pwr_mgmt
        int pcie_link_width
        int pcie_max_payload
        int state
    
    cdef int xhptdc8_get_fast_info(int index, xhptdc8_fast_info *info)

    ctypedef struct xhptdc8_param_info:
        int size
        int version
        double binsize
        int channels
        int channel_mask
        int64_t total_buffer

    cdef int xhptdc8_get_param_info(int index, xhptdc8_param_info *info)

    ctypedef struct xhptdc8_temperature_info:
        int size
        int version
        float[2] tdc
    
    cdef int xhptdc8_get_temperature_info(int index, xhptdc8_temperature_info *info)

    ctypedef struct xhptdc8_clock_info:
        int size
        int version
        crono_bool_t cdce_locked
        int cdce_version
        crono_bool_t use_ext_clock
        crono_bool_t fpga_locked
    
    cdef int xhptdc8_get_clock_info(int index, xhptdc8_clock_info *info)

    cdef const char *xhptdc8_get_last_error_message(int index)

    cdef int xhptdc8_get_device_type(int index)

    ctypedef struct xhptdc8_channel:
        crono_bool_t enable
        crono_bool_t rising
    
    ctypedef struct xhptdc8_tiger_block:
        int mode
        crono_bool_t negate
        crono_bool_t retrigger
        crono_bool_t extend
        int start
        int stop
        int sources
    
    ctypedef struct xhptdc8_trigger:
        crono_bool_t falling
        crono_bool_t rising

    ctypedef struct xhptdc8_adc_channel:
        crono_bool_t enable
        crono_bool_t watchdog_readout
        int watchdog_interval
        double trigger_threshold
    
    ctypedef struct xhptdc8_grouping_configuration:
        crono_bool_t enabled
        int trigger_channel
        uint64_t trigger_channel_bitmask
        int64_t range_start
        int64_t range_stop
        int64_t trigger_deadtime
        int zero_channel
        int64_t zero_channel_offset
        uint64_t window_hit_channels
        int64_t window_start
        int64_t window_stop
        int veto_mode
        int64_t veto_start
        uint64_t veto_active_channels
        crono_bool_t veto_relative_to_zero
        crono_bool_t ignore_empty_evens
        crono_bool_t overlap
    
    ctypedef struct xhptdc8_device_configuration:
        int size
        int version
        int auto_trigger_period
        int auto_trigger_random_exponent
        double[8] trigger_threshold
        xhptdc8_trigger[16] trigger
        xhptdc8_tiger_block[8] gating_block
        xhptdc8_tiger_block[9] tiger_block
        xhptdc8_channel[8] channel
        xhptdc8_adc_channel adc_channel
        crono_bool_t skip_alignment
        int alignment_source
        int alignment_off_state

    ctypedef struct xhptdc8_manager_configuration:
        int size
        int version
        xhptdc8_device_configuration[6] device_configs
        xhptdc8_grouping_configuration grouping
        int64_t *bin_to_ps
    
    cdef int xhptdc8_get_default_configuration(xhptdc8_manager_configuration *mgr_config)

    cdef int xhptdc8_get_current_configuration(xhptdc8_manager_configuration *mgr_config)

    cdef int xhptdc8_configure(xhptdc8_manager_configuration *mgr_config)

    cdef int xhptdc8_count_devices(int *error_code, const char **error_message)

    cdef int xhptdc8_get_default_init_parameters(xhptdc8_manager_init_parameters *init)

    cdef int xhptdc8_init(xhptdc8_manager_init_parameters *params)

    cdef int xhptdc8_get_driver_revision()

    cdef const char *xhptdc8_get_driver_revision_str()

    cdef const char *xhptdc8_device_state_to_str(int state)

    cdef int xhptdc8_read_user_flash(int index, uint8_t *flash_data, uint32_t size)

    cdef int xhptdc8_write_user_flash(int index, uint8_t *flash_data, uint32_t size)

    cdef int xhptdc8_get_pcie_info(int index, crono_pcie_info *pcie_info)

    cdef int xhptdc8_clear_pcie_errors(int index, int flags)

    cdef int xhptdc8_get_current_timestamp(int index, int64_t *timestamp)

    cdef int XHPTDC8_API_VERSION "XHPTDC8_API_VERSION" 
    cdef int XHPTDC8_STATIC_INFO_VERSION "XHPTDC8_STATIC_INFO_VERSION" 
    cdef int XHPTDC8_FAST_INFO_VERSION "XHPTDC8_FAST_INFO_VERSION" 
    cdef int XHPTDC8_PARAM_INFO_VERSION "XHPTDC8_PARAM_INFO_VERSION" 
    cdef int XHPTDC8_TEMP_INFO_VERSION "XHPTDC8_TEMP_INFO_VERSION" 
    cdef int XHPTDC8_CLOCK_INFO_VERSION "XHPTDC8_CLOCK_INFO_VERSION" 
    cdef int XHPTDC8_DEVICE_CONFIG_VERSION "XHPTDC8_DEVICE_CONFIG_VERSION" 
    cdef int XHPTDC8_MANAGER_CONFIG_VERSION "XHPTDC8_MANAGER_CONFIG_VERSION" 
    cdef int XHPTDC8_MANAGER_DEVICES_MAX "XHPTDC8_MANAGER_DEVICES_MAX" 
    cdef int XHPTDC8_TDC_CHANNEL_COUNT "XHPTDC8_TDC_CHANNEL_COUNT" 
    cdef int XHPTDC8_GATE_COUNT "XHPTDC8_GATE_COUNT" 
    cdef int XHPTDC8_TIGER_COUNT "XHPTDC8_TIGER_COUNT" 
    cdef int XHPTDC8_TRIGGER_COUNT "XHPTDC8_TRIGGER_COUNT" 
    cdef int XHPTDC8_BUFFER_ALLOCATE "XHPTDC8_BUFFER_ALLOCATE" 
    cdef int XHPTDC8_BUFFER_USE_PHYSICAL "XHPTDC8_BUFFER_USE_PHYSICAL" 
    cdef int XHPTDC8_INPUT_BASELINE "XHPTDC8_INPUT_BASELINE" 
    cdef int XHPTDC8_THRESHOLD_P_NIM "XHPTDC8_THRESHOLD_P_NIM" 
    cdef int XHPTDC8_THRESHOLD_P_CMOS "XHPTDC8_THRESHOLD_P_CMOS" 
    cdef int XHPTDC8_THRESHOLD_P_LVCMOS_33 "XHPTDC8_THRESHOLD_P_LVCMOS_33" 
    cdef int XHPTDC8_THRESHOLD_P_LVCMOS_25 "XHPTDC8_THRESHOLD_P_LVCMOS_25" 
    cdef int XHPTDC8_THRESHOLD_P_LVCMOS_18 "XHPTDC8_THRESHOLD_P_LVCMOS_18" 
    cdef int XHPTDC8_THRESHOLD_P_TTL "XHPTDC8_THRESHOLD_P_TTL" 
    cdef int XHPTDC8_THRESHOLD_P_LVTTL_33 "XHPTDC8_THRESHOLD_P_LVTTL_33" 
    cdef int XHPTDC8_THRESHOLD_P_LVTTL_25 "XHPTDC8_THRESHOLD_P_LVTTL_25" 
    cdef int XHPTDC8_THRESHOLD_P_SSTL_3 "XHPTDC8_THRESHOLD_P_SSTL_3" 
    cdef int XHPTDC8_THRESHOLD_P_SSTL_2 "XHPTDC8_THRESHOLD_P_SSTL_2" 
    cdef int XHPTDC8_THRESHOLD_N_NIM "XHPTDC8_THRESHOLD_N_NIM" 
    cdef int XHPTDC8_THRESHOLD_N_CMOS "XHPTDC8_THRESHOLD_N_CMOS" 
    cdef int XHPTDC8_THRESHOLD_N_LVCMOS_33 "XHPTDC8_THRESHOLD_N_LVCMOS_33" 
    cdef int XHPTDC8_THRESHOLD_N_LVCMOS_25 "XHPTDC8_THRESHOLD_N_LVCMOS_25" 
    cdef int XHPTDC8_THRESHOLD_N_LVCMOS_18 "XHPTDC8_THRESHOLD_N_LVCMOS_18" 
    cdef int XHPTDC8_THRESHOLD_N_TTL "XHPTDC8_THRESHOLD_N_TTL" 
    cdef int XHPTDC8_THRESHOLD_N_LVTTL_33 "XHPTDC8_THRESHOLD_N_LVTTL_33" 
    cdef int XHPTDC8_THRESHOLD_N_LVTTL_25 "XHPTDC8_THRESHOLD_N_LVTTL_25" 
    cdef int XHPTDC8_THRESHOLD_N_SSTL_3 "XHPTDC8_THRESHOLD_N_SSTL_3" 
    cdef int XHPTDC8_THRESHOLD_N_SSTL_2 "XHPTDC8_THRESHOLD_N_SSTL_2" 
    cdef int XHPTDC8_TRIGGER_SOURCE_NONE "XHPTDC8_TRIGGER_SOURCE_NONE" 
    cdef int XHPTDC8_TRIGGER_SOURCE_A "XHPTDC8_TRIGGER_SOURCE_A" 
    cdef int XHPTDC8_TRIGGER_SOURCE_B "XHPTDC8_TRIGGER_SOURCE_B" 
    cdef int XHPTDC8_TRIGGER_SOURCE_C "XHPTDC8_TRIGGER_SOURCE_C" 
    cdef int XHPTDC8_TRIGGER_SOURCE_D "XHPTDC8_TRIGGER_SOURCE_D" 
    cdef int XHPTDC8_TRIGGER_SOURCE_E "XHPTDC8_TRIGGER_SOURCE_E" 
    cdef int XHPTDC8_TRIGGER_SOURCE_F "XHPTDC8_TRIGGER_SOURCE_F" 
    cdef int XHPTDC8_TRIGGER_SOURCE_G "XHPTDC8_TRIGGER_SOURCE_G" 
    cdef int XHPTDC8_TRIGGER_SOURCE_H "XHPTDC8_TRIGGER_SOURCE_H" 
    cdef int XHPTDC8_TRIGGER_SOURCE_TDC1_SYNC "XHPTDC8_TRIGGER_SOURCE_TDC1_SYNC" 
    cdef int XHPTDC8_TRIGGER_SOURCE_TDC2_SYNC "XHPTDC8_TRIGGER_SOURCE_TDC2_SYNC" 
    cdef int XHPTDC8_TRIGGER_SOURCE_TDC_EXT_SYNC "XHPTDC8_TRIGGER_SOURCE_TDC_EXT_SYNC" 
    cdef int XHPTDC8_TRIGGER_SOURCE_ADC1_CNV "XHPTDC8_TRIGGER_SOURCE_ADC1_CNV" 
    cdef int XHPTDC8_TRIGGER_SOURCE_ADC2_CNV "XHPTDC8_TRIGGER_SOURCE_ADC2_CNV" 
    cdef int XHPTDC8_TRIGGER_SOURCE_SOFTWARE "XHPTDC8_TRIGGER_SOURCE_SOFTWARE" 
    cdef int XHPTDC8_TRIGGER_SOURCE_AUTO "XHPTDC8_TRIGGER_SOURCE_AUTO" 
    cdef int XHPTDC8_TRIGGER_SOURCE_ONE "XHPTDC8_TRIGGER_SOURCE_ONE" 
    cdef int XHPTDC8_TDCHIT_TYPE_RISING "XHPTDC8_TDCHIT_TYPE_RISING" 
    cdef int XHPTDC8_TDCHIT_TYPE_ERROR "XHPTDC8_TDCHIT_TYPE_ERROR" 
    cdef int XHPTDC8_TDCHIT_TYPE_ERROR_TIMESTAMP_LOST "XHPTDC8_TDCHIT_TYPE_ERROR_TIMESTAMP_LOST" 
    cdef int XHPTDC8_TDCHIT_TYPE_ERROR_ROLLOVER_LOST "XHPTDC8_TDCHIT_TYPE_ERROR_ROLLOVER_LOST" 
    cdef int XHPTDC8_TDCHIT_TYPE_ERROR_PACKETS_LOST "XHPTDC8_TDCHIT_TYPE_ERROR_PACKETS_LOST" 
    cdef int XHPTDC8_TDCHIT_TYPE_ERROR_SHORTENED "XHPTDC8_TDCHIT_TYPE_ERROR_SHORTENED" 
    cdef int XHPTDC8_TDCHIT_TYPE_ERROR_DMA_FIFO_FULL "XHPTDC8_TDCHIT_TYPE_ERROR_DMA_FIFO_FULL" 
    cdef int XHPTDC8_TDCHIT_TYPE_ERROR_HOST_BUFFER_FULL "XHPTDC8_TDCHIT_TYPE_ERROR_HOST_BUFFER_FULL" 
    cdef int XHPTDC8_TDCHIT_TYPE_ADC_INTERNAL "XHPTDC8_TDCHIT_TYPE_ADC_INTERNAL" 
    cdef int XHPTDC8_TDCHIT_TYPE_ADC_ERROR "XHPTDC8_TDCHIT_TYPE_ADC_ERROR" 
    cdef int XHPTDC8_TDCHIT_TYPE_ADC_ERROR_UNUSED "XHPTDC8_TDCHIT_TYPE_ADC_ERROR_UNUSED" 
    cdef int XHPTDC8_TDCHIT_TYPE_ADC_ERROR_INVALID_TRIGGER "XHPTDC8_TDCHIT_TYPE_ADC_ERROR_INVALID_TRIGGER" 
    cdef int XHPTDC8_TDCHIT_TYPE_ADC_ERROR_DATA_LOST "XHPTDC8_TDCHIT_TYPE_ADC_ERROR_DATA_LOST" 
    cdef int XHPTDC8_OK "XHPTDC8_OK" 
    cdef int XHPTDC8_WINDRIVER_NOT_FOUND "XHPTDC8_WINDRIVER_NOT_FOUND" 
    cdef int XHPTDC8_DEVICE_NOT_FOUND "XHPTDC8_DEVICE_NOT_FOUND" 
    cdef int XHPTDC8_WRONG_STATE "XHPTDC8_WRONG_STATE" 
    cdef int XHPTDC8_INVALID_DEVICE "XHPTDC8_INVALID_DEVICE" 
    cdef int XHPTDC8_BUFFER_ALLOC_FAILED "XHPTDC8_BUFFER_ALLOC_FAILED" 
    cdef int XHPTDC8_TDC_NO_EDGE_FOUND "XHPTDC8_TDC_NO_EDGE_FOUND" 
    cdef int XHPTDC8_INVALID_BUFFER_PARAMETERS "XHPTDC8_INVALID_BUFFER_PARAMETERS" 
    cdef int XHPTDC8_INVALID_CONFIG_PARAMETERS "XHPTDC8_INVALID_CONFIG_PARAMETERS" 
    cdef int XHPTDC8_TDC_ALIGNMENT_FAILED "XHPTDC8_TDC_ALIGNMENT_FAILED" 
    cdef int XHPTDC8_HARDWARE_FAILURE "XHPTDC8_HARDWARE_FAILURE" 
    cdef int XHPTDC8_INVALID_ADC_MODE "XHPTDC8_INVALID_ADC_MODE" 
    cdef int XHPTDC8_SYNCHRONIZATION_FAILED "XHPTDC8_SYNCHRONIZATION_FAILED" 
    cdef int XHPTDC8_DEVICE_OPEN_FAILED "XHPTDC8_DEVICE_OPEN_FAILED" 
    cdef int XHPTDC8_INTERNAL_ERROR "XHPTDC8_INTERNAL_ERROR" 
    cdef int XHPTDC8_CALIBRATION_FAILURE "XHPTDC8_CALIBRATION_FAILURE" 
    cdef int XHPTDC8_INVALID_ARGUMENTS "XHPTDC8_INVALID_ARGUMENTS" 
    cdef int XHPTDC8_INSUFFICIENT_DATA "XHPTDC8_INSUFFICIENT_DATA" 
    cdef int XHPTDC8_DEVICE_STATE_CREATED "XHPTDC8_DEVICE_STATE_CREATED" 
    cdef int XHPTDC8_DEVICE_STATE_INITIALIZED "XHPTDC8_DEVICE_STATE_INITIALIZED" 
    cdef int XHPTDC8_DEVICE_STATE_CONFIGURED "XHPTDC8_DEVICE_STATE_CONFIGURED" 
    cdef int XHPTDC8_DEVICE_STATE_CAPTURING "XHPTDC8_DEVICE_STATE_CAPTURING" 
    cdef int XHPTDC8_DEVICE_STATE_PAUSED "XHPTDC8_DEVICE_STATE_PAUSED" 
    cdef int XHPTDC8_DEVICE_STATE_CLOSED "XHPTDC8_DEVICE_STATE_CLOSED" 
    cdef int XHPTDC8_USER_FLASH_SIZE "XHPTDC8_USER_FLASH_SIZE" 
    cdef int XHPTDC8_NOF_CHANNELS_PER_CARD "XHPTDC8_NOF_CHANNELS_PER_CARD" 
    cdef int XHPTDC8_API "XHPTDC8_API" 
    cdef int XHPTDC8_API "XHPTDC8_API" 
    cdef int XHPTDC8_CALIBARTION_DATE_LEN "XHPTDC8_CALIBARTION_DATE_LEN" 
    cdef int XHPTDC8_GATE_OFF "XHPTDC8_GATE_OFF" 
    cdef int XHPTDC8_GATE_ON "XHPTDC8_GATE_ON" 
    cdef int XHPTDC8_TIGER_OFF "XHPTDC8_TIGER_OFF" 
    cdef int XHPTDC8_TIGER_OUTPUT "XHPTDC8_TIGER_OUTPUT" 
    cdef int XHPTDC8_TIGER_BIDI "XHPTDC8_TIGER_BIDI" 
    cdef int XHPTDC8_TIGER_BIPOLAR "XHPTDC8_TIGER_BIPOLAR" 
    cdef int XHPTDC8_TIGER_MAX_BIPOLAR_PULSE_LENGTH "XHPTDC8_TIGER_MAX_BIPOLAR_PULSE_LENGTH" 
    cdef int XHPTDC8_GROUPING_VETO_OFF "XHPTDC8_GROUPING_VETO_OFF" 
    cdef int XHPTDC8_GROUPING_VETO_INSIDE "XHPTDC8_GROUPING_VETO_INSIDE" 
    cdef int XHPTDC8_GROUPING_VETO_OUTSIDE "XHPTDC8_GROUPING_VETO_OUTSIDE" 
    cdef int XHPTDC8_ALIGN_TIGER "XHPTDC8_ALIGN_TIGER" 
    cdef int XHPTDC8_ALIGN_PIN "XHPTDC8_ALIGN_PIN" 
    cdef int XHPTDC8_ALIGN_RESERVED "XHPTDC8_ALIGN_RESERVED" 