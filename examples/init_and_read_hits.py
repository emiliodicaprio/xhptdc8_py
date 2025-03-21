import xhptdc8_py.tdc as tdc
import xhptdc8_py.util as util

init_params = tdc.get_default_init_parameters()
init_params.buffer_size = 0

tdc.init_xhptdc8(init_params)

tdc.close()
