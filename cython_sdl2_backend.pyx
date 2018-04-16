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


import enum
import functools
from pyxelen import api


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

    struct SDL_BlitMap:
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

    int MIX_INIT_FLAC
    int MIX_INIT_MOD
    int MIX_INIT_MODPLUG
    int MIX_INIT_MP3
    int MIX_INIT_OGG
    int MIX_INIT_FLUIDSYNTH

    ctypedef struct Mix_Chunk:
        int allocated
        uint8_t *abuf
        uint32_t alen
        uint8_t volume

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

    ctypedef struct Mix_Music:
        pass


    int Mix_Init(int flags)
    void Mix_Quit()
    int Mix_OpenAudio(int frequency, uint16_t format, int channels, int chunksize)
    int Mix_OpenAudioDevice(
        int frequency,
        uint16_t format,
        int channels,
        int chunksize,
        const char* device,
        int allowed_changes
    )
    int Mix_AllocateChannels(int numchans)
    int Mix_QuerySpec(int *frequency, uint16_t *format, int *channels)
    Mix_Music *Mix_LoadMUS(const char *file)
    Mix_Chunk *Mix_LoadWAV_RW(SDL_RWops *src, int freesrc)
    void Mix_FreeChunk(Mix_Chunk *chunk)
    void Mix_FreeMusic(Mix_Music *music)
    int Mix_PlayChannelTimed(int channel, Mix_Chunk *chunk, int loops, int ticks)
    int Mix_PlayMusic(Mix_Music *music, int loops)
    int Mix_Volume(int channel, int volume)
    int Mix_VolumeMusic(int volume)
    int Mix_HaltMusic()
    void Mix_PauseMusic()
    void Mix_ResumeMusic()
    void Mix_RewindMusic()
    int Mix_PausedMusic()
    int Mix_PlayingMusic()
    void Mix_CloseAudio()


cdef extern from "SDL_ttf.h":

    ctypedef struct TTF_Font:
        pass

    int TTF_Init()
    TTF_Font *TTF_OpenFont(const char *file, int ptsize)
    SDL_Surface *TTF_RenderUTF8_Blended(TTF_Font *font, const char *text, SDL_Color fg)
    SDL_Surface *TTF_RenderUTF8_Solid(TTF_Font *font, const char *text, SDL_Color fg)
    void TTF_CloseFont(TTF_Font *font)
    void TTF_Quit()
    int TTF_FontLineSkip(const TTF_Font *font)


SDL_BUTTON_TO_API = {
    SDL_BUTTON_LEFT: api.MouseButton.LEFT,
    SDL_BUTTON_MIDDLE: api.MouseButton.MIDDLE,
    SDL_BUTTON_RIGHT: api.MouseButton.RIGHT,
    SDL_BUTTON_X1: api.MouseButton.X1,
    SDL_BUTTON_X2: api.MouseButton.X2,
}


SDLK_TO_API = {
    SDLK_UNKNOWN: api.Key.UNKNOWN,
    SDLK_RETURN: api.Key.RETURN,
    SDLK_ESCAPE: api.Key.ESCAPE,
    SDLK_BACKSPACE: api.Key.BACKSPACE,
    SDLK_TAB: api.Key.TAB,
    SDLK_SPACE: api.Key.SPACE,
    SDLK_EXCLAIM: api.Key.EXCLAIM,
    SDLK_QUOTEDBL: api.Key.QUOTEDBL,
    SDLK_HASH: api.Key.HASH,
    SDLK_PERCENT: api.Key.PERCENT,
    SDLK_DOLLAR: api.Key.DOLLAR,
    SDLK_AMPERSAND: api.Key.AMPERSAND,
    SDLK_QUOTE: api.Key.QUOTE,
    SDLK_LEFTPAREN: api.Key.LEFTPAREN,
    SDLK_RIGHTPAREN: api.Key.RIGHTPAREN,
    SDLK_ASTERISK: api.Key.ASTERISK,
    SDLK_PLUS: api.Key.PLUS,
    SDLK_COMMA: api.Key.COMMA,
    SDLK_MINUS: api.Key.MINUS,
    SDLK_PERIOD: api.Key.PERIOD,
    SDLK_SLASH: api.Key.SLASH,
    SDLK_0: api.Key.K0,
    SDLK_1: api.Key.K1,
    SDLK_2: api.Key.K2,
    SDLK_3: api.Key.K3,
    SDLK_4: api.Key.K4,
    SDLK_5: api.Key.K5,
    SDLK_6: api.Key.K6,
    SDLK_7: api.Key.K7,
    SDLK_8: api.Key.K8,
    SDLK_9: api.Key.K9,
    SDLK_COLON: api.Key.COLON,
    SDLK_SEMICOLON: api.Key.SEMICOLON,
    SDLK_LESS: api.Key.LESS,
    SDLK_EQUALS: api.Key.EQUALS,
    SDLK_GREATER: api.Key.GREATER,
    SDLK_QUESTION: api.Key.QUESTION,
    SDLK_AT: api.Key.AT,
    SDLK_LEFTBRACKET: api.Key.LEFTBRACKET,
    SDLK_BACKSLASH: api.Key.BACKSLASH,
    SDLK_RIGHTBRACKET: api.Key.RIGHTBRACKET,
    SDLK_CARET: api.Key.CARET,
    SDLK_UNDERSCORE: api.Key.UNDERSCORE,
    SDLK_BACKQUOTE: api.Key.BACKQUOTE,
    SDLK_a: api.Key.A,
    SDLK_b: api.Key.B,
    SDLK_c: api.Key.C,
    SDLK_d: api.Key.D,
    SDLK_e: api.Key.E,
    SDLK_f: api.Key.F,
    SDLK_g: api.Key.G,
    SDLK_h: api.Key.H,
    SDLK_i: api.Key.I,
    SDLK_j: api.Key.J,
    SDLK_k: api.Key.K,
    SDLK_l: api.Key.L,
    SDLK_m: api.Key.M,
    SDLK_n: api.Key.N,
    SDLK_o: api.Key.O,
    SDLK_p: api.Key.P,
    SDLK_q: api.Key.Q,
    SDLK_r: api.Key.R,
    SDLK_s: api.Key.S,
    SDLK_t: api.Key.T,
    SDLK_u: api.Key.U,
    SDLK_v: api.Key.V,
    SDLK_w: api.Key.W,
    SDLK_x: api.Key.X,
    SDLK_y: api.Key.Y,
    SDLK_z: api.Key.Z,
    SDLK_CAPSLOCK: api.Key.CAPSLOCK,
    SDLK_F1: api.Key.F1,
    SDLK_F2: api.Key.F2,
    SDLK_F3: api.Key.F3,
    SDLK_F4: api.Key.F4,
    SDLK_F5: api.Key.F5,
    SDLK_F6: api.Key.F6,
    SDLK_F7: api.Key.F7,
    SDLK_F8: api.Key.F8,
    SDLK_F9: api.Key.F9,
    SDLK_F10: api.Key.F10,
    SDLK_F11: api.Key.F11,
    SDLK_F12: api.Key.F12,
    SDLK_PRINTSCREEN: api.Key.PRINTSCREEN,
    SDLK_SCROLLLOCK: api.Key.SCROLLLOCK,
    SDLK_PAUSE: api.Key.PAUSE,
    SDLK_INSERT: api.Key.INSERT,
    SDLK_HOME: api.Key.HOME,
    SDLK_PAGEUP: api.Key.PAGEUP,
    SDLK_DELETE: api.Key.DELETE,
    SDLK_END: api.Key.END,
    SDLK_PAGEDOWN: api.Key.PAGEDOWN,
    SDLK_RIGHT: api.Key.RIGHT,
    SDLK_LEFT: api.Key.LEFT,
    SDLK_DOWN: api.Key.DOWN,
    SDLK_UP: api.Key.UP,
    SDLK_NUMLOCKCLEAR: api.Key.NUMLOCKCLEAR,
    SDLK_KP_DIVIDE: api.Key.KP_DIVIDE,
    SDLK_KP_MULTIPLY: api.Key.KP_MULTIPLY,
    SDLK_KP_MINUS: api.Key.KP_MINUS,
    SDLK_KP_PLUS: api.Key.KP_PLUS,
    SDLK_KP_ENTER: api.Key.KP_ENTER,
    SDLK_KP_1: api.Key.KP_1,
    SDLK_KP_2: api.Key.KP_2,
    SDLK_KP_3: api.Key.KP_3,
    SDLK_KP_4: api.Key.KP_4,
    SDLK_KP_5: api.Key.KP_5,
    SDLK_KP_6: api.Key.KP_6,
    SDLK_KP_7: api.Key.KP_7,
    SDLK_KP_8: api.Key.KP_8,
    SDLK_KP_9: api.Key.KP_9,
    SDLK_KP_0: api.Key.KP_0,
    SDLK_KP_PERIOD: api.Key.KP_PERIOD,
    SDLK_APPLICATION: api.Key.APPLICATION,
    SDLK_POWER: api.Key.POWER,
    SDLK_KP_EQUALS: api.Key.KP_EQUALS,
    SDLK_F13: api.Key.F13,
    SDLK_F14: api.Key.F14,
    SDLK_F15: api.Key.F15,
    SDLK_F16: api.Key.F16,
    SDLK_F17: api.Key.F17,
    SDLK_F18: api.Key.F18,
    SDLK_F19: api.Key.F19,
    SDLK_F20: api.Key.F20,
    SDLK_F21: api.Key.F21,
    SDLK_F22: api.Key.F22,
    SDLK_F23: api.Key.F23,
    SDLK_F24: api.Key.F24,
    SDLK_EXECUTE: api.Key.EXECUTE,
    SDLK_HELP: api.Key.HELP,
    SDLK_MENU: api.Key.MENU,
    SDLK_SELECT: api.Key.SELECT,
    SDLK_STOP: api.Key.STOP,
    SDLK_AGAIN: api.Key.AGAIN,
    SDLK_UNDO: api.Key.UNDO,
    SDLK_CUT: api.Key.CUT,
    SDLK_COPY: api.Key.COPY,
    SDLK_PASTE: api.Key.PASTE,
    SDLK_FIND: api.Key.FIND,
    SDLK_MUTE: api.Key.MUTE,
    SDLK_VOLUMEUP: api.Key.VOLUMEUP,
    SDLK_VOLUMEDOWN: api.Key.VOLUMEDOWN,
    SDLK_KP_COMMA: api.Key.KP_COMMA,
    SDLK_KP_EQUALSAS400: api.Key.KP_EQUALSAS400,
    SDLK_ALTERASE: api.Key.ALTERASE,
    SDLK_SYSREQ: api.Key.SYSREQ,
    SDLK_CANCEL: api.Key.CANCEL,
    SDLK_CLEAR: api.Key.CLEAR,
    SDLK_PRIOR: api.Key.PRIOR,
    SDLK_RETURN2: api.Key.RETURN2,
    SDLK_SEPARATOR: api.Key.SEPARATOR,
    SDLK_OUT: api.Key.OUT,
    SDLK_OPER: api.Key.OPER,
    SDLK_CLEARAGAIN: api.Key.CLEARAGAIN,
    SDLK_CRSEL: api.Key.CRSEL,
    SDLK_EXSEL: api.Key.EXSEL,
    SDLK_KP_00: api.Key.KP_00,
    SDLK_KP_000: api.Key.KP_000,
    SDLK_THOUSANDSSEPARATOR: api.Key.THOUSANDSSEPARATOR,
    SDLK_DECIMALSEPARATOR: api.Key.DECIMALSEPARATOR,
    SDLK_CURRENCYUNIT: api.Key.CURRENCYUNIT,
    SDLK_CURRENCYSUBUNIT: api.Key.CURRENCYSUBUNIT,
    SDLK_KP_LEFTPAREN: api.Key.KP_LEFTPAREN,
    SDLK_KP_RIGHTPAREN: api.Key.KP_RIGHTPAREN,
    SDLK_KP_LEFTBRACE: api.Key.KP_LEFTBRACE,
    SDLK_KP_RIGHTBRACE: api.Key.KP_RIGHTBRACE,
    SDLK_KP_TAB: api.Key.KP_TAB,
    SDLK_KP_BACKSPACE: api.Key.KP_BACKSPACE,
    SDLK_KP_A: api.Key.KP_A,
    SDLK_KP_B: api.Key.KP_B,
    SDLK_KP_C: api.Key.KP_C,
    SDLK_KP_D: api.Key.KP_D,
    SDLK_KP_E: api.Key.KP_E,
    SDLK_KP_F: api.Key.KP_F,
    SDLK_KP_XOR: api.Key.KP_XOR,
    SDLK_KP_POWER: api.Key.KP_POWER,
    SDLK_KP_PERCENT: api.Key.KP_PERCENT,
    SDLK_KP_LESS: api.Key.KP_LESS,
    SDLK_KP_GREATER: api.Key.KP_GREATER,
    SDLK_KP_AMPERSAND: api.Key.KP_AMPERSAND,
    SDLK_KP_DBLAMPERSAND: api.Key.KP_DBLAMPERSAND,
    SDLK_KP_VERTICALBAR: api.Key.KP_VERTICALBAR,
    SDLK_KP_DBLVERTICALBAR: api.Key.KP_DBLVERTICALBAR,
    SDLK_KP_COLON: api.Key.KP_COLON,
    SDLK_KP_HASH: api.Key.KP_HASH,
    SDLK_KP_SPACE: api.Key.KP_SPACE,
    SDLK_KP_AT: api.Key.KP_AT,
    SDLK_KP_EXCLAM: api.Key.KP_EXCLAM,
    SDLK_KP_MEMSTORE: api.Key.KP_MEMSTORE,
    SDLK_KP_MEMRECALL: api.Key.KP_MEMRECALL,
    SDLK_KP_MEMCLEAR: api.Key.KP_MEMCLEAR,
    SDLK_KP_MEMADD: api.Key.KP_MEMADD,
    SDLK_KP_MEMSUBTRACT: api.Key.KP_MEMSUBTRACT,
    SDLK_KP_MEMMULTIPLY: api.Key.KP_MEMMULTIPLY,
    SDLK_KP_MEMDIVIDE: api.Key.KP_MEMDIVIDE,
    SDLK_KP_PLUSMINUS: api.Key.KP_PLUSMINUS,
    SDLK_KP_CLEAR: api.Key.KP_CLEAR,
    SDLK_KP_CLEARENTRY: api.Key.KP_CLEARENTRY,
    SDLK_KP_BINARY: api.Key.KP_BINARY,
    SDLK_KP_OCTAL: api.Key.KP_OCTAL,
    SDLK_KP_DECIMAL: api.Key.KP_DECIMAL,
    SDLK_KP_HEXADECIMAL: api.Key.KP_HEXADECIMAL,
    SDLK_LCTRL: api.Key.LCTRL,
    SDLK_LSHIFT: api.Key.LSHIFT,
    SDLK_LALT: api.Key.LALT,
    SDLK_LGUI: api.Key.LGUI,
    SDLK_RCTRL: api.Key.RCTRL,
    SDLK_RSHIFT: api.Key.RSHIFT,
    SDLK_RALT: api.Key.RALT,
    SDLK_RGUI: api.Key.RGUI,
    SDLK_MODE: api.Key.MODE,
    SDLK_AUDIONEXT: api.Key.AUDIONEXT,
    SDLK_AUDIOPREV: api.Key.AUDIOPREV,
    SDLK_AUDIOSTOP: api.Key.AUDIOSTOP,
    SDLK_AUDIOPLAY: api.Key.AUDIOPLAY,
    SDLK_AUDIOMUTE: api.Key.AUDIOMUTE,
    SDLK_MEDIASELECT: api.Key.MEDIASELECT,
    SDLK_WWW: api.Key.WWW,
    SDLK_MAIL: api.Key.MAIL,
    SDLK_CALCULATOR: api.Key.CALCULATOR,
    SDLK_COMPUTER: api.Key.COMPUTER,
    SDLK_AC_SEARCH: api.Key.AC_SEARCH,
    SDLK_AC_HOME: api.Key.AC_HOME,
    SDLK_AC_BACK: api.Key.AC_BACK,
    SDLK_AC_FORWARD: api.Key.AC_FORWARD,
    SDLK_AC_STOP: api.Key.AC_STOP,
    SDLK_AC_REFRESH: api.Key.AC_REFRESH,
    SDLK_AC_BOOKMARKS: api.Key.AC_BOOKMARKS,
    SDLK_BRIGHTNESSDOWN: api.Key.BRIGHTNESSDOWN,
    SDLK_BRIGHTNESSUP: api.Key.BRIGHTNESSUP,
    SDLK_DISPLAYSWITCH: api.Key.DISPLAYSWITCH,
    SDLK_KBDILLUMTOGGLE: api.Key.KBDILLUMTOGGLE,
    SDLK_KBDILLUMDOWN: api.Key.KBDILLUMDOWN,
    SDLK_KBDILLUMUP: api.Key.KBDILLUMUP,
    SDLK_EJECT: api.Key.EJECT,
    SDLK_SLEEP: api.Key.SLEEP,
    SDLK_APP1: api.Key.APP1,
    SDLK_APP2: api.Key.APP2,
    SDLK_AUDIOREWIND: api.Key.AUDIOREWIND,
    SDLK_AUDIOFASTFORWARD: api.Key.AUDIOFASTFORWARD,
}


API_TO_SDLK = {v: k for k, v in SDLK_TO_API.items()}


HAT_TO_DIRECTION = {
    SDL_HAT_LEFTUP: (-1, 1), SDL_HAT_UP: (0, 1), SDL_HAT_RIGHTUP: (1, 1),
    SDL_HAT_LEFT: (-1, 0), SDL_HAT_CENTERED: (0, 0), SDL_HAT_RIGHT: (1, 0),
    SDL_HAT_LEFTDOWN: (-1, -1), SDL_HAT_DOWN: (0, -1), SDL_HAT_RIGHTDOWN: (1, -1),
}


SDL_CONTROLLER_BUTTON_TO_API = {
    SDL_CONTROLLER_BUTTON_A: api.ControllerButton.A,
    SDL_CONTROLLER_BUTTON_B: api.ControllerButton.B,
    SDL_CONTROLLER_BUTTON_X: api.ControllerButton.X,
    SDL_CONTROLLER_BUTTON_Y: api.ControllerButton.Y,
    SDL_CONTROLLER_BUTTON_BACK: api.ControllerButton.SELECT,
    SDL_CONTROLLER_BUTTON_START: api.ControllerButton.START,
    SDL_CONTROLLER_BUTTON_LEFTSTICK: api.ControllerButton.LEFT_STICK,
    SDL_CONTROLLER_BUTTON_RIGHTSTICK: api.ControllerButton.RIGHT_STICK,
    SDL_CONTROLLER_BUTTON_LEFTSHOULDER: api.ControllerButton.LEFT_SHOULDER,
    SDL_CONTROLLER_BUTTON_RIGHTSHOULDER: api.ControllerButton.RIGHT_SHOULDER,
}


PRESSED_KEYS = set()


def GetLastError():
    c_error_string = SDL_GetError()
    return c_error_string.decode('utf-8')


cdef to_mouse(uint32_t state, int x, int y):
    return api.Mouse(
        position=api.Position(x=x, y=y),
        left_button=((SDL_BUTTON_LMASK & state) > 0),
        middle_button=((SDL_BUTTON_MMASK & state) > 0),
        right_button=((SDL_BUTTON_RMASK & state) > 0),
        x1_button=((SDL_BUTTON_X1MASK & state) > 0),
        x2_button=((SDL_BUTTON_X2MASK & state) > 0)
    )


cdef to_key_modifiers(uint16_t mod):
    return api.KeyModifiers(
        ctrl=((KMOD_CTRL & mod) > 0),
        shift=((KMOD_SHIFT & mod) > 0),
        alt=((KMOD_ALT & mod) > 0)
    )


cdef get_current_mouse_state():
    cdef int x = 0
    cdef int y = 0
    cdef uint32_t state = SDL_GetMouseState(&x, &y)
    return to_mouse(state, x, y)


cdef get_current_mod_state():
    cdef uint16_t mod = SDL_GetModState()
    return to_key_modifiers(mod)


# cdef get_current_keyboard_state():
#     cdef uint8_t * state


class Controllers:

    def __init__(self):
        self.controllers = [None for _ in range(16)]

    def __repr__(self):
        return repr(self.controllers)

    def find(self, instance):
        for i, c in enumerate(self.controllers):
            if c == instance:
                return i
        raise RuntimeError('Device not found')

    def add(self, instance):
        for i, c in enumerate(self.controllers):
            if c is None:
                self.controllers[i] = instance
                return i
            if c == instance:
                return i
        raise RuntimeError('Cannot add a 17th controller')

    def remove(self, instance):
        for i, c in enumerate(self.controllers):
            if c == instance:
                self.controllers[i] = None
                return
        raise RuntimeError('Device not found')


cdef class TextureHandle:

    cdef SDL_Texture *texture

    property size:

        def __get__(self):
            cdef uint32_t pixel_format;
            cdef int texture_access;
            cdef int w;
            cdef int h;
            cdef int rc = SDL_QueryTexture(
                self.texture, &pixel_format,
                &texture_access, &w, &h
            )
            return w, h

    def __dealloc__(self):
        SDL_DestroyTexture(self.texture)


cdef class FontHandle:

    cdef TTF_Font *font

    def __dealloc__(self):
        TTF_CloseFont(self.font)


cdef class MusicHandle:

    cdef Mix_Music *music

    def __dealloc__(self):
        Mix_FreeMusic(self.music)


cdef class ChunkHandle:

    cdef Mix_Chunk *chunk

    def __dealloc__(self):
        Mix_FreeChunk(self.chunk)


cdef class Renderer:

    cdef SDL_Renderer *renderer
    cdef SDL_Window *window
    cdef SDL_Texture *back_buffer
    cdef int width
    cdef int height

    def __cinit__(self, str title, int width, int height):
        self.width = width
        self.height = height
        self.window = SDL_CreateWindow(
            title.encode('utf-8'),
            SDL_WINDOWPOS_UNDEFINED,
            SDL_WINDOWPOS_UNDEFINED,
            self.width, self.height,
            SDL_WINDOW_SHOWN |
            SDL_WINDOW_RESIZABLE
        )

        if self.window == NULL:
            raise RuntimeError(GetLastError())

        self.renderer = SDL_CreateRenderer(
            self.window, -1,
            SDL_RENDERER_ACCELERATED |
            SDL_RENDERER_TARGETTEXTURE
        )

        if self.renderer == NULL:
            raise RuntimeError(GetLastError())

        self.back_buffer = SDL_CreateTexture(
            self.renderer,
            SDL_PIXELFORMAT_RGBA8888,
            SDL_TEXTUREACCESS_TARGET,
            width, height
        )

        if self.back_buffer == NULL:
            raise RuntimeError(GetLastError())

    property scale:

        def __get__(self):
            cdef int width, height
            SDL_GetWindowSize(self.window, &width, &height)
            desired_aspect = float(self.width) / float(self.height)
            current_aspect = float(width) / float(height)
            if current_aspect > desired_aspect:
                return float(height) / float(self.height)
            else:
                return float(width) / float(self.width)

    property offset:

        def __get__(self):
            cdef int width, height
            SDL_GetWindowSize(self.window, &width, &height)
            scale = self.scale
            scaled_width = float(self.width) * scale
            scaled_height = float(self.height) * scale
            return (
                (float(width) - scaled_width) / 2,
                (float(height) - scaled_height) / 2
            )

    def screen_to_window_coords(self, x, y):
        scale = self.scale
        ox, oy = self.offset
        nx, ny = float(x) - ox, float(y) - oy
        sx, sy = int(nx / scale), int(ny / scale)
        if sx >= 0 and sy >= 0 and sx < self.width and sy < self.height:
            return sx, sy
        else:
            return None, None

    @functools.lru_cache()
    def _load_font(self, font_info):
        cdef FontHandle handle = FontHandle()
        cdef TTF_Font *font = TTF_OpenFont(font_info.filename.encode('utf-8'), font_info.size)
        handle.font = font
        return handle

    @functools.lru_cache()
    def _load_image(self, filename):
        cdef TextureHandle handle = TextureHandle()
        cdef SDL_Texture *texture = IMG_LoadTexture(self.renderer, filename.encode('utf-8'))
        handle.texture = texture
        return handle

    @functools.lru_cache()
    def _load_static_texture(self, texture):
        cdef SDL_Texture * t = SDL_CreateTexture(
            self.renderer,
            SDL_PIXELFORMAT_RGBA8888,
            SDL_TEXTUREACCESS_TARGET,
            texture.size,
            texture.size
        )
        cdef TextureHandle handle = TextureHandle()
        handle.texture = t
        SDL_SetRenderTarget(self.renderer, handle.texture)
        texture.draw(self)
        SDL_SetRenderTarget(self.renderer, self.back_buffer)
        return handle

    @functools.lru_cache()
    def _rasterize_text(self, font_info, text):
        cdef FontHandle font = self._load_font(font_info)
        cdef TextureHandle handle = TextureHandle()
        cdef SDL_Surface *surface = TTF_RenderUTF8_Solid(font.font, text.encode('utf-8'), SDL_Color(255, 255, 255, 255))
        cdef SDL_Texture *texture = SDL_CreateTextureFromSurface(self.renderer, surface)
        SDL_FreeSurface(surface)
        handle.texture = texture
        return handle

    def clear_render_cache(self):
        self._load_image.cache_clear()
        self._load_static_texture.cache_clear()

    def draw_image(self, image, position):
        cdef TextureHandle handle = self._load_image(image.filename)
        cdef SDL_Rect source = SDL_Rect(image.clip.x, image.clip.y, image.clip.w, image.clip.h)
        cdef SDL_Rect dest = SDL_Rect(position.x, position.y, image.clip.w, image.clip.h)
        SDL_RenderCopy(self.renderer, handle.texture, &source, &dest)

    def draw_text(self, font, text, position):
        cdef TextureHandle handle = self._rasterize_text(font, text)
        w, h = handle.size
        cdef SDL_Rect dest = SDL_Rect(position.x, position.y, w, h)
        SDL_RenderCopy(self.renderer, handle.texture, NULL, &dest)

    def draw_static_texture(self, texture, clip, position):
        cdef TextureHandle handle = self._load_static_texture(texture)
        cdef SDL_Rect source = SDL_Rect(clip.x, clip.y, clip.w, clip.h)
        cdef SDL_Rect dest = SDL_Rect(position.x, position.y, clip.w, clip.h)
        SDL_RenderCopy(self.renderer, handle.texture, &source, &dest)

    def clear(self):
        SDL_SetRenderTarget(self.renderer, self.back_buffer)
        if SDL_SetRenderDrawColor(self.renderer, 0, 0, 0, 255) != 0:
            raise RuntimeError(GetLastError())
        if SDL_RenderClear(self.renderer) != 0:
            raise RuntimeError(GetLastError())

    def present(self):
        SDL_SetRenderTarget(self.renderer, NULL)
        x, y = self.offset
        scale = self.scale
        w, h = self.width * scale, self.height * scale
        cdef SDL_Rect dest
        dest.x = int(x)
        dest.y = int(y)
        dest.w = int(w)
        dest.h = int(h)
        SDL_RenderCopy(self.renderer, self.back_buffer, NULL, &dest)
        SDL_RenderPresent(self.renderer)

    def __dealloc__(self):
        SDL_DestroyTexture(self.back_buffer)
        SDL_DestroyRenderer(self.renderer)
        SDL_DestroyWindow(self.window)


class Audio:

    def __init__(self):
        self.music_playing = ""

    def play_music(self, filename):
        cdef MusicHandle handle
        if self.music_playing != filename:
            self.stop_music()
            self.music_playing = filename
            handle = self._load_music(filename)
            Mix_PlayMusic(handle.music, -1)

    def stop_music(self):
        self.music_playing == ""
        if Mix_PlayingMusic() != 0:
            Mix_HaltMusic()

    def play_effect(self, filename):
        cdef ChunkHandle handle = self._load_chunk(filename)
        Mix_PlayChannelTimed(-1, handle.chunk, 0, -1)

    @functools.lru_cache()
    def _load_music(self, filename):
        cdef MusicHandle handle = MusicHandle()
        cdef Mix_Music *music = Mix_LoadMUS(filename.encode('utf-8'))
        handle.music = music
        return handle

    @functools.lru_cache()
    def _load_chunk(self, filename):
        cdef ChunkHandle handle = ChunkHandle()
        cdef Mix_Chunk *chunk = Mix_LoadWAV_RW(SDL_RWFromFile(filename.encode('utf-8'), "rb"), 1)
        handle.chunk = chunk
        return handle

    def process(self, model):
        if model.music != "":
            self.play_music(model.music)

        for effect in model.sound_effects:
            self.play_effect(effect)

        model = model.set(sound_effects=[])

        return model


def run(title, width, height, model, delay_per_frame):

    cdef SDL_Event event

    if SDL_Init(SDL_INIT_AUDIO | SDL_INIT_VIDEO | SDL_INIT_GAMECONTROLLER) != 0:
        raise RuntimeError(GetLastError())

    if IMG_Init(IMG_INIT_JPG | IMG_INIT_PNG) != (IMG_INIT_JPG | IMG_INIT_PNG):
        raise RuntimeError(GetLastError())

    if TTF_Init() != 0:
        raise RuntimeError(GetLastError())

    if Mix_Init(MIX_INIT_OGG) != MIX_INIT_OGG:
        raise RuntimeError(GetLastError())

    if Mix_OpenAudio(MIX_DEFAULT_FREQUENCY * 2, MIX_DEFAULT_FORMAT, MIX_DEFAULT_CHANNELS, 1024) < 0:
        raise RuntimeError(GetLastError())

    renderer = Renderer(title, width, height)
    controllers = Controllers()
    audio = Audio()

    while True:

        while (SDL_PollEvent(&event) != 0):

            if event.type == SDL_AUDIODEVICEADDED:
                model = model.on_audio_device_added(
                    event.adevice.which,
                    event.adevice.iscapture
                )

            elif event.type == SDL_AUDIODEVICEREMOVED:
                model = model.on_audio_device_removed(
                    event.adevice.which,
                    event.adevice.iscapture
                )

            elif event.type == SDL_CONTROLLERBUTTONDOWN:
                if event.cbutton.button in SDL_CONTROLLER_BUTTON_TO_API:
                    model = model.on_controller_button_down(
                        controllers.find(event.cbutton.which),
                        SDL_CONTROLLER_BUTTON_TO_API[event.cbutton.button]
                    )

            elif event.type == SDL_CONTROLLERBUTTONUP:
                if event.cbutton.button in SDL_CONTROLLER_BUTTON_TO_API:
                    model = model.on_controller_button_up(
                        controllers.find(event.cbutton.which),
                        SDL_CONTROLLER_BUTTON_TO_API[event.cbutton.button]
                    )

            elif event.type == SDL_CONTROLLERDEVICEADDED:
                instance = SDL_JoystickInstanceID(
                    SDL_GameControllerGetJoystick(
                        SDL_GameControllerOpen(event.cdevice.which)
                    )
                )
                model = model.on_controller_device_added(event.cdevice.which)
                controllers.add(instance)

            elif event.type == SDL_CONTROLLERDEVICEREMOVED:
                model = model.on_controller_device_removed(event.cdevice.which)
                controllers.remove(event.cdevice.which)

            elif event.type == SDL_JOYHATMOTION:
                controller = controllers.find(event.jhat.which)
                x, y = HAT_TO_DIRECTION.get(event.jhat.value, (0, 0))
                model = model.on_controller_dpad(controller, x, y)

            elif event.type == SDL_KEYDOWN:
                if event.key.repeat == 0:
                    key = SDLK_TO_API.get(event.key.keysym.sym, api.Key.UNKNOWN)
                    PRESSED_KEYS.add(key)
                    model = model.on_key_down(
                        key, to_key_modifiers(event.key.keysym.mod)
                    )

            elif event.type == SDL_KEYUP:
                key = SDLK_TO_API.get(event.key.keysym.sym, api.Key.UNKNOWN)
                PRESSED_KEYS.remove(key)
                model = model.on_key_up(
                    key, to_key_modifiers(event.key.keysym.mod)
                )

            elif event.type == SDL_MOUSEBUTTONDOWN:
                x, y = renderer.screen_to_window_coords(
                    event.button.x, event.button.y
                )
                if x is not None:
                    model = model.on_mouse_button_down(
                        SDL_BUTTON_TO_API.get(event.button.button, api.MouseButton.UNKNOWN),
                        api.Position(x=x, y=y)
                    )

            elif event.type == SDL_MOUSEBUTTONUP:
                x, y = renderer.screen_to_window_coords(
                    event.button.x, event.button.y
                )
                if x is not None:
                    model = model.on_mouse_button_up(
                        SDL_BUTTON_TO_API.get(event.button.button, api.MouseButton.UNKNOWN),
                        api.Position(x=x, y=y)
                    )

            elif event.type == SDL_MOUSEMOTION:
                x, y = renderer.screen_to_window_coords(
                    event.motion.x, event.motion.y
                )
                scale = float(renderer.scale)
                xrel, yrel = (
                    float(event.motion.xrel) / scale,
                    float(event.motion.yrel) / scale
                )
                if x is not None:
                    model = model.on_mouse_motion(
                        to_mouse(event.motion.state, x, y),
                        api.Distance(x=xrel, y=yrel)
                    )

            elif event.type == SDL_MOUSEWHEEL:
                model = model.on_mouse_wheel(
                    -event.wheel.x if event.wheel.direction else event.wheel.x,
                    -event.wheel.y if event.wheel.direction else event.wheel.y
                )

            elif event.type == SDL_QUIT:
                model = model.on_quit()

            elif event.type == SDL_TEXTINPUT:
                model = model.on_text_input(
                    event.text.text.decode('utf-8')
                )

            elif event.type == SDL_RENDER_TARGETS_RESET:
                renderer.clear_render_cache()

            elif event.type == SDL_WINDOWEVENT:

                window_event = event.window

                if window_event.event == SDL_WINDOWEVENT_SHOWN:
                    model = model.on_window_shown()

                elif window_event.event == SDL_WINDOWEVENT_HIDDEN:
                    model = model.on_window_hidden()

                elif window_event.event == SDL_WINDOWEVENT_EXPOSED:
                    model = model.on_window_exposed()

                elif window_event.event == SDL_WINDOWEVENT_MOVED:
                    model = model.on_window_moved(
                        api.Position(x=event.window.data1, y=event.window.data2)
                    )

                elif window_event.event == SDL_WINDOWEVENT_SIZE_CHANGED:
                    model = model.on_window_size_changed(
                        api.Size(w=event.window.data1, h=event.window.data2)
                    )

                elif window_event.event == SDL_WINDOWEVENT_MINIMIZED:
                    model = model.on_window_minimized()

                elif window_event.event == SDL_WINDOWEVENT_MAXIMIZED:
                    model = model.on_window_maximized()

                elif window_event.event == SDL_WINDOWEVENT_RESTORED:
                    model = model.on_window_restored()

                elif window_event.event == SDL_WINDOWEVENT_ENTER:
                    model = model.on_window_enter()

                elif window_event.event == SDL_WINDOWEVENT_LEAVE:
                    model = model.on_window_leave()

                elif window_event.event == SDL_WINDOWEVENT_FOCUS_GAINED:
                    model = model.on_window_focus_gained()

                elif window_event.event == SDL_WINDOWEVENT_FOCUS_LOST:
                    model = model.on_window_focus_lost()

                elif window_event.event == SDL_WINDOWEVENT_CLOSE:
                    model = model.on_window_close()

            if model.should_close:
                break

            model = audio.process(model)

        if model.should_close:
            break

        controls = api.Controls(
            mouse=get_current_mouse_state(),
            key_mods=get_current_mod_state(),
            controllers=[],
            keyboard=PRESSED_KEYS
        )

        model = model.on_update(controls)
        model = audio.process(model)

        if model.should_close:
            break

        renderer.clear()
        model.draw(renderer)
        renderer.present()

        SDL_Delay(delay_per_frame)

    Mix_CloseAudio()
    Mix_Quit()
    IMG_Quit()
    SDL_Quit()
