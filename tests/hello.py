import yaml

from xhptdc8_py.tdc import close, get_fast_info, get_last_error_message, initialize_tdc

initialize_tdc(1024 * 200)
info = get_fast_info(0)
print(info.state)
print(get_last_error_message(0))
close()
