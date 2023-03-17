"""Internal, do not touch unless you really know what you're doing
even then, you're probably better just utilizing SDL directly
"""

import sdl2

from .window import Window, WindowFlag
from .controller import Controller


controllers = [None for _ in range(32)]
windows = [None for _ in range(32)]

def add_controller(instance_id: int):
    global controllers
    for controller_number, controller in enumerate(controllers):
        if controller is not None:
            continue
        controller = Controller(
            instance_id=instance_id, controller_number=controller_number
        )
        controllers[controller_number] = controller
        return controller

def add_window(title: str, width: int, height: int, flags: WindowFlag):
    global windows
    for window_number, window in enumerate(windows):
        if window is not None:
            continue
        window_ref = sdl2.SDL_CreateWindow(
            title.encode("utf-8"),
            sdl2.SDL_WINDOWPOS_UNDEFINED,
            sdl2.SDL_WINDOWPOS_UNDEFINED,
            width,
            height,
            flags.value,
        )
        window_id = sdl2.SDL_GetWindowID(window_ref)
        render_flags = (
            sdl2.SDL_RENDERER_ACCELERATED | sdl2.SDL_RENDERER_TARGETTEXTURE
        )
        renderer = sdl2.SDL_CreateRenderer(window_ref, -1, render_flags)
        window = Window(
            window=window_ref,
            window_id=window_id,
            renderer=renderer,
            window_number=window_number,
        )
        windows[window_number] = window
        return window

def delete_controller(instance_id: int):
    global controllers
    controller = find_controller(instance_id)
    if controller:
        controllers[controller.controller_number] = None
        return controller

def delete_window(window_id: int):
    global windows
    window = find_window(window_id)
    if window:
        windows[window.window_number] = None
        sdl2.SDL_DestroyRenderer(window.renderer)
        sdl2.SDL_DestroyWindow(window.window)
        return window

def find_controller(instance_id: int):
    global controllers
    for controller in controllers:
        if controller is not None and controller.instance_id == instance_id:
            return controller

def find_window(window_id: int):
    global windows
    for window in windows:
        if window is not None and window.window_id == window_id:
            return window

