from setuptools import setup

setup(
    name='pyxelen',
    version='0.0.1',
    url='https://github.com/Steven-Wilson/pyxelen',
    author='Steven Wilson',
    description='A Python game engine aimed at low-res 2D games',
    packages=['pyxelen'],
    install_requires=[
        'pygame >= 1.9.3',
        'pyrsistent >= 0.14.2'
    ],
)
