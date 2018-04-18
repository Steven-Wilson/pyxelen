from distutils.core import setup, Extension
from Cython.Build import cythonize


setup(
    name='pyxelen',
    version='0.0.1',
    url='https://github.com/Steven-Wilson/pyxelen',
    author='Steven Wilson',
    description='A Python game engine aimed at low-res 2D games',
    ext_modules=cythonize([
        Extension(
            name='pyxelen',
            sources=['pyxelen.pyx'],
            include_dirs=['include'],
            library_dirs=['lib\\x64'],
            libraries=[
                'SDL2',
                'SDL2_mixer',
                'SDL2_image',
            ]
        )
    ])
)
