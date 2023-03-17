import ctypes
import enum
import pyrsistent
import sdl2

from .image import Texture

class WindowFlag(enum.Flag):
    FULLSCREEN = sdl2.SDL_WINDOW_FULLSCREEN
    FULLSCREEN_DESKTOP = sdl2.SDL_WINDOW_FULLSCREEN_DESKTOP
    OPENGL = sdl2.SDL_WINDOW_OPENGL
    VULKAN = sdl2.SDL_WINDOW_VULKAN
    SHOWN = sdl2.SDL_WINDOW_SHOWN
    HIDDEN = sdl2.SDL_WINDOW_HIDDEN
    BORDERLESS = sdl2.SDL_WINDOW_BORDERLESS
    RESIZABLE = sdl2.SDL_WINDOW_RESIZABLE
    MINIMIZED = sdl2.SDL_WINDOW_MINIMIZED
    MAXIMIZED = sdl2.SDL_WINDOW_MAXIMIZED
    INPUT_GRABBED = sdl2.SDL_WINDOW_INPUT_GRABBED
    INPUT_FOCUS = sdl2.SDL_WINDOW_INPUT_FOCUS
    MOUSE_FOCUS = sdl2.SDL_WINDOW_MOUSE_FOCUS
    ALLOW_HIGH_DPI = sdl2.SDL_WINDOW_ALLOW_HIGHDPI
    MOUSE_CAPTURE = sdl2.SDL_WINDOW_MOUSE_CAPTURE
    DEFAULT = SHOWN | RESIZABLE


class Window(pyrsistent.PClass):
    window = pyrsistent.field(type=ctypes.POINTER(sdl2.SDL_Window), mandatory=True)
    window_id = pyrsistent.field(type=int, mandatory=True)
    renderer = pyrsistent.field(type=ctypes.POINTER(sdl2.SDL_Renderer), mandatory=True)
    window_number = pyrsistent.field(type=int, mandatory=True)

    @property
    def size(self):
        w = ctypes.c_int(0)
        h = ctypes.c_int(0)
        sdl2.SDL_GetWindowSize(self.window, ctypes.byref(w), ctypes.byref(h))
        return w.value, h.value

    def create_texture(self, w: int, h: int):
        texture = sdl2.SDL_CreateTexture(
            self.renderer,
            sdl2.SDL_PIXELFORMAT_RGBA8888,
            sdl2.SDL_TEXTUREACCESS_TARGET,
            w,
            h,
        )
        return Texture(texture)

    def create_texture_from_image(self, filename: str):
        texture = img.IMG_LoadTexture(self.renderer, filename.encode("utf-8"))
        return Texture(texture)

    @property
    def draw_color(self):
        r = ctypes.c_uint8(0)
        g = ctypes.c_uint8(0)
        b = ctypes.c_uint8(0)
        a = ctypes.c_uint8(0)
        sdl2.SDL_GetRenderDrawColor(
            self.renderer,
            ctypes.byref(r),
            ctypes.byref(g),
            ctypes.byref(b),
            ctypes.byref(a),
        )
        return r, g, b, a

    def set_draw_color(self, r: int, g: int, b: int, a: int):
        sdl2.SDL_SetRenderDrawColor(self.renderer, r, g, b, a)

    def copy(
        self,
        texture,
        src_x: int,
        src_y: int,
        src_w: int,
        src_h: int,
        dst_x: int,
        dst_y: int,
        dst_w: int,
        dst_h: int,
    ):
        src = sdl2.SDL_Rect(src_x, src_y, src_w, src_h)
        dst = sdl2.SDL_Rect(dst_x, dst_y, dst_w, dst_h)
        sdl2.SDL_RenderCopy(
            self.renderer, texture.texture, ctypes.byref(src), ctypes.byref(dst)
        )

    def set_target(self, target: Texture):
        if target is None:
            sdl2.SDL_SetRenderTarget(self.renderer, None)
        else:
            sdl2.SDL_SetRenderTarget(self.renderer, target.texture)

    def clear(self):
        sdl2.SDL_RenderClear(self.renderer)

    def present(self):
        sdl2.SDL_RenderPresent(self.renderer)
