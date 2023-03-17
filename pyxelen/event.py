import ctypes
import pyrsistent
import sdl2

from . import registry

from .controller import (
    Controller,
    ControllerButton,
)
from .keyboard import (
    Key,
    KeyMask,
    KeyModifiers,
)
from .mouse import (
    Mouse,
    MouseButton,
    MouseButtonMask,
)
from .window import Window


KEYS = {k.value: k for k in Key}
MOUSE_BUTTONS = {b.value: b for b in MouseButton}


def make_handler():
    handlers = {}

    def handle(*kinds):
        def wrapper(cls):
            nonlocal handlers
            for kind in kinds:
                handlers[kind] = cls
            return cls

        return wrapper

    return handlers, handle


handlers, handle = make_handler()
window_handlers, window_handle = make_handler()


class CommonEvent(pyrsistent.PClass):
    name = pyrsistent.field(type=str, mandatory=True)
    timestamp = pyrsistent.field(type=int, mandatory=True)


class CommonWindowEvent(CommonEvent):
    window = pyrsistent.field(type=Window, mandatory=True)


@handle(sdl2.SDL_AUDIODEVICEADDED, sdl2.SDL_AUDIODEVICEREMOVED)
class AudioDeviceEvent(CommonEvent):
    device_id = pyrsistent.field(type=int, mandatory=True)
    is_capture = pyrsistent.field(type=bool, mandatory=True)

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event):
        name = (
            "on_audio_device_added"
            if event.type == sdl2.SDL_AUDIODEVICEADDED
            else "on_audio_device_removed"
        )
        return cls(
            name=name,
            timestamp=event.common.timestamp,
            device_id=event.adevice.which,
            is_capture=event.adevice.iscapture == 1,
        )


@handle(sdl2.SDL_CONTROLLERBUTTONDOWN, sdl2.SDL_CONTROLLERBUTTONUP)
class ControllerButtonEvent(CommonEvent):
    controller = pyrsistent.field(type=Controller, mandatory=True)
    button = pyrsistent.field(type=ControllerButton, mandatory=True)

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event):
        print(event)
        name = (
            "on_controller_button_up"
            if event.type == sdl2.SDL_CONTROLLERBUTTONUP
            else "on_controller_button_down"
        )
        controller = Controller.find(event.cbutton.which)
        button = CONTROLLER_BUTTONS.get(event.cbutton.button)
        return cls(
            name=name,
            timestamp=event.common.timestamp,
            controller=controller,
            button=button,
        )


@handle(sdl2.SDL_CONTROLLERDEVICEADDED, sdl2.SDL_CONTROLLERDEVICEREMOVED)
class ControllerDeviceEvent(CommonEvent):
    controller = pyrsistent.field(type=Controller, mandatory=True)

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event):
        print(event)
        if event.type == sdl2.SDL_CONTROLLERDEVICEADDED:
            controller_ptr = sdl2.SDL_GameControllerOpen(event.cdevice.which)
            joystick = sdl2.SDL_GameControllerGetJoystick(controller_ptr)
            instance = sdl2.SDL_JoystickInstanceID(joystick)
            controller = registry.add_controller(instance)
            return cls(
                name="on_controller_device_added",
                timestamp=event.common.timestamp,
                controller=controller,
            )
        else:
            controller = registry.delete_controller(event.cdevice.which)
            return cls(
                name="on_controller_device_removed",
                timestamp=event.common.timestamp,
                controller=controller,
            )


@handle(sdl2.SDL_JOYHATMOTION)
class ControllerDPadEvent(CommonEvent):
    x = pyrsistent.field(type=int, mandatory=True)
    y = pyrsistent.field(type=int, mandatory=True)

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event):
        print(event)
        controller = Controller.find(event.jhat.which)
        x, y = HAT_DIRECTIONS.get(event.jhat.value, (0, 0))
        return cls(
            name="on_controller_dpad",
            timestamp=event.common.timestamp,
            controller=controller,
            x=x,
            y=y,
        )


@handle(sdl2.SDL_KEYDOWN, sdl2.SDL_KEYUP)
class KeyEvent(CommonWindowEvent):
    key = pyrsistent.field(type=Key, mandatory=True)
    modifiers = pyrsistent.field(type=KeyModifiers, mandatory=True)
    is_repeat = pyrsistent.field(type=bool)

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event):
        key = KEYS.get(event.key.keysym.sym)
        if not key:
            return

        window = registry.find_window(event.key.windowID)
        if not window:
            return

        try:
            mod = KeyMask(event.key.keysym.mod)
        except ValueError:
            return

        modifiers = KeyModifiers(
            control=bool(KeyMask.CONTROL & mod),
            shift=bool(KeyMask.SHIFT & mod),
            alt=bool(KeyMask.ALT & mod),
        )

        if event.type == sdl2.SDL_KEYDOWN:
            return cls(
                name="on_key_down",
                timestamp=event.common.timestamp,
                window=window,
                key=key,
                modifiers=modifiers,
                is_repeat=(event.key.repeat == 1),
            )
        else:
            return cls(
                name="on_key_up",
                timestamp=event.common.timestamp,
                window=window,
                key=key,
                modifiers=modifiers,
            )


@handle(sdl2.SDL_MOUSEBUTTONDOWN, sdl2.SDL_MOUSEBUTTONUP)
class MouseButtonEvent(CommonWindowEvent):
    button = pyrsistent.field(type=MouseButton, mandatory=True)
    x_position = pyrsistent.field(type=int, mandatory=True)
    y_position = pyrsistent.field(type=int, mandatory=True)

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event):
        button = MOUSE_BUTTONS.get(event.button.button)
        if not button:
            return

        window = registry.find_window(event.key.windowID)
        if not window:
            return

        if event.type == sdl2.SDL_MOUSEBUTTONDOWN:
            return cls(
                name="on_mouse_button_down",
                timestamp=event.common.timestamp,
                window=window,
                button=button,
                x_position=event.button.x,
                y_position=event.button.y,
            )
        else:
            return cls(
                name="on_mouse_button_up",
                timestamp=event.common.timestamp,
                window=window,
                button=button,
                x_position=event.button.x,
                y_position=event.button.y,
            )


@handle(sdl2.SDL_MOUSEMOTION)
class MouseMotionEvent(CommonWindowEvent):
    mouse = pyrsistent.field(type=Mouse, mandatory=True)
    x_distance = pyrsistent.field(type=int, mandatory=True)
    y_distance = pyrsistent.field(type=int, mandatory=True)

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event):
        window = registry.find_window(event.key.windowID)
        if not window:
            return

        try:
            button_mask = MouseButtonMask(event.motion.state)
        except ValueError:
            return

        return cls(
            name="on_mouse_motion",
            timestamp=event.common.timestamp,
            window=window,
            mouse=Mouse(
                x_position=event.motion.x,
                y_position=event.motion.y,
                left=bool(MouseButtonMask.LEFT & button_mask),
                middle=bool(MouseButtonMask.MIDDLE & button_mask),
                right=bool(MouseButtonMask.RIGHT & button_mask),
                button4=bool(MouseButtonMask.BUTTON4 & button_mask),
                button5=bool(MouseButtonMask.BUTTON5 & button_mask),
            ),
            x_distance=event.motion.xrel,
            y_distance=event.motion.yrel,
        )


@handle(sdl2.SDL_MOUSEWHEEL)
class MouseWheelEvent(CommonWindowEvent):
    x_scroll = pyrsistent.field(type=int, mandatory=True)
    y_scroll = pyrsistent.field(type=int, mandatory=True)

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event):
        window = registry.find_window(event.key.windowID)
        if not window:
            return

        return cls(
            name="on_mouse_motion",
            timestamp=event.common.timestamp,
            window=window,
            x_scroll=-event.wheel.x if event.wheel.direction else event.wheel.x,
            y_scroll=-event.wheel.y if event.wheel.direction else event.wheel.y,
        )


@handle(sdl2.SDL_QUIT)
class QuitEvent(CommonEvent):
    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event):
        to_delete = [w.window_id for w in registry.windows if w]
        for window_id in to_delete:
            registry.delete_window(window_id)
        return cls(name="on_quit", timestamp=event.common.timestamp)


@handle(sdl2.SDL_TEXTINPUT)
class TextInputEvent(CommonEvent):
    window = pyrsistent.field(type=Window, mandatory=True)
    text = pyrsistent.field(type=str, mandatory=True)

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event):
        window = registry.find_window(event.key.windowID)
        if not window:
            return

        return cls(
            name="on_text_input",
            timestamp=event.common.timestamp,
            window=window,
            text=event.text.text.decode("utf-8"),
        )


@handle(sdl2.SDL_RENDER_TARGETS_RESET)
class RenderTargetsResetEvent(CommonEvent):

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event):
        return cls(name="on_render_targets_reset", timestamp=event.common.timestamp)


@handle(sdl2.SDL_WINDOWEVENT)
class WindowEvent:

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event):
        global window_handlers

        handler = window_handlers.get(event.window.event)
        if not handler:
            return

        window = registry.find_window(event.window.windowID)
        if not window:
            return

        return handler.from_sdl(event, window)


@window_handle(sdl2.SDL_WINDOWEVENT_SHOWN)
class WindowShownEvent(CommonWindowEvent):

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event, window: Window):
        return cls(name="on_window_shown", window=window, timestamp=event.common.timestamp)


@window_handle(sdl2.SDL_WINDOWEVENT_HIDDEN)
class WindowHiddenEvent(CommonWindowEvent):

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event, window: Window):
        return cls(name="on_window_hidden", window=window, timestamp=event.common.timestamp)


@window_handle(sdl2.SDL_WINDOWEVENT_EXPOSED)
class WindowExposedEvent(CommonWindowEvent):

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event, window: Window):
        return cls(name="on_window_exposed", window=window, timestamp=event.common.timestamp)


@window_handle(sdl2.SDL_WINDOWEVENT_MOVED)
class WindowMovedEvent(CommonWindowEvent):
    x_position = pyrsistent.field(type=int, mandatory=True)
    y_position = pyrsistent.field(type=int, mandatory=True)

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event, window: Window):
        return cls(
            name="on_window_moved", window=window,
            timestamp=event.common.timestamp,
            x_position=event.window.data1,
            y_position=event.window.data2,
        )


@window_handle(sdl2.SDL_WINDOWEVENT_SIZE_CHANGED)
class WindowSizeChangedEvent(CommonWindowEvent):
    width = pyrsistent.field(type=int, mandatory=True)
    height = pyrsistent.field(type=int, mandatory=True)

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event, window: Window):
        return cls(
            name="on_window_size_changed", window=window,
            timestamp=event.common.timestamp,
            width=event.window.data1,
            height=event.window.data2
        )


@window_handle(sdl2.SDL_WINDOWEVENT_MINIMIZED)
class WindowMinimizedEvent(CommonWindowEvent):

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event, window: Window):
        return cls(name="on_window_minimized", window=window, timestamp=event.common.timestamp)


@window_handle(sdl2.SDL_WINDOWEVENT_MAXIMIZED)
class WindowMaximizedEvent(CommonWindowEvent):

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event, window: Window):
        return cls(name="on_window_maximized", window=window, timestamp=event.common.timestamp)


@window_handle(sdl2.SDL_WINDOWEVENT_RESTORED)
class WindowRestoredEvent(CommonWindowEvent):

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event, window: Window):
        return cls(name="on_window_restored", window=window, timestamp=event.common.timestamp)


@window_handle(sdl2.SDL_WINDOWEVENT_ENTER)
class WindowEnteredEvent(CommonWindowEvent):

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event, window: Window):
        return cls(name="on_window_entered", window=window, timestamp=event.common.timestamp)


@window_handle(sdl2.SDL_WINDOWEVENT_LEAVE)
class WindowLeftEvent(CommonWindowEvent):

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event, window: Window):
        return cls(name="on_window_left", window=window, timestamp=event.common.timestamp)


@window_handle(sdl2.SDL_WINDOWEVENT_FOCUS_GAINED)
class WindowFocusGainedEvent(CommonWindowEvent):

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event, window: Window):
        return cls(name="on_window_focus_gained", window=window, timestamp=event.common.timestamp)


@window_handle(sdl2.SDL_WINDOWEVENT_FOCUS_LOST)
class WindowFocusLostEvent(CommonWindowEvent):

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event, window: Window):
        return cls(name="on_window_focus_lost", window=window, timestamp=event.common.timestamp)


@window_handle(sdl2.SDL_WINDOWEVENT_CLOSE)
class WindowClosedEvent(CommonWindowEvent):

    @classmethod
    def from_sdl(cls, event: sdl2.SDL_Event, window: Window):
        registry.delete_window(window.window_id)
        return cls(name="on_window_closed", window=window, timestamp=event.common.timestamp)


def pending_events():
    global handlers

    event = sdl2.SDL_Event()

    while sdl2.SDL_PollEvent(ctypes.byref(event)) != 0:

        handler = handlers.get(event.type)
        if not handler:
            continue

        custom_event = handler.from_sdl(event)
        if not custom_event:
            continue

        yield custom_event

