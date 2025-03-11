from setuptools import Extension, setup  # noqa: I001
from Cython.Build import cythonize
from Cython.Distutils import build_ext
import shutil
import os

extensions = [
    Extension(
        "cabouter.tdc.driver_interface",
        ["./cabouter/tdc/driver_interface.pyx"],
        include_dirs=["xhptdc8_babel/include"],
        libraries=["xhptdc8_driver_64"],
        library_dirs=["xhptdc8_babel/lib"],
    ),
    Extension(
        "cabouter.tdc.tdc_util",
        ["./cabouter/tdc/tdc_util.pyx"],
        include_dirs=[
            "xhptdc8_babel/include",
            "./cabouter/tdc/tdc_util",
            "xhptdc8_babel/util/util/src/ryml_src",
        ],
        libraries=["xhptdc8_driver_64", "xhptdc8_util"],
        library_dirs=["xhptdc8_babel/lib"],
    ),
]

if not os.path.isdir("cabouter/cabouter/tdc"):
    os.makedirs("cabouter/cabouter/tdc")
shutil.copy("xhptdc8_babel/bin/xhptdc8_driver_64.dll", "cabouter/cabouter/tdc")

setup(
    name="cabouter",
    ext_modules=cythonize(extensions, include_path=["./src"], build_dir="build"),
    package_dir={"": "cabouter"},
    include_dirs=["./cabouter", "./lib"],
    cmdclass={"build_ext": build_ext},
    zip_safe=False,
    include_package_data=True,
)
