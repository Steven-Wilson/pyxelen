from distutils.core import setup, Extension

USE_CYTHON = True

ext = '.pyx' if USE_CYTHON else '.c'

extensions = [
    Extension(
        name='cython_sdl2_backend',
        sources=['cython_sdl2_backend' + ext],
        include_dirs=['include'],
        library_dirs=['lib\\x64'],
        libraries=[
            'SDL2',
            'SDL2_ttf',
            'SDL2_mixer',
            'SDL2_image',
        ]
    )
]


if USE_CYTHON:
    from Cython.Build import cythonize
    extensions = cythonize(extensions)


setup(
    name='pyxelen',
    version='0.0.1',
    url='https://github.com/Steven-Wilson/pyxelen',
    author='Steven Wilson',
    description='A Python game engine aimed at low-res 2D games',
    packages=['pyxelen'],
    ext_modules=extensions
)
