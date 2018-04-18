import enum
import sys
import importlib


from libc.stdint cimport uint8_t
from libc.stdint cimport uint16_t
from libc.stdint cimport uint32_t
from libc.stdint cimport uint64_t
from libc.stdint cimport int8_t
from libc.stdint cimport int16_t
from libc.stdint cimport int32_t
from libc.stdint cimport int64_t
from libc.math cimport sqrt
from libc.math cimport atan2


cdef extern from "SDL.h":

    ctypedef struct SDL_Joystick:
        pass

    ctypedef struct SDL_GameController:
        pass

    ctypedef struct SDL_RWops:
        # This is not opaque in SDL_rwops.h but I don't need to reach in
        pass

    struct SDL_Window:
        pass

    struct SDL_Renderer:
        pass

    struct SDL_Surface:
        pass

    struct SDL_Rect:
        int x, y, w, h

    struct SDL_Color:
        uint8_t r, g, b, a

    struct SDL_Texture:
        pass

    struct SDL_AudioDeviceEvent:
        uint32_t type
        uint32_t timestamp
        uint32_t which
        uint8_t iscapture

    struct SDL_ControllerButtonEvent:
        uint32_t type
        uint32_t timestamp
        int32_t which
        uint8_t button
        uint8_t state

    struct SDL_ControllerDeviceEvent:
        uint32_t type
        uint32_t timestamp
        int32_t which

    struct SDL_Keysym:
        int scancode
        int32_t sym
        uint16_t mod
        uint32_t unused

    struct SDL_KeyboardEvent:
        uint32_t type
        uint32_t timestamp
        uint32_t windowID
        uint8_t state
        uint8_t repeat
        SDL_Keysym keysym

    struct SDL_JoyHatEvent:
        uint32_t type
        uint32_t timestamp
        int which
        uint8_t hat
        uint8_t value

    struct SDL_MouseButtonEvent:
        uint32_t type
        uint32_t timestamp
        uint32_t windowID
        uint32_t which
        uint8_t button
        uint8_t state
        uint8_t clicks
        int32_t x
        int32_t y

    struct SDL_MouseMotionEvent:
        uint32_t type
        uint32_t timestamp
        uint32_t windowID
        uint32_t which
        uint32_t state
        int32_t x
        int32_t y
        int32_t xrel
        int32_t yrel

    struct SDL_MouseWheelEvent:
        uint32_t type
        uint32_t timestamp
        uint32_t windowID
        uint32_t which
        int32_t x
        int32_t y
        uint32_t direction

    struct SDL_QuitEvent:
        uint32_t type

    struct SDL_TextInputEvent:
        uint32_t type
        uint32_t timestamp
        uint32_t windowID
        char text[32]

    struct SDL_WindowEvent:
        uint32_t type
        uint32_t timestamp
        uint32_t windowID
        uint8_t event
        int32_t data1
        int32_t data2

    union SDL_Event:
        uint32_t type
        SDL_AudioDeviceEvent adevice
        SDL_ControllerButtonEvent cbutton
        SDL_ControllerDeviceEvent cdevice
        SDL_KeyboardEvent key
        SDL_JoyHatEvent jhat
        SDL_MouseButtonEvent button
        SDL_MouseMotionEvent motion
        SDL_MouseWheelEvent wheel
        SDL_QuitEvent quit
        SDL_TextInputEvent text
        SDL_WindowEvent window

    # Values
    int SDL_TEXTUREACCESS_TARGET

    uint32_t SDL_INIT_AUDIO
    uint32_t SDL_INIT_VIDEO
    uint32_t SDL_INIT_HAPTIC
    uint32_t SDL_INIT_GAMECONTROLLER
    uint32_t SDL_WINDOWPOS_UNDEFINED

    uint32_t SDL_WINDOW_SHOWN
    uint32_t SDL_WINDOW_RESIZABLE

    uint32_t SDL_RENDERER_ACCELERATED
    uint32_t SDL_RENDERER_TARGETTEXTURE

    uint32_t SDL_PIXELFORMAT_RGBA8888

    uint32_t SDL_AUDIODEVICEADDED
    uint32_t SDL_AUDIODEVICEREMOVED
    uint32_t SDL_CONTROLLERBUTTONDOWN
    uint32_t SDL_CONTROLLERBUTTONUP
    uint32_t SDL_CONTROLLERDEVICEADDED
    uint32_t SDL_CONTROLLERDEVICEREMOVED
    uint32_t SDL_JOYHATMOTION
    uint32_t SDL_KEYDOWN
    uint32_t SDL_KEYUP
    uint32_t SDL_MOUSEBUTTONDOWN
    uint32_t SDL_MOUSEBUTTONUP
    uint32_t SDL_MOUSEMOTION
    uint32_t SDL_MOUSEWHEEL
    uint32_t SDL_QUIT
    uint32_t SDL_TEXTINPUT
    uint32_t SDL_RENDER_TARGETS_RESET
    uint32_t SDL_WINDOWEVENT

    uint32_t SDL_WINDOWEVENT_SHOWN
    uint32_t SDL_WINDOWEVENT_HIDDEN
    uint32_t SDL_WINDOWEVENT_EXPOSED
    uint32_t SDL_WINDOWEVENT_MOVED
    uint32_t SDL_WINDOWEVENT_RESIZED
    uint32_t SDL_WINDOWEVENT_SIZE_CHANGED
    uint32_t SDL_WINDOWEVENT_MINIMIZED
    uint32_t SDL_WINDOWEVENT_MAXIMIZED
    uint32_t SDL_WINDOWEVENT_RESTORED
    uint32_t SDL_WINDOWEVENT_ENTER
    uint32_t SDL_WINDOWEVENT_LEAVE
    uint32_t SDL_WINDOWEVENT_FOCUS_GAINED
    uint32_t SDL_WINDOWEVENT_FOCUS_LOST
    uint32_t SDL_WINDOWEVENT_CLOSE

    uint8_t SDL_BUTTON_LEFT
    uint8_t SDL_BUTTON_MIDDLE
    uint8_t SDL_BUTTON_RIGHT
    uint8_t SDL_BUTTON_X1
    uint8_t SDL_BUTTON_X2
    uint8_t SDL_BUTTON_LMASK
    uint8_t SDL_BUTTON_MMASK
    uint8_t SDL_BUTTON_RMASK
    uint8_t SDL_BUTTON_X1MASK
    uint8_t SDL_BUTTON_X2MASK

    uint32_t SDL_MOUSEWHEEL_FLIPPED

    uint8_t SDL_PRESSED
    uint8_t SDL_RELEASED

    int32_t SDLK_UNKNOWN
    int32_t SDLK_RETURN
    int32_t SDLK_ESCAPE
    int32_t SDLK_BACKSPACE
    int32_t SDLK_TAB
    int32_t SDLK_SPACE
    int32_t SDLK_EXCLAIM
    int32_t SDLK_QUOTEDBL
    int32_t SDLK_HASH
    int32_t SDLK_PERCENT
    int32_t SDLK_DOLLAR
    int32_t SDLK_AMPERSAND
    int32_t SDLK_QUOTE
    int32_t SDLK_LEFTPAREN
    int32_t SDLK_RIGHTPAREN
    int32_t SDLK_ASTERISK
    int32_t SDLK_PLUS
    int32_t SDLK_COMMA
    int32_t SDLK_MINUS
    int32_t SDLK_PERIOD
    int32_t SDLK_SLASH
    int32_t SDLK_0
    int32_t SDLK_1
    int32_t SDLK_2
    int32_t SDLK_3
    int32_t SDLK_4
    int32_t SDLK_5
    int32_t SDLK_6
    int32_t SDLK_7
    int32_t SDLK_8
    int32_t SDLK_9
    int32_t SDLK_COLON
    int32_t SDLK_SEMICOLON
    int32_t SDLK_LESS
    int32_t SDLK_EQUALS
    int32_t SDLK_GREATER
    int32_t SDLK_QUESTION
    int32_t SDLK_AT
    int32_t SDLK_LEFTBRACKET
    int32_t SDLK_BACKSLASH
    int32_t SDLK_RIGHTBRACKET
    int32_t SDLK_CARET
    int32_t SDLK_UNDERSCORE
    int32_t SDLK_BACKQUOTE
    int32_t SDLK_a
    int32_t SDLK_b
    int32_t SDLK_c
    int32_t SDLK_d
    int32_t SDLK_e
    int32_t SDLK_f
    int32_t SDLK_g
    int32_t SDLK_h
    int32_t SDLK_i
    int32_t SDLK_j
    int32_t SDLK_k
    int32_t SDLK_l
    int32_t SDLK_m
    int32_t SDLK_n
    int32_t SDLK_o
    int32_t SDLK_p
    int32_t SDLK_q
    int32_t SDLK_r
    int32_t SDLK_s
    int32_t SDLK_t
    int32_t SDLK_u
    int32_t SDLK_v
    int32_t SDLK_w
    int32_t SDLK_x
    int32_t SDLK_y
    int32_t SDLK_z
    int32_t SDLK_CAPSLOCK
    int32_t SDLK_F1
    int32_t SDLK_F2
    int32_t SDLK_F3
    int32_t SDLK_F4
    int32_t SDLK_F5
    int32_t SDLK_F6
    int32_t SDLK_F7
    int32_t SDLK_F8
    int32_t SDLK_F9
    int32_t SDLK_F10
    int32_t SDLK_F11
    int32_t SDLK_F12
    int32_t SDLK_PRINTSCREEN
    int32_t SDLK_SCROLLLOCK
    int32_t SDLK_PAUSE
    int32_t SDLK_INSERT
    int32_t SDLK_HOME
    int32_t SDLK_PAGEUP
    int32_t SDLK_DELETE
    int32_t SDLK_END
    int32_t SDLK_PAGEDOWN
    int32_t SDLK_RIGHT
    int32_t SDLK_LEFT
    int32_t SDLK_DOWN
    int32_t SDLK_UP
    int32_t SDLK_NUMLOCKCLEAR
    int32_t SDLK_KP_DIVIDE
    int32_t SDLK_KP_MULTIPLY
    int32_t SDLK_KP_MINUS
    int32_t SDLK_KP_PLUS
    int32_t SDLK_KP_ENTER
    int32_t SDLK_KP_1
    int32_t SDLK_KP_2
    int32_t SDLK_KP_3
    int32_t SDLK_KP_4
    int32_t SDLK_KP_5
    int32_t SDLK_KP_6
    int32_t SDLK_KP_7
    int32_t SDLK_KP_8
    int32_t SDLK_KP_9
    int32_t SDLK_KP_0
    int32_t SDLK_KP_PERIOD
    int32_t SDLK_APPLICATION
    int32_t SDLK_POWER
    int32_t SDLK_KP_EQUALS
    int32_t SDLK_F13
    int32_t SDLK_F14
    int32_t SDLK_F15
    int32_t SDLK_F16
    int32_t SDLK_F17
    int32_t SDLK_F18
    int32_t SDLK_F19
    int32_t SDLK_F20
    int32_t SDLK_F21
    int32_t SDLK_F22
    int32_t SDLK_F23
    int32_t SDLK_F24
    int32_t SDLK_EXECUTE
    int32_t SDLK_HELP
    int32_t SDLK_MENU
    int32_t SDLK_SELECT
    int32_t SDLK_STOP
    int32_t SDLK_AGAIN
    int32_t SDLK_UNDO
    int32_t SDLK_CUT
    int32_t SDLK_COPY
    int32_t SDLK_PASTE
    int32_t SDLK_FIND
    int32_t SDLK_MUTE
    int32_t SDLK_VOLUMEUP
    int32_t SDLK_VOLUMEDOWN
    int32_t SDLK_KP_COMMA
    int32_t SDLK_KP_EQUALSAS400
    int32_t SDLK_ALTERASE
    int32_t SDLK_SYSREQ
    int32_t SDLK_CANCEL
    int32_t SDLK_CLEAR
    int32_t SDLK_PRIOR
    int32_t SDLK_RETURN2
    int32_t SDLK_SEPARATOR
    int32_t SDLK_OUT
    int32_t SDLK_OPER
    int32_t SDLK_CLEARAGAIN
    int32_t SDLK_CRSEL
    int32_t SDLK_EXSEL
    int32_t SDLK_KP_00
    int32_t SDLK_KP_000
    int32_t SDLK_THOUSANDSSEPARATOR
    int32_t SDLK_DECIMALSEPARATOR
    int32_t SDLK_CURRENCYUNIT
    int32_t SDLK_CURRENCYSUBUNIT
    int32_t SDLK_KP_LEFTPAREN
    int32_t SDLK_KP_RIGHTPAREN
    int32_t SDLK_KP_LEFTBRACE
    int32_t SDLK_KP_RIGHTBRACE
    int32_t SDLK_KP_TAB
    int32_t SDLK_KP_BACKSPACE
    int32_t SDLK_KP_A
    int32_t SDLK_KP_B
    int32_t SDLK_KP_C
    int32_t SDLK_KP_D
    int32_t SDLK_KP_E
    int32_t SDLK_KP_F
    int32_t SDLK_KP_XOR
    int32_t SDLK_KP_POWER
    int32_t SDLK_KP_PERCENT
    int32_t SDLK_KP_LESS
    int32_t SDLK_KP_GREATER
    int32_t SDLK_KP_AMPERSAND
    int32_t SDLK_KP_DBLAMPERSAND
    int32_t SDLK_KP_VERTICALBAR
    int32_t SDLK_KP_DBLVERTICALBAR
    int32_t SDLK_KP_COLON
    int32_t SDLK_KP_HASH
    int32_t SDLK_KP_SPACE
    int32_t SDLK_KP_AT
    int32_t SDLK_KP_EXCLAM
    int32_t SDLK_KP_MEMSTORE
    int32_t SDLK_KP_MEMRECALL
    int32_t SDLK_KP_MEMCLEAR
    int32_t SDLK_KP_MEMADD
    int32_t SDLK_KP_MEMSUBTRACT
    int32_t SDLK_KP_MEMMULTIPLY
    int32_t SDLK_KP_MEMDIVIDE
    int32_t SDLK_KP_PLUSMINUS
    int32_t SDLK_KP_CLEAR
    int32_t SDLK_KP_CLEARENTRY
    int32_t SDLK_KP_BINARY
    int32_t SDLK_KP_OCTAL
    int32_t SDLK_KP_DECIMAL
    int32_t SDLK_KP_HEXADECIMAL
    int32_t SDLK_LCTRL
    int32_t SDLK_LSHIFT
    int32_t SDLK_LALT
    int32_t SDLK_LGUI
    int32_t SDLK_RCTRL
    int32_t SDLK_RSHIFT
    int32_t SDLK_RALT
    int32_t SDLK_RGUI
    int32_t SDLK_MODE
    int32_t SDLK_AUDIONEXT
    int32_t SDLK_AUDIOPREV
    int32_t SDLK_AUDIOSTOP
    int32_t SDLK_AUDIOPLAY
    int32_t SDLK_AUDIOMUTE
    int32_t SDLK_MEDIASELECT
    int32_t SDLK_WWW
    int32_t SDLK_MAIL
    int32_t SDLK_CALCULATOR
    int32_t SDLK_COMPUTER
    int32_t SDLK_AC_SEARCH
    int32_t SDLK_AC_HOME
    int32_t SDLK_AC_BACK
    int32_t SDLK_AC_FORWARD
    int32_t SDLK_AC_STOP
    int32_t SDLK_AC_REFRESH
    int32_t SDLK_AC_BOOKMARKS
    int32_t SDLK_BRIGHTNESSDOWN
    int32_t SDLK_BRIGHTNESSUP
    int32_t SDLK_DISPLAYSWITCH
    int32_t SDLK_KBDILLUMTOGGLE
    int32_t SDLK_KBDILLUMDOWN
    int32_t SDLK_KBDILLUMUP
    int32_t SDLK_EJECT
    int32_t SDLK_SLEEP
    int32_t SDLK_APP1
    int32_t SDLK_APP2
    int32_t SDLK_AUDIOREWIND
    int32_t SDLK_AUDIOFASTFORWARD

    uint16_t KMOD_NONE
    uint16_t KMOD_LSHIFT
    uint16_t KMOD_RSHIFT
    uint16_t KMOD_LCTRL
    uint16_t KMOD_RCTRL
    uint16_t KMOD_LALT
    uint16_t KMOD_RALT
    uint16_t KMOD_LGUI
    uint16_t KMOD_RGUI
    uint16_t KMOD_NUM
    uint16_t KMOD_CAPS
    uint16_t KMOD_MODE
    uint16_t KMOD_RESERVED
    uint16_t KMOD_CTRL
    uint16_t KMOD_SHIFT
    uint16_t KMOD_ALT
    uint16_t KMOD_GUI

    uint8_t SDL_HAT_LEFTUP
    uint8_t SDL_HAT_UP
    uint8_t SDL_HAT_RIGHTUP
    uint8_t SDL_HAT_LEFT
    uint8_t SDL_HAT_CENTERED
    uint8_t SDL_HAT_RIGHT
    uint8_t SDL_HAT_LEFTDOWN
    uint8_t SDL_HAT_DOWN
    uint8_t SDL_HAT_RIGHTDOWN

    uint8_t SDL_CONTROLLER_BUTTON_INVALID
    uint8_t SDL_CONTROLLER_BUTTON_A
    uint8_t SDL_CONTROLLER_BUTTON_B
    uint8_t SDL_CONTROLLER_BUTTON_X
    uint8_t SDL_CONTROLLER_BUTTON_Y
    uint8_t SDL_CONTROLLER_BUTTON_BACK
    uint8_t SDL_CONTROLLER_BUTTON_GUIDE
    uint8_t SDL_CONTROLLER_BUTTON_START
    uint8_t SDL_CONTROLLER_BUTTON_LEFTSTICK
    uint8_t SDL_CONTROLLER_BUTTON_RIGHTSTICK
    uint8_t SDL_CONTROLLER_BUTTON_LEFTSHOULDER
    uint8_t SDL_CONTROLLER_BUTTON_RIGHTSHOULDER
    uint8_t SDL_CONTROLLER_BUTTON_DPAD_UP
    uint8_t SDL_CONTROLLER_BUTTON_DPAD_DOWN
    uint8_t SDL_CONTROLLER_BUTTON_DPAD_LEFT
    uint8_t SDL_CONTROLLER_BUTTON_DPAD_RIGHT

    # Functions
    int SDL_Init(uint32_t flags)
    void SDL_Quit()
    void SDL_Delay(uint32_t milliseconds)
    uint32_t SDL_GetTicks()

    # Events
    int SDL_PollEvent(SDL_Event *event)

    # Errors
    const char *SDL_GetError()

    # RWOps
    SDL_RWops *SDL_RWFromFile(const char *file, const char *mode)

    # Joystick Functions
    SDL_GameController *SDL_GameControllerOpen(int joystick_index)
    SDL_Joystick *SDL_GameControllerGetJoystick(SDL_GameController *gamecontroller)
    int32_t SDL_JoystickInstanceID(SDL_Joystick *joystick)

    # Window functions
    SDL_Window *SDL_CreateWindow(const char* title, int x, int y, int w, int h, uint32_t flags)
    void SDL_DestroyWindow(SDL_Window *window)
    void SDL_GetWindowSize(SDL_Window *window, int *w, int *h)
    uint32_t SDL_GetWindowID(SDL_Window* window)

    # Renderer Fucntions
    SDL_Renderer *SDL_CreateRenderer(SDL_Window *window, int index, uint32_t flags)
    void SDL_DestroyRenderer(SDL_Renderer *renderer)
    int SDL_SetRenderDrawColor(SDL_Renderer *renderer, uint8_t r, uint8_t g, uint8_t b, uint8_t a)
    int SDL_RenderClear(SDL_Renderer *renderer)
    void SDL_RenderPresent(SDL_Renderer *renderer)
    int SDL_RenderCopy(SDL_Renderer *renderer, SDL_Texture *texture, const SDL_Rect *srcrect, const SDL_Rect *dstrect)
    int SDL_SetRenderTarget(SDL_Renderer *renderer, SDL_Texture *texture)

    # Texture Functions
    SDL_Texture *SDL_CreateTexture(SDL_Renderer *renderer, uint32_t format, int access, int w, int h)
    SDL_Texture *SDL_CreateTextureFromSurface(SDL_Renderer *renderer, SDL_Surface *surface)
    void SDL_DestroyTexture(SDL_Texture *texture)
    void SDL_FreeSurface(SDL_Surface *surface)
    int SDL_QueryTexture(SDL_Texture* texture, uint32_t* format, int* access, int* w, int* h)

    # Input state
    uint32_t SDL_GetMouseState(int *x, int *y)
    uint16_t SDL_GetModState()


cdef extern from "SDL_image.h":
    int IMG_INIT_JPG
    int IMG_INIT_PNG
    int IMG_INIT_TIF
    int IMG_INIT_WEBP

    int IMG_Init(int flags)
    void IMG_Quit()

    SDL_Texture *IMG_LoadTexture(SDL_Renderer *renderer, const char *file)


cdef extern from "SDL_mixer.h":

    ctypedef struct Mix_Chunk:
        int allocated
        uint8_t *abuf
        uint32_t alen
        uint8_t volume

    ctypedef struct Mix_Music:
        pass

    int MIX_INIT_FLAC
    int MIX_INIT_MOD
    int MIX_INIT_MODPLUG
    int MIX_INIT_MP3
    int MIX_INIT_OGG
    int MIX_INIT_FLUIDSYNTH

    uint8_t MIX_NO_FADING
    uint8_t MIX_FADING_OUT
    uint8_t MIX_FADING_IN

    uint8_t MUS_NONE
    uint8_t MUS_CMD
    uint8_t MUS_WAV
    uint8_t MUS_MOD
    uint8_t MUS_MID
    uint8_t MUS_MP3
    uint8_t MUS_MP3_MAD_UNUSED
    uint8_t MUS_FLAC
    uint8_t MUS_MODPLUG_UNUSED

    int MIX_CHANNELS
    int MIX_DEFAULT_FREQUENCY
    uint16_t MIX_DEFAULT_FORMAT
    int MIX_DEFAULT_CHANNELS
    uint8_t MIX_MAX_VOLUME

    int Mix_Init(int flags)
    void Mix_Quit()
    int Mix_OpenAudio(int frequency, uint16_t format, int channels, int chunksize)
    Mix_Music *Mix_LoadMUS(const char *file)
    Mix_Chunk *Mix_LoadWAV_RW(SDL_RWops *src, int freesrc)
    void Mix_FreeChunk(Mix_Chunk *chunk)
    void Mix_FreeMusic(Mix_Music *music)
    int Mix_PlayChannelTimed(int channel, Mix_Chunk *chunk, int loops, int ticks)
    int Mix_PlayMusic(Mix_Music *music, int loops)
    int Mix_VolumeChunk(Mix_Chunk *chunk, int volume)
    int Mix_VolumeMusic(int volume)
    int Mix_HaltMusic()
    void Mix_CloseAudio()


class MouseButton(enum.IntEnum):
    LEFT = SDL_BUTTON_LEFT
    MIDDLE = SDL_BUTTON_MIDDLE
    RIGHT = SDL_BUTTON_RIGHT
    X1 = SDL_BUTTON_X1
    X2 = SDL_BUTTON_X2


class Key(enum.IntEnum):
    UNKNOWN = SDLK_UNKNOWN
    RETURN = SDLK_RETURN
    ESCAPE = SDLK_ESCAPE
    BACKSPACE = SDLK_BACKSPACE
    TAB = SDLK_TAB
    SPACE = SDLK_SPACE
    EXCLAIM = SDLK_EXCLAIM
    QUOTEDBL = SDLK_QUOTEDBL
    HASH = SDLK_HASH
    PERCENT = SDLK_PERCENT
    DOLLAR = SDLK_DOLLAR
    AMPERSAND = SDLK_AMPERSAND
    QUOTE = SDLK_QUOTE
    LEFTPAREN = SDLK_LEFTPAREN
    RIGHTPAREN = SDLK_RIGHTPAREN
    ASTERISK = SDLK_ASTERISK
    PLUS = SDLK_PLUS
    COMMA = SDLK_COMMA
    MINUS = SDLK_MINUS
    PERIOD = SDLK_PERIOD
    SLASH = SDLK_SLASH
    K0 = SDLK_0
    K1 = SDLK_1
    K2 = SDLK_2
    K3 = SDLK_3
    K4 = SDLK_4
    K5 = SDLK_5
    K6 = SDLK_6
    K7 = SDLK_7
    K8 = SDLK_8
    K9 = SDLK_9
    COLON = SDLK_COLON
    SEMICOLON = SDLK_SEMICOLON
    LESS = SDLK_LESS
    EQUALS = SDLK_EQUALS
    GREATER = SDLK_GREATER
    QUESTION = SDLK_QUESTION
    AT = SDLK_AT
    LEFTBRACKET = SDLK_LEFTBRACKET
    BACKSLASH = SDLK_BACKSLASH
    RIGHTBRACKET = SDLK_RIGHTBRACKET
    CARET = SDLK_CARET
    UNDERSCORE = SDLK_UNDERSCORE
    BACKQUOTE = SDLK_BACKQUOTE
    A = SDLK_a
    B = SDLK_b
    C = SDLK_c
    D = SDLK_d
    E = SDLK_e
    F = SDLK_f
    G = SDLK_g
    H = SDLK_h
    I = SDLK_i
    J = SDLK_j
    K = SDLK_k
    L = SDLK_l
    M = SDLK_m
    N = SDLK_n
    O = SDLK_o
    P = SDLK_p
    Q = SDLK_q
    R = SDLK_r
    S = SDLK_s
    T = SDLK_t
    U = SDLK_u
    V = SDLK_v
    W = SDLK_w
    X = SDLK_x
    Y = SDLK_y
    Z = SDLK_z
    CAPSLOCK = SDLK_CAPSLOCK
    F1 = SDLK_F1
    F2 = SDLK_F2
    F3 = SDLK_F3
    F4 = SDLK_F4
    F5 = SDLK_F5
    F6 = SDLK_F6
    F7 = SDLK_F7
    F8 = SDLK_F8
    F9 = SDLK_F9
    F10 = SDLK_F10
    F11 = SDLK_F11
    F12 = SDLK_F12
    PRINTSCREEN = SDLK_PRINTSCREEN
    SCROLLLOCK = SDLK_SCROLLLOCK
    PAUSE = SDLK_PAUSE
    INSERT = SDLK_INSERT
    HOME = SDLK_HOME
    PAGEUP = SDLK_PAGEUP
    DELETE = SDLK_DELETE
    END = SDLK_END
    PAGEDOWN = SDLK_PAGEDOWN
    RIGHT = SDLK_RIGHT
    LEFT = SDLK_LEFT
    DOWN = SDLK_DOWN
    UP = SDLK_UP
    NUMLOCKCLEAR = SDLK_NUMLOCKCLEAR
    KP_DIVIDE = SDLK_KP_DIVIDE
    KP_MULTIPLY = SDLK_KP_MULTIPLY
    KP_MINUS = SDLK_KP_MINUS
    KP_PLUS = SDLK_KP_PLUS
    KP_ENTER = SDLK_KP_ENTER
    KP_1 = SDLK_KP_1
    KP_2 = SDLK_KP_2
    KP_3 = SDLK_KP_3
    KP_4 = SDLK_KP_4
    KP_5 = SDLK_KP_5
    KP_6 = SDLK_KP_6
    KP_7 = SDLK_KP_7
    KP_8 = SDLK_KP_8
    KP_9 = SDLK_KP_9
    KP_0 = SDLK_KP_0
    KP_PERIOD = SDLK_KP_PERIOD
    APPLICATION = SDLK_APPLICATION
    POWER = SDLK_POWER
    KP_EQUALS = SDLK_KP_EQUALS
    F13 = SDLK_F13
    F14 = SDLK_F14
    F15 = SDLK_F15
    F16 = SDLK_F16
    F17 = SDLK_F17
    F18 = SDLK_F18
    F19 = SDLK_F19
    F20 = SDLK_F20
    F21 = SDLK_F21
    F22 = SDLK_F22
    F23 = SDLK_F23
    F24 = SDLK_F24
    EXECUTE = SDLK_EXECUTE
    HELP = SDLK_HELP
    MENU = SDLK_MENU
    SELECT = SDLK_SELECT
    STOP = SDLK_STOP
    AGAIN = SDLK_AGAIN
    UNDO = SDLK_UNDO
    CUT = SDLK_CUT
    COPY = SDLK_COPY
    PASTE = SDLK_PASTE
    FIND = SDLK_FIND
    MUTE = SDLK_MUTE
    VOLUMEUP = SDLK_VOLUMEUP
    VOLUMEDOWN = SDLK_VOLUMEDOWN
    KP_COMMA = SDLK_KP_COMMA
    KP_EQUALSAS400 = SDLK_KP_EQUALSAS400
    ALTERASE = SDLK_ALTERASE
    SYSREQ = SDLK_SYSREQ
    CANCEL = SDLK_CANCEL
    CLEAR = SDLK_CLEAR
    PRIOR = SDLK_PRIOR
    RETURN2 = SDLK_RETURN2
    SEPARATOR = SDLK_SEPARATOR
    OUT = SDLK_OUT
    OPER = SDLK_OPER
    CLEARAGAIN = SDLK_CLEARAGAIN
    CRSEL = SDLK_CRSEL
    EXSEL = SDLK_EXSEL
    KP_00 = SDLK_KP_00
    KP_000 = SDLK_KP_000
    THOUSANDSSEPARATOR = SDLK_THOUSANDSSEPARATOR
    DECIMALSEPARATOR = SDLK_DECIMALSEPARATOR
    CURRENCYUNIT = SDLK_CURRENCYUNIT
    CURRENCYSUBUNIT = SDLK_CURRENCYSUBUNIT
    KP_LEFTPAREN = SDLK_KP_LEFTPAREN
    KP_RIGHTPAREN = SDLK_KP_RIGHTPAREN
    KP_LEFTBRACE = SDLK_KP_LEFTBRACE
    KP_RIGHTBRACE = SDLK_KP_RIGHTBRACE
    KP_TAB = SDLK_KP_TAB
    KP_BACKSPACE = SDLK_KP_BACKSPACE
    KP_A = SDLK_KP_A
    KP_B = SDLK_KP_B
    KP_C = SDLK_KP_C
    KP_D = SDLK_KP_D
    KP_E = SDLK_KP_E
    KP_F = SDLK_KP_F
    KP_XOR = SDLK_KP_XOR
    KP_POWER = SDLK_KP_POWER
    KP_PERCENT = SDLK_KP_PERCENT
    KP_LESS = SDLK_KP_LESS
    KP_GREATER = SDLK_KP_GREATER
    KP_AMPERSAND = SDLK_KP_AMPERSAND
    KP_DBLAMPERSAND = SDLK_KP_DBLAMPERSAND
    KP_VERTICALBAR = SDLK_KP_VERTICALBAR
    KP_DBLVERTICALBAR = SDLK_KP_DBLVERTICALBAR
    KP_COLON = SDLK_KP_COLON
    KP_HASH = SDLK_KP_HASH
    KP_SPACE = SDLK_KP_SPACE
    KP_AT = SDLK_KP_AT
    KP_EXCLAM = SDLK_KP_EXCLAM
    KP_MEMSTORE = SDLK_KP_MEMSTORE
    KP_MEMRECALL = SDLK_KP_MEMRECALL
    KP_MEMCLEAR = SDLK_KP_MEMCLEAR
    KP_MEMADD = SDLK_KP_MEMADD
    KP_MEMSUBTRACT = SDLK_KP_MEMSUBTRACT
    KP_MEMMULTIPLY = SDLK_KP_MEMMULTIPLY
    KP_MEMDIVIDE = SDLK_KP_MEMDIVIDE
    KP_PLUSMINUS = SDLK_KP_PLUSMINUS
    KP_CLEAR = SDLK_KP_CLEAR
    KP_CLEARENTRY = SDLK_KP_CLEARENTRY
    KP_BINARY = SDLK_KP_BINARY
    KP_OCTAL = SDLK_KP_OCTAL
    KP_DECIMAL = SDLK_KP_DECIMAL
    KP_HEXADECIMAL = SDLK_KP_HEXADECIMAL
    LCTRL = SDLK_LCTRL
    LSHIFT = SDLK_LSHIFT
    LALT = SDLK_LALT
    LGUI = SDLK_LGUI
    RCTRL = SDLK_RCTRL
    RSHIFT = SDLK_RSHIFT
    RALT = SDLK_RALT
    RGUI = SDLK_RGUI
    MODE = SDLK_MODE
    AUDIONEXT = SDLK_AUDIONEXT
    AUDIOPREV = SDLK_AUDIOPREV
    AUDIOSTOP = SDLK_AUDIOSTOP
    AUDIOPLAY = SDLK_AUDIOPLAY
    AUDIOMUTE = SDLK_AUDIOMUTE
    MEDIASELECT = SDLK_MEDIASELECT
    WWW = SDLK_WWW
    MAIL = SDLK_MAIL
    CALCULATOR = SDLK_CALCULATOR
    COMPUTER = SDLK_COMPUTER
    AC_SEARCH = SDLK_AC_SEARCH
    AC_HOME = SDLK_AC_HOME
    AC_BACK = SDLK_AC_BACK
    AC_FORWARD = SDLK_AC_FORWARD
    AC_STOP = SDLK_AC_STOP
    AC_REFRESH = SDLK_AC_REFRESH
    AC_BOOKMARKS = SDLK_AC_BOOKMARKS
    BRIGHTNESSDOWN = SDLK_BRIGHTNESSDOWN
    BRIGHTNESSUP = SDLK_BRIGHTNESSUP
    DISPLAYSWITCH = SDLK_DISPLAYSWITCH
    KBDILLUMTOGGLE = SDLK_KBDILLUMTOGGLE
    KBDILLUMDOWN = SDLK_KBDILLUMDOWN
    KBDILLUMUP = SDLK_KBDILLUMUP
    EJECT = SDLK_EJECT
    SLEEP = SDLK_SLEEP
    APP1 = SDLK_APP1
    APP2 = SDLK_APP2
    AUDIOREWIND = SDLK_AUDIOREWIND
    AUDIOFASTFORWARD = SDLK_AUDIOFASTFORWARD


class ControllerButton(enum.IntEnum):
    A = SDL_CONTROLLER_BUTTON_A
    B = SDL_CONTROLLER_BUTTON_B
    X = SDL_CONTROLLER_BUTTON_X
    Y = SDL_CONTROLLER_BUTTON_Y
    SELECT = SDL_CONTROLLER_BUTTON_BACK
    START = SDL_CONTROLLER_BUTTON_START
    LEFT_STICK = SDL_CONTROLLER_BUTTON_LEFTSTICK
    RIGHT_STICK = SDL_CONTROLLER_BUTTON_RIGHTSTICK
    LEFT_SHOULDER = SDL_CONTROLLER_BUTTON_LEFTSHOULDER
    RIGHT_SHOULDER = SDL_CONTROLLER_BUTTON_RIGHTSHOULDER


HAT_TO_DIRECTION = {
    SDL_HAT_LEFTUP: (-1, 1), SDL_HAT_UP: (0, 1), SDL_HAT_RIGHTUP: (1, 1),
    SDL_HAT_LEFT: (-1, 0), SDL_HAT_CENTERED: (0, 0), SDL_HAT_RIGHT: (1, 0),
    SDL_HAT_LEFTDOWN: (-1, -1), SDL_HAT_DOWN: (0, -1), SDL_HAT_RIGHTDOWN: (1, -1),
}


cdef class Effect:

    cdef Mix_Chunk *chunk

    def __dealloc__(self):
        Mix_FreeChunk(self.chunk)


cdef class Music:

    cdef Mix_Music *music

    def __dealloc__(self):
        Mix_FreeMusic(self.music)


class Audio:

    def __init__(self):
        self.music_playing = False

    def play_music(self, Music music, int volume):
        self.stop_music()
        Mix_VolumeMusic(volume)
        Mix_PlayMusic(music.music, -1)

    def stop_music(self):
        if self.music_playing:
            self.music_playing = False
            Mix_HaltMusic()

    def play_effect(self, Effect effect, int volume):
        Mix_VolumeChunk(effect.chunk, volume)
        Mix_PlayChannelTimed(-1, effect.chunk, 0, -1)

    def load_music(self, str filename):
        result = Music()
        result.music = Mix_LoadMUS(filename.encode('utf-8'))
        return result

    def load_effect(self, str filename):
        result = Effect()
        result.chunk = Mix_LoadWAV_RW(SDL_RWFromFile(filename.encode('utf-8'), "rb"), 1)
        return result


class KeyModifiers:

    def __init__(self, *, ctrl, shift, alt):
        self.ctrl = ctrl
        self.shift = shift
        self.alt = alt

    def __repr__(self):
        return f'KeyModifiers(ctrl={self.ctrl}, shift={self.shift}, alt={self.alt}'


class Mouse:

    def __init__(self, *, x, y, left, middle, right, button4, button5):
        self.x = x
        self.y = y
        self.left = left
        self.middle = middle
        self.right = right
        self.button4 = button4
        self.button5 = button5

    def __repr__(self):
        return f'Mouse(x={self.x}, y={self.y}, left={self.left}, middle={self.middle}, right={self.right}, button4={self.button4}, button5={self.button5})'


class Controls:

    def __init__(self):
        self._controllers = [None for _ in range(16)]

    def find_controller(self, int instance):
        for i, c in enumerate(self._controllers):
            if c == instance:
                return i
        raise RuntimeError('Device not found')

    def add_controller(self, int instance):
        for i, c in enumerate(self._controllers):
            if c is None:
                self._controllers[i] = instance
                return i
            if c == instance:
                return i
        raise RuntimeError('Cannot add a 17th controller')

    def remove_controller(self, int instance):
        for i, c in enumerate(self._controllers):
            if c == instance:
                self._controllers[i] = None
                return
        raise RuntimeError('Device not found')

    @property
    def mouse(self):
        cdef int x = 0
        cdef int y = 0
        cdef uint32_t state = SDL_GetMouseState(&x, &y)
        return Mouse(
            x, y,
            (SDL_BUTTON_LMASK & state) > 0,
            (SDL_BUTTON_MMASK & state) > 0,
            (SDL_BUTTON_RMASK & state) > 0,
            (SDL_BUTTON_X1MASK & state) > 0,
            (SDL_BUTTON_X2MASK & state) > 0
        )

    @property
    def key_modifiers(self):
        cdef uint16_t mod = SDL_GetModState()
        return KeyModifiers(
            (KMOD_CTRL & mod) > 0,
            (KMOD_SHIFT & mod) > 0,
            (KMOD_ALT & mod) > 0
        )


cdef class Window:

    cdef SDL_Window *window

    def __dealloc__(self):
        SDL_DestroyWindow(self.window)

    def create_renderer(self):
        result = Renderer()
        result.renderer = SDL_CreateRenderer(
            self.window, -1,
            SDL_RENDERER_ACCELERATED | SDL_RENDERER_TARGETTEXTURE
        )
        return result

    @property
    def window_id(self):
        return SDL_GetWindowID(self.window)

    @property
    def size(self):
        cdef int w
        cdef int h
        SDL_GetWindowSize(self.window, &w, &h)
        return w, h


cdef class Surface:

    cdef SDL_Surface *surface

    def __dealloc__(self):
        SDL_FreeSurface(self.surface)


cdef class Texture:

    cdef SDL_Texture *texture

    def __dealloc__(self):
        SDL_DestroyTexture(self.texture)

    @property
    def size(self):
        cdef uint32_t pixel_format
        cdef int access
        cdef int w
        cdef int h
        SDL_QueryTexture(self.texture, &pixel_format, &access, &w, &h)
        return w, h


cdef class Renderer:

    cdef SDL_Renderer *renderer

    def __dealloc__(self):
        SDL_DestroyRenderer(self.renderer)

    def create_texture(self, int w, int h):
        result = Texture()
        result.texture = SDL_CreateTexture(
            self.renderer,
            SDL_PIXELFORMAT_RGBA8888,
            SDL_TEXTUREACCESS_TARGET, w, h
        )
        return result

    def create_texture_from_surface(self, Surface surface):
        result = Texture()
        result.texture = SDL_CreateTextureFromSurface(
            self.renderer,
            surface.surface
        )
        return result

    def create_texture_from_image(self, str filename):
        result = Texture()
        result.texture = IMG_LoadTexture(
            self.renderer,
            filename.encode('utf-8')
        )
        return result

    @property
    def draw_color(self):
        raise NotImplemented()

    @draw_color.setter
    def draw_color(self, color):
        r, g, b, a = color
        SDL_SetRenderDrawColor(self.renderer, r, g, b, a)

    def copy(self,
             Texture texture,
             int src_x, int src_y, int src_w, int src_h,
             int dst_x, int dst_y, int dst_w, int dst_h):
        cdef SDL_Rect src = SDL_Rect(src_x, src_y, src_w, src_h)
        cdef SDL_Rect dst = SDL_Rect(dst_x, dst_y, dst_w, dst_h)
        SDL_RenderCopy(self.renderer, texture.texture, &src, &dst)

    @property
    def target(self):
        raise NotImplemented()

    @target.setter
    def target(self, Texture target):
        if target is None:
            SDL_SetRenderTarget(self.renderer, NULL)
        else:
            SDL_SetRenderTarget(self.renderer, target.texture)

    def clear(self):
        SDL_RenderClear(self.renderer)

    def present(self):
        SDL_RenderPresent(self.renderer)


class Pyxelen:

    def __init__(self):
        self.audio = Audio()
        self.controls = Controls()
        self._windows = []

    def open_window(self, str title, int width, int height):
        result = Window()
        result.window = SDL_CreateWindow(
            title.encode('utf-8'),
            SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
            width, height,
            SDL_WINDOW_SHOWN | SDL_WINDOW_RESIZABLE
        )
        self._windows.append(result)
        return result

    def close_window(self, Window window):
        self._windows = [w for w in self._windows if w is not window]

    def _find_window(self, int window_id):
        return [
            w for w in self._windows
            if w.window_id == window_id
        ][0]

    def run(self, event_handler, fps):
        cdef SDL_Event event
        assert fps > 0, 'fps must be positive'
        cdef uint32_t ticks_per_frame = int(1000 / fps)
        cdef uint32_t current_ticks = SDL_GetTicks()
        cdef uint32_t last_frame_ticks = SDL_GetTicks()

        while len(self._windows) > 0:

            while (SDL_PollEvent(&event) != 0):

                if event.type == SDL_AUDIODEVICEADDED and hasattr(event_handler, 'on_audio_device_added'):
                    event_handler.on_audio_device_added(
                        event.adevice.which,
                        event.adevice.iscapture
                    )

                elif event.type == SDL_AUDIODEVICEREMOVED and hasattr(event_handler, 'on_audio_device_removed'):
                    event_handler.on_audio_device_removed(
                        event.adevice.which,
                        event.adevice.iscapture
                    )

                elif event.type == SDL_CONTROLLERBUTTONDOWN and hasattr(event_handler, 'on_controller_button_down'):
                    try:
                        button = ControllerButton(event.cbutton.button)
                    except ValueError:
                        print('NOTIFICATION: unknown controller button:', str(event.cbutton.button))
                    else:
                        event_handler.on_controller_button_down(
                            self.controls.find_controller(event.cbutton.which),
                            button
                        )

                elif event.type == SDL_CONTROLLERBUTTONUP and hasattr(event_handler, 'on_controller_button_up'):
                    try:
                        button = ControllerButton(event.cbutton.button)
                    except ValueError:
                        print('NOTIFICATION: unknown controller button:', str(event.cbutton.button))
                    else:
                        event_handler.on_controller_button_up(
                            self.controls.find_controller(event.cbutton.which),
                            button
                        )

                elif event.type == SDL_CONTROLLERDEVICEADDED and hasattr(event_handler, 'on_controller_device_added'):
                    instance = SDL_JoystickInstanceID(
                        SDL_GameControllerGetJoystick(
                            SDL_GameControllerOpen(event.cdevice.which)
                        )
                    )
                    event_handler.on_controller_device_added(event.cdevice.which)
                    self.controls.add_controller(instance)

                elif event.type == SDL_CONTROLLERDEVICEREMOVED and hasattr(event_handler, 'on_controller_device_removed'):
                    event_handler.on_controller_device_removed(event.cdevice.which)
                    self.controls.remove_controller(event.cdevice.which)

                elif event.type == SDL_JOYHATMOTION and hasattr(event_handler, 'on_controller_dpad'):
                    controller = self.controls.controllers.find_controller(
                        event.jhat.which
                    )
                    x, y = HAT_TO_DIRECTION.get(event.jhat.value, (0, 0))
                    event_handler.on_controller_dpad(controller, x, y)

                elif event.type == SDL_KEYDOWN and hasattr(event_handler, 'on_key_down'):
                    try:
                        key = Key(event.key.keysym.sym)
                        window = self._find_window(event.key.windowID)
                    except ValueError:
                        print('NOTIFICATION: unknown key:', str(event.key.keysym.sym))
                    except IndexError:
                        # Ignore events for windows that are closed
                        pass
                    else:
                        mods = KeyModifiers(
                            (KMOD_CTRL & event.key.keysym.mod) > 0,
                            (KMOD_SHIFT & event.key.keysym.mod) > 0,
                            (KMOD_ALT & event.key.keysym.mod) > 0
                        )
                        event_handler.on_key_down(window, key, mods, event.key.repeat == 1)

                elif event.type == SDL_KEYUP and hasattr(event_handler, 'on_key_up'):
                    try:
                        key = Key(event.key.keysym.sym)
                        window = self._find_window(event.key.windowID)
                    except ValueError:
                        print('NOTIFICATION: unknown key:', str(event.key.keysym.sym))
                    except IndexError:
                        # Ignore events for windows that are closed
                        pass
                    else:
                        mods = KeyModifiers(
                            (KMOD_CTRL & event.key.keysym.mod) > 0,
                            (KMOD_SHIFT & event.key.keysym.mod) > 0,
                            (KMOD_ALT & event.key.keysym.mod) > 0
                        )
                        event_handler.on_key_up(window, key, mods)

                elif event.type == SDL_MOUSEBUTTONDOWN and hasattr(event_handler, 'on_mouse_button_down'):
                    try:
                        button = MouseButton(event.button.button)
                        window = self._find_window(event.button.windowID)
                    except ValueError:
                        print('NOTIFICATION: unknown mouse button:', str(event.button.button))
                    except IndexError:
                        # Ignore events for windows that are closed
                        pass
                    else:
                        event_handler.on_mouse_button_down(
                            window,
                            button,
                            event.button.x,
                            event.button.y
                        )

                elif event.type == SDL_MOUSEBUTTONUP and hasattr(event_handler, 'on_mouse_button_up'):
                    try:
                        button = MouseButton(event.button.button)
                        window = self._find_window(event.button.windowID)
                    except ValueError:
                        print('NOTIFICATION: unknown mouse button:', str(event.button.button))
                    except IndexError:
                        # Ignore events for windows that are closed
                        pass
                    else:
                        event_handler.on_mouse_button_up(
                            window,
                            button,
                            event.button.x,
                            event.button.y
                        )

                elif event.type == SDL_MOUSEMOTION and hasattr(event_handler, 'on_mouse_motion'):
                    try:
                        window = self._find_window(event.motion.windowID)
                    except IndexError:
                        # Ignore events for windows that are closed
                        pass
                    else:
                        event_handler.on_mouse_motion(
                            window,
                            Mouse(
                                event.motion.x, event.motion.y,
                                (SDL_BUTTON_LMASK & event.motion.state) > 0,
                                (SDL_BUTTON_MMASK & event.motion.state) > 0,
                                (SDL_BUTTON_RMASK & event.motion.state) > 0,
                                (SDL_BUTTON_X1MASK & event.motion.state) > 0,
                                (SDL_BUTTON_X2MASK & event.motion.state) > 0
                            ),
                            event.motion.xrel,
                            event.motion.yrel
                        )

                elif event.type == SDL_MOUSEWHEEL and hasattr(event_handler, 'on_mouse_wheel'):
                    try:
                        window = self._find_window(event.wheel.windowID)
                    except IndexError:
                        # Ignore events for windows that are closed
                        pass
                    else:
                        event_handler.on_mouse_wheel(
                            window,
                            -event.wheel.x if event.wheel.direction else event.wheel.x,
                            -event.wheel.y if event.wheel.direction else event.wheel.y
                        )

                elif event.type == SDL_QUIT:
                    if hasattr(event_handler, 'on_quit'):
                        event_handler.on_quit()
                    self._windows = []

                elif event.type == SDL_TEXTINPUT and hasattr(event_handler, 'on_text_input'):
                    try:
                        window = self._find_window(event.text.windowID)
                    except IndexError:
                        # Ignore events for windows that are closed
                        pass
                    else:
                        event_handler.on_text_input(window, event.text.text.decode('utf-8'))

                elif event.type == SDL_RENDER_TARGETS_RESET and hasattr(event_handler, 'on_render_targets_reset'):
                    event_handler.on_render_targets_reset()

                elif event.type == SDL_WINDOWEVENT:

                    window_event = event.window

                    try:
                        window = self._find_window(window_event.windowID)
                    except IndexError:
                        # Ignore events for non-opened windows
                        pass
                    else:
                        if window_event.event == SDL_WINDOWEVENT_SHOWN and hasattr(event_handler, 'on_window_shown'):
                            event_handler.on_window_shown(window)

                        elif window_event.event == SDL_WINDOWEVENT_HIDDEN and hasattr(event_handler, 'on_window_shown'):
                            event_handler.on_window_hidden(window)

                        elif window_event.event == SDL_WINDOWEVENT_EXPOSED and hasattr(event_handler, 'on_window_exposed'):
                            event_handler.on_window_exposed(window and hasattr(event_handler, 'on_window_exposed'))

                        elif window_event.event == SDL_WINDOWEVENT_MOVED and hasattr(event_handler, 'on_window_moved'):
                            event_handler.on_window_moved(window, event.window.data1, event.window.data2)

                        elif window_event.event == SDL_WINDOWEVENT_SIZE_CHANGED and hasattr(event_handler, 'on_window_size_changed'):
                            event_handler.on_window_size_changed(window, event.window.data1, event.window.data2)

                        elif window_event.event == SDL_WINDOWEVENT_MINIMIZED and hasattr(event_handler, 'on_window_minimized'):
                            event_handler.on_window_minimized(window)

                        elif window_event.event == SDL_WINDOWEVENT_MAXIMIZED and hasattr(event_handler, 'on_window_maximized'):
                            event_handler.on_window_maximized(window)

                        elif window_event.event == SDL_WINDOWEVENT_RESTORED and hasattr(event_handler, 'on_window_restored'):
                            event_handler.on_window_restored(window)

                        elif window_event.event == SDL_WINDOWEVENT_ENTER and hasattr(event_handler, 'on_window_enter'):
                            event_handler.on_window_enter(window)

                        elif window_event.event == SDL_WINDOWEVENT_LEAVE and hasattr(event_handler, 'on_window_leave'):
                            event_handler.on_window_leave(window)

                        elif window_event.event == SDL_WINDOWEVENT_FOCUS_GAINED and hasattr(event_handler, 'on_window_focus_gained'):
                            event_handler.on_window_focus_gained(window)

                        elif window_event.event == SDL_WINDOWEVENT_FOCUS_LOST and hasattr(event_handler, 'on_window_focus_lost'):
                            event_handler.on_window_focus_lost(window)

                        elif window_event.event == SDL_WINDOWEVENT_CLOSE:
                            if hasattr(event_handler, 'on_window_close'):
                                event_handler.on_window_close(window)
                            self._windows = [w for w in self._windows if w is not window]

            event_handler.on_update_and_render()

            current_ticks = SDL_GetTicks()
            if current_ticks < last_frame_ticks + ticks_per_frame:
                SDL_Delay(last_frame_ticks + ticks_per_frame - current_ticks)
            last_frame_ticks = SDL_GetTicks()


def get_error():
    return SDL_GetError().decode('utf-8')


def init():
    assert SDL_Init(SDL_INIT_AUDIO | SDL_INIT_VIDEO | SDL_INIT_GAMECONTROLLER) == 0
    assert IMG_Init(IMG_INIT_JPG | IMG_INIT_PNG) == (IMG_INIT_JPG | IMG_INIT_PNG)
    assert Mix_Init(MIX_INIT_OGG) == MIX_INIT_OGG
    assert Mix_OpenAudio(MIX_DEFAULT_FREQUENCY * 2, MIX_DEFAULT_FORMAT, MIX_DEFAULT_CHANNELS, 1024) >= 0


def quit():
    Mix_Quit()
    IMG_Quit()
    SDL_Quit()
    Mix_CloseAudio()
