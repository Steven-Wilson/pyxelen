import enum
from pyrsistent import field, PClass


class Position(PClass):
    x = field(type=int, mandatory=True)
    y = field(type=int, mandatory=True)


class Distance(PClass):
    x = field(type=float, mandatory=True)
    y = field(type=float, mandatory=True)


class Size(PClass):
    w = field(type=int, mandatory=True)
    h = field(type=int, mandatory=True)


class Box(PClass):
    size = field(type=Size, mandatory=True)
    position = field(type=Position, mandatory=True)

    @property
    def x(self):
        return self.position.x

    @property
    def y(self):
        return self.position.y

    @property
    def w(self):
        return self.size.w

    @property
    def h(self):
        return self.size.h


class SubImage(PClass):
    filename = field(type=str, mandatory=True)
    clip = field(type=Box, mandatory=True)


class StaticTexture(PClass):
    unique_name = field(type=str, mandatory=True)
    size = field(type=int, mandatory=True)

    def draw(self, renderer):
        pass


class Font(PClass):
    filename = field(type=str, mandatory=True)
    size = field(type=int, mandatory=True)


class Key(enum.IntEnum):
    UNKNOWN = 1
    RETURN = 2
    ESCAPE = 3
    BACKSPACE = 4
    TAB = 5
    SPACE = 6
    EXCLAIM = 7
    QUOTEDBL = 8
    HASH = 9
    PERCENT = 10
    DOLLAR = 11
    AMPERSAND = 12
    QUOTE = 13
    LEFTPAREN = 14
    RIGHTPAREN = 15
    ASTERISK = 16
    PLUS = 17
    COMMA = 18
    MINUS = 19
    PERIOD = 20
    SLASH = 21
    K0 = 22
    K1 = 23
    K2 = 24
    K3 = 25
    K4 = 26
    K5 = 27
    K6 = 28
    K7 = 29
    K8 = 30
    K9 = 31
    COLON = 32
    SEMICOLON = 33
    LESS = 34
    EQUALS = 35
    GREATER = 36
    QUESTION = 37
    AT = 38
    LEFTBRACKET = 39
    BACKSLASH = 40
    RIGHTBRACKET = 41
    CARET = 42
    UNDERSCORE = 43
    BACKQUOTE = 44
    A = 45
    B = 46
    C = 47
    D = 48
    E = 49
    F = 50
    G = 51
    H = 52
    I = 53
    J = 54
    K = 55
    L = 56
    M = 57
    N = 58
    O = 59
    P = 60
    Q = 61
    R = 62
    S = 63
    T = 64
    U = 65
    V = 66
    W = 67
    X = 68
    Y = 69
    Z = 70
    CAPSLOCK = 71
    F1 = 72
    F2 = 73
    F3 = 74
    F4 = 75
    F5 = 76
    F6 = 77
    F7 = 78
    F8 = 79
    F9 = 80
    F10 = 81
    F11 = 82
    F12 = 83
    PRINTSCREEN = 84
    SCROLLLOCK = 85
    PAUSE = 86
    INSERT = 87
    HOME = 88
    PAGEUP = 89
    DELETE = 90
    END = 91
    PAGEDOWN = 92
    RIGHT = 93
    LEFT = 94
    DOWN = 95
    UP = 96
    NUMLOCKCLEAR = 97
    KP_DIVIDE = 98
    KP_MULTIPLY = 99
    KP_MINUS = 100
    KP_PLUS = 101
    KP_ENTER = 102
    KP_1 = 103
    KP_2 = 104
    KP_3 = 105
    KP_4 = 106
    KP_5 = 107
    KP_6 = 108
    KP_7 = 109
    KP_8 = 110
    KP_9 = 111
    KP_0 = 112
    KP_PERIOD = 113
    APPLICATION = 114
    POWER = 115
    KP_EQUALS = 116
    F13 = 117
    F14 = 118
    F15 = 119
    F16 = 120
    F17 = 121
    F18 = 122
    F19 = 123
    F20 = 124
    F21 = 125
    F22 = 126
    F23 = 127
    F24 = 128
    EXECUTE = 129
    HELP = 130
    MENU = 131
    SELECT = 132
    STOP = 133
    AGAIN = 134
    UNDO = 135
    CUT = 136
    COPY = 137
    PASTE = 138
    FIND = 139
    MUTE = 140
    VOLUMEUP = 141
    VOLUMEDOWN = 142
    KP_COMMA = 143
    KP_EQUALSAS400 = 144
    ALTERASE = 145
    SYSREQ = 146
    CANCEL = 147
    CLEAR = 148
    PRIOR = 149
    RETURN2 = 150
    SEPARATOR = 151
    OUT = 152
    OPER = 153
    CLEARAGAIN = 154
    CRSEL = 155
    EXSEL = 156
    KP_00 = 157
    KP_000 = 158
    THOUSANDSSEPARATOR = 159
    DECIMALSEPARATOR = 160
    CURRENCYUNIT = 161
    CURRENCYSUBUNIT = 162
    KP_LEFTPAREN = 163
    KP_RIGHTPAREN = 164
    KP_LEFTBRACE = 165
    KP_RIGHTBRACE = 166
    KP_TAB = 167
    KP_BACKSPACE = 168
    KP_A = 169
    KP_B = 170
    KP_C = 171
    KP_D = 172
    KP_E = 173
    KP_F = 174
    KP_XOR = 175
    KP_POWER = 176
    KP_PERCENT = 177
    KP_LESS = 178
    KP_GREATER = 179
    KP_AMPERSAND = 180
    KP_DBLAMPERSAND = 181
    KP_VERTICALBAR = 182
    KP_DBLVERTICALBAR = 183
    KP_COLON = 184
    KP_HASH = 185
    KP_SPACE = 186
    KP_AT = 187
    KP_EXCLAM = 188
    KP_MEMSTORE = 189
    KP_MEMRECALL = 190
    KP_MEMCLEAR = 191
    KP_MEMADD = 192
    KP_MEMSUBTRACT = 193
    KP_MEMMULTIPLY = 194
    KP_MEMDIVIDE = 195
    KP_PLUSMINUS = 196
    KP_CLEAR = 197
    KP_CLEARENTRY = 198
    KP_BINARY = 199
    KP_OCTAL = 200
    KP_DECIMAL = 201
    KP_HEXADECIMAL = 202
    LCTRL = 203
    LSHIFT = 204
    LALT = 205
    LGUI = 206
    RCTRL = 207
    RSHIFT = 208
    RALT = 209
    RGUI = 210
    MODE = 211
    AUDIONEXT = 212
    AUDIOPREV = 213
    AUDIOSTOP = 214
    AUDIOPLAY = 215
    AUDIOMUTE = 216
    MEDIASELECT = 217
    WWW = 218
    MAIL = 219
    CALCULATOR = 220
    COMPUTER = 221
    AC_SEARCH = 222
    AC_HOME = 223
    AC_BACK = 224
    AC_FORWARD = 225
    AC_STOP = 226
    AC_REFRESH = 227
    AC_BOOKMARKS = 228
    BRIGHTNESSDOWN = 229
    BRIGHTNESSUP = 230
    DISPLAYSWITCH = 231
    KBDILLUMTOGGLE = 232
    KBDILLUMDOWN = 233
    KBDILLUMUP = 234
    EJECT = 235
    SLEEP = 236
    APP1 = 237
    APP2 = 238
    AUDIOREWIND = 239
    AUDIOFASTFORWARD = 240


class Mouse(PClass):
    position = field(type=Position, mandatory=True)
    left_button = field(type=bool, mandatory=True)
    middle_button = field(type=bool, mandatory=True)
    right_button = field(type=bool, mandatory=True)
    x1_button = field(type=bool, mandatory=True)
    x2_button = field(type=bool, mandatory=True)


class DPad(PClass):
    up = field(bool, mandatory=True)
    left = field(bool, mandatory=True)
    right = field(bool, mandatory=True)
    down = field(bool, mandatory=True)


class KeyModifiers(PClass):
    ctrl = field(type=bool, mandatory=True)
    shift = field(type=bool, mandatory=True)
    alt = field(type=bool, mandatory=True)


class Controller(PClass):
    left_trigger = field(type=float, mandatory=True)
    right_trigger = field(type=float, mandatory=True)
    left_stick = field(type=tuple, mandatory=True)
    left_stick_button = field(type=bool, mandatory=True)
    right_stick = field(type=tuple, mandatory=True)
    right_stick_button = field(type=bool, mandatory=True)
    select = field(type=bool, mandatory=True)
    start = field(type=bool, mandatory=True)
    left_shoulder = field(type=bool, mandatory=True)
    right_shoulder = field(type=bool, mandatory=True)
    a_button = field(type=bool, mandatory=True)
    b_button = field(type=bool, mandatory=True)
    x_button = field(type=bool, mandatory=True)
    y_button = field(type=bool, mandatory=True)
    dpad = field(type=DPad, mandatory=True)


class Controls(PClass):
    mouse = field(type=Mouse, mandatory=True)
    key_mods = field(type=KeyModifiers, mandatory=True)
    controllers = field(type=list, mandatory=True)
    keyboard = field(mandatory=True)


class ControllerButton(enum.IntEnum):
    A = 0
    B = 1
    X = 2
    Y = 3
    LEFT_SHOULDER = 4
    RIGHT_SHOULDER = 5
    SELECT = 6
    START = 7
    LEFT_STICK = 8
    RIGHT_STICK = 9


class MouseButton(enum.IntEnum):
    LEFT = 1
    MIDDLE = 2
    RIGHT = 3
    X1 = 4
    X2 = 5
    UNKNOWN = 6


TRACE_UNHANDLED_EVENTS = True


class Model(PClass):
    should_close = field(type=bool, mandatory=True, initial=False)
    music = field(type=str, mandatory=True, initial="")
    sound_effects = field(type=list, mandatory=True, initial=[])

    def draw(self, renderer):
        pass

    def on_update(self, controls):
        if TRACE_UNHANDLED_EVENTS:
            print('on_update:', repr((controls)))
        return self

    def on_audio_device_added(self, device, is_capture):
        if TRACE_UNHANDLED_EVENTS:
            print('on_audio_device_added:', repr((device, is_capture)))
        return self

    def on_audio_device_removed(self, device, is_capture):
        if TRACE_UNHANDLED_EVENTS:
            print('on_audio_device_removed:', repr((device, is_capture)))
        return self

    def on_controller_button_down(self, controller, button):
        if TRACE_UNHANDLED_EVENTS:
            print('on_controller_button_down:', repr((controller, button)))
        return self

    def on_controller_button_up(self, controller, button):
        if TRACE_UNHANDLED_EVENTS:
            print('on_controller_button_up:', repr((controller, button)))
        return self

    def on_controller_device_added(self, controller):
        if TRACE_UNHANDLED_EVENTS:
            print('on_controller_device_added:', repr(controller))
        return self

    def on_controller_device_removed(self, controller):
        if TRACE_UNHANDLED_EVENTS:
            print('on_controller_device_removed:', repr(controller))
        return self

    def on_controller_dpad(self, controller, x, y):
        if TRACE_UNHANDLED_EVENTS:
            print('on_controller_dpad:', repr((controller, x, y)))
        return self

    def on_key_down(self, key, modifiers):
        if TRACE_UNHANDLED_EVENTS:
            print('on_key_down:', repr((key, modifiers)))
        return self

    def on_key_up(self, key, modifiers):
        if TRACE_UNHANDLED_EVENTS:
            print('on_key_up:', repr((key, modifiers)))
        return self

    def on_mouse_button_down(self, button, position):
        if TRACE_UNHANDLED_EVENTS:
            print('on_mouse_button_down:', repr((button, position)))
        return self

    def on_mouse_button_up(self, button, position):
        if TRACE_UNHANDLED_EVENTS:
            print('on_mouse_button_up:', repr((button, position)))
        return self

    def on_mouse_motion(self, mouse, distance):
        if TRACE_UNHANDLED_EVENTS:
            print('on_mouse_motion:', repr((mouse, distance)))
        return self

    def on_mouse_wheel(self, x, y):
        if TRACE_UNHANDLED_EVENTS:
            print('on_mouse_wheel:', repr((x, y)))
        return self

    def on_quit(self):
        if TRACE_UNHANDLED_EVENTS:
            print('on_quit')
        return self.set(should_close=True)

    def on_text_input(self, text):
        if TRACE_UNHANDLED_EVENTS:
            print('on_text_input:', repr(text))
        return self

    def on_window_shown(self):
        if TRACE_UNHANDLED_EVENTS:
            print('on_window_shown')
        return self

    def on_window_hidden(self):
        if TRACE_UNHANDLED_EVENTS:
            print('on_window_hidden')
        return self

    def on_window_exposed(self):
        if TRACE_UNHANDLED_EVENTS:
            print('on_window_exposed')
        return self

    def on_window_moved(self, position):
        if TRACE_UNHANDLED_EVENTS:
            print('on_window_moved:', repr(position))
        return self

    def on_window_size_changed(self, size):
        if TRACE_UNHANDLED_EVENTS:
            print('on_window_size_changed:', repr(size))
        return self

    def on_window_minimized(self):
        if TRACE_UNHANDLED_EVENTS:
            print('on_window_minimized')
        return self

    def on_window_maximized(self):
        if TRACE_UNHANDLED_EVENTS:
            print('on_window_maximized')
        return self

    def on_window_restored(self):
        if TRACE_UNHANDLED_EVENTS:
            print('on_window_restored')
        return self

    def on_window_enter(self):
        if TRACE_UNHANDLED_EVENTS:
            print('on_window_enter')
        return self

    def on_window_leave(self):
        if TRACE_UNHANDLED_EVENTS:
            print('on_window_leave')
        return self

    def on_window_focus_gained(self):
        if TRACE_UNHANDLED_EVENTS:
            print('on_window_focus_gained')
        return self

    def on_window_focus_lost(self):
        if TRACE_UNHANDLED_EVENTS:
            print('on_window_focus_lost')
        return self

    def on_window_close(self):
        if TRACE_UNHANDLED_EVENTS:
            print('on_window_close')
        return self.set(should_close=True)
