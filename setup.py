from setuptools import Extension, setup  # noqa: I001
from Cython.Build import cythonize
from Cython.Distutils import build_ext
import shutil
import os

extensions = [
    Extension(
        "xhptdc8_py.tdc",
        ["./xhptdc8_py/tdc.pyx"],
        include_dirs=["xhptdc8_babel/include"],
        libraries=["xhptdc8_driver_64"],
        library_dirs=["xhptdc8_babel/lib"],
    ),
    Extension(
        "xhptdc8_py.util",
        ["./xhptdc8_py/util.pyx"],
        include_dirs=[
            "xhptdc8_babel/include",
            "./xhptdc8_py",
            "xhptdc8_babel/util/util/src/ryml_src",
        ],
        libraries=["xhptdc8_driver_64", "xhptdc8_util"],
        library_dirs=["xhptdc8_babel/lib"],
    ),
]

if not os.path.isdir("xhptdc8_py"):
    os.makedirs("xhptdc8_py")

shutil.copy("xhptdc8_babel/bin/xhptdc8_driver_64.dll", "xhptdc8_py")
shutil.copy("xhptdc8_babel/bin/xhptdc8_util.dll", "xhptdc8_py")

setup(
    name="xhptdc8_py",
    ext_modules=cythonize(extensions, include_path=["./xhptdc8_py"], build_dir="build"),
    package_dir={"xhptdc8_py": "xhptdc8_py"},
    package_data={"xhptdc8_py": ["tdc.pyi"]},
    include_dirs=["./xhptdc8_py", "./lib"],
    cmdclass={"build_ext": build_ext},
    zip_safe=False,
    include_package_data=True,
)
