import ctypes
import enum
import pyrsistent
import sdl2


class MouseButton(enum.IntEnum):
    LEFT = sdl2.SDL_BUTTON_LEFT
    MIDDLE = sdl2.SDL_BUTTON_MIDDLE
    RIGHT = sdl2.SDL_BUTTON_RIGHT
    X1 = sdl2.SDL_BUTTON_X1
    X2 = sdl2.SDL_BUTTON_X2


class MouseButtonMask(enum.Flag):
    NONE = 0
    LEFT = sdl2.SDL_BUTTON_LMASK
    MIDDLE = sdl2.SDL_BUTTON_MMASK
    RIGHT = sdl2.SDL_BUTTON_RMASK
    BUTTON4 = sdl2.SDL_BUTTON_X1MASK
    BUTTON5 = sdl2.SDL_BUTTON_X2MASK


class Mouse(pyrsistent.PClass):
    x_position = pyrsistent.field(type=int, mandatory=True)
    y_position = pyrsistent.field(type=int, mandatory=True)
    left = pyrsistent.field(type=bool, mandatory=True, initial=False)
    middle = pyrsistent.field(type=bool, mandatory=True, initial=False)
    right = pyrsistent.field(type=bool, mandatory=True, initial=False)
    button4 = pyrsistent.field(type=bool, mandatory=True, initial=False)
    button5 = pyrsistent.field(type=bool, mandatory=True, initial=False)

    @classmethod
    def now(cls):
        x, y = ctypes.c_int(0), ctypes.c_int(0)
        state = MouseButtonMask(
            sdl2.SDL_GetMouseState(ctypes.byref(x), ctypes.byref(y))
        )
        return cls(
            x_position=x.value,
            y_position=y.value,
            left=bool(MouseButtonMask.LEFT & state),
            middle=bool(MouseButtonMask.MIDDLE & state),
            right=bool(MouseButtonMask.RIGHT & state),
            button4=bool(MouseButtonMask.BUTTON4 & state),
            button5=bool(MouseButtonMask.BUTTON5 & state),
        )

