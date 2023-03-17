import ctypes
import enum
import pyrsistent
import sdl2
import sdl2.sdlmixer as mix


class MusicFormatFlag(enum.Flag):
    FLAC = mix.MIX_INIT_FLAC
    MOD = mix.MIX_INIT_MOD
    MP3 = mix.MIX_INIT_MP3
    OGG = mix.MIX_INIT_OGG
    ALL = FLAC | MOD | MP3 | OGG


MUSIC_FORMAT_FLAGS = {f.value: f for f in MusicFormatFlag}


class FadingStyle(enum.IntEnum):
    NONE = mix.MIX_NO_FADING
    OUT = mix.MIX_FADING_OUT
    IN = mix.MIX_FADING_IN


FADING_STYLES = {f.value: f for f in FadingStyle}


class MusicFormat(enum.IntEnum):
    CMD = mix.MUS_CMD
    WAV = mix.MUS_WAV
    MOD = mix.MUS_MOD
    MID = mix.MUS_MID
    MP3 = mix.MUS_MP3
    FLAC = mix.MUS_FLAC


MUSIC_FORMATS = {f.value: f for f in MusicFormat}


class Effect(pyrsistent.PClass):
    chunk = pyrsistent.field(type=ctypes.POINTER(mix.Mix_Chunk), mandatory=True)

    @classmethod
    def from_wav_file(cls, filename: str):
        rw = sdl2.SDL_RWFromFile(filename.encode("utf-8"), "rb")
        chunk = mix.Mix_LoadWAV_RW(rw, 1)
        sdl2.SDL_RWclose(rw)
        return cls(chunk=chunk)

    def close(self):
        mix.Mix_FreeChunk(self.chunk)

    def play(self, volume: int):
        mix.Mix_VolumeChunk(self.chunk, volume)
        mix.Mix_PlayChannelTimed(-1, self.chunk, 0, -1)


class Music(pyrsistent.PClass):
    music = pyrsistent.field(type=ctypes.POINTER(mix.Mix_Music), mandatory=True)

    @staticmethod
    def set_volume(cls, volume: int):
        mix.Mix_VolumeMusic(volume)

    @staticmethod
    def stop():
        mix.Mix_HaltMusic()

    @classmethod
    def from_file(cls, filename: str):
        music = mix.Mix_LoadMUS(filename.encode("utf-8"))
        return Music(music)

    def close(self):
        mix.Mix_FreeMusic(self.music)

    def play(self):
        mix.Mix_PlayMusic(self.music, -1)

