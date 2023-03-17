import enum
import sdl2
import pyrsistent


class ControllerButton(enum.IntEnum):
    A = sdl2.SDL_CONTROLLER_BUTTON_A
    B = sdl2.SDL_CONTROLLER_BUTTON_B
    X = sdl2.SDL_CONTROLLER_BUTTON_X
    Y = sdl2.SDL_CONTROLLER_BUTTON_Y
    SELECT = sdl2.SDL_CONTROLLER_BUTTON_BACK
    START = sdl2.SDL_CONTROLLER_BUTTON_START
    LEFT_STICK = sdl2.SDL_CONTROLLER_BUTTON_LEFTSTICK
    RIGHT_STICK = sdl2.SDL_CONTROLLER_BUTTON_RIGHTSTICK
    LEFT_SHOULDER = sdl2.SDL_CONTROLLER_BUTTON_LEFTSHOULDER
    RIGHT_SHOULDER = sdl2.SDL_CONTROLLER_BUTTON_RIGHTSHOULDER


class Controller(pyrsistent.PClass):
    instance_id = pyrsistent.field(type=int, mandatory=True)
    controller_number = pyrsistent.field(type=int, mandatory=True)


CONTROLLER_BUTTONS = {b.value: b for b in ControllerButton}


HAT_DIRECTIONS = {
    sdl2.SDL_HAT_LEFTUP: (-1, 1),
    sdl2.SDL_HAT_UP: (0, 1),
    sdl2.SDL_HAT_RIGHTUP: (1, 1),
    sdl2.SDL_HAT_LEFT: (-1, 0),
    sdl2.SDL_HAT_CENTERED: (0, 0),
    sdl2.SDL_HAT_RIGHT: (1, 0),
    sdl2.SDL_HAT_LEFTDOWN: (-1, -1),
    sdl2.SDL_HAT_DOWN: (0, -1),
    sdl2.SDL_HAT_RIGHTDOWN: (1, -1),
}

