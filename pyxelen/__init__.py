import enum
import sdl2

from . import registry
from .window import WindowFlag
from .event import CommonEvent, pending_events


class InitFlag(enum.Flag):
    TIMER = sdl2.SDL_INIT_TIMER
    AUDIO = sdl2.SDL_INIT_AUDIO
    VIDEO = sdl2.SDL_INIT_VIDEO
    JOYSTICK = sdl2.SDL_INIT_JOYSTICK
    HAPTIC = sdl2.SDL_INIT_HAPTIC
    GAMEPAD = sdl2.SDL_INIT_GAMECONTROLLER
    EVENT = sdl2.SDL_INIT_EVENTS
    ALL = TIMER | AUDIO | VIDEO | EVENT | JOYSTICK | HAPTIC | GAMEPAD | EVENT
    DEFAULT = TIMER | AUDIO | VIDEO | GAMEPAD | JOYSTICK


INIT_FLAGS = {f.value: f for f in InitFlag}

sdl2.SDL_Init(InitFlag.DEFAULT.value)


def open_window(title: str, width: int, height: int, flags: WindowFlag):
    return registry.add_window(title, width, height, flags)


def fixed_frame(ms_per_frame: int):

    current_time = sdl2.SDL_GetTicks()
    next_frame_time = current_time + ms_per_frame
    yield CommonEvent(name='on_frame_start', timestamp=current_time)

    for event in pending_events():
        yield event

    current_time = sdl2.SDL_GetTicks()
    yield CommonEvent(name='on_frame_render_start', timestamp=current_time)

    current_time = sdl2.SDL_GetTicks()
    yield CommonEvent(name='on_frame_render_end', timestamp=current_time)

    if current_time < next_frame_time:
        wait_time = next_frame_time - current_time
        sdl2.SDL_Delay(wait_time)

    current_time = sdl2.SDL_GetTicks()
    yield CommonEvent(name='on_frame_end', timestamp=current_time)


def run_fixed_frame_rate(ms_per_frame: int):
    while True:
        for event in fixed_frame(ms_per_frame):
            yield event
            if event.name == 'on_quit':
                return

