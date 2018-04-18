@echo off

python setup.py build_ext --inplace
rem copy pyxelen.cp36-win_amd64.pyd ..\pyweek25\pyxelen.cp36-win_amd64.pyd
