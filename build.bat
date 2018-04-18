@echo off

rem python setup.py build_ext --inplace
rem python demo_app.py

cython --embed pyxelen.pyx


"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.13.26128\bin\HostX86\x64\cl.exe" /W3 /I"C:\Users\steven\AppData\Local\Programs\Python\Python36\include" /I"include" /I"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.13.26128\include" /I"C:\Program Files (x86)\Windows Kits\NETFXSDK\4.6.1\include\um" /I"C:\Program Files (x86)\Windows Kits\10\include\10.0.16299.0\ucrt" /I"C:\Program Files (x86)\Windows Kits\10\include\10.0.16299.0\shared" /I"C:\Program Files (x86)\Windows Kits\10\include\10.0.16299.0\um" /I"C:\Program Files (x86)\Windows Kits\10\include\10.0.16299.0\winrt" /I"C:\Program Files (x86)\Windows Kits\10\include\10.0.16299.0\cppwinrt" /Tc pyxelen.c /link /libpath:lib\x64 /libpath:C:\Users\steven\AppData\Local\Programs\Python\Python36\libs /DEFAULTLIB:SDL2.lib /DEFAULTLIB:SDL2_image.lib /DEFAULTLIB:SDL2_mixer.lib /DEFAULTLIB:SDL2_ttf.lib /out:pyxelen.exe
