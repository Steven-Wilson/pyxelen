import ctypes
import enum
import pyrsistent
import sdl2
import sdl2.sdlimage as img


class ImageFormatFlag(enum.Flag):
    JPG = img.IMG_INIT_JPG
    PNG = img.IMG_INIT_PNG
    TIF = img.IMG_INIT_TIF
    WEBP = img.IMG_INIT_WEBP
    ALL = JPG | PNG | TIF | WEBP


IMAGE_FORMAT_FLAGS = {f.value: f for f in ImageFormatFlag}


class Texture(pyrsistent.PClass):
    texture = pyrsistent.field(type=ctypes.POINTER(sdl2.SDL_Texture), mandatory=True)

    def delete(self):
        sdl2.SDL_DestroyTexture(self.texture)

    @property
    def size(self):
        pixel_format = ctypes.c_uint32(0)
        access = ctypes.c_int(0)
        w = ctypes.c_int(0)
        h = ctypes.c_int(0)
        sdl2.SDL_QueryTexture(
            self.texture,
            ctypes.byref(pixel_format),
            ctypes.byref(access),
            ctypes.byref(w),
            ctypes.byref(h),
        )
        return w.value, h.value





