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


class Key(enum.IntEnum):
    K_UNKNOWN = 1
    K_RETURN = 2
    K_ESCAPE = 3
    K_BACKSPACE = 4
    K_TAB = 5
    K_SPACE = 6
    K_EXCLAIM = 7
    K_QUOTEDBL = 8
    K_HASH = 9
    K_PERCENT = 10
    K_DOLLAR = 11
    K_AMPERSAND = 12
    K_QUOTE = 13
    K_LEFTPAREN = 14
    K_RIGHTPAREN = 15
    K_ASTERISK = 16
    K_PLUS = 17
    K_COMMA = 18
    K_MINUS = 19
    K_PERIOD = 20
    K_SLASH = 21
    K_0 = 22
    K_1 = 23
    K_2 = 24
    K_3 = 25
    K_4 = 26
    K_5 = 27
    K_6 = 28
    K_7 = 29
    K_8 = 30
    K_9 = 31
    K_COLON = 32
    K_SEMICOLON = 33
    K_LESS = 34
    K_EQUALS = 35
    K_GREATER = 36
    K_QUESTION = 37
    K_AT = 38
    K_LEFTBRACKET = 39
    K_BACKSLASH = 40
    K_RIGHTBRACKET = 41
    K_CARET = 42
    K_UNDERSCORE = 43
    K_BACKQUOTE = 44
    K_a = 45
    K_b = 46
    K_c = 47
    K_d = 48
    K_e = 49
    K_f = 50
    K_g = 51
    K_h = 52
    K_i = 53
    K_j = 54
    K_k = 55
    K_l = 56
    K_m = 57
    K_n = 58
    K_o = 59
    K_p = 60
    K_q = 61
    K_r = 62
    K_s = 63
    K_t = 64
    K_u = 65
    K_v = 66
    K_w = 67
    K_x = 68
    K_y = 69
    K_z = 70
    K_CAPSLOCK = 71
    K_F1 = 72
    K_F2 = 73
    K_F3 = 74
    K_F4 = 75
    K_F5 = 76
    K_F6 = 77
    K_F7 = 78
    K_F8 = 79
    K_F9 = 80
    K_F10 = 81
    K_F11 = 82
    K_F12 = 83
    K_PRINTSCREEN = 84
    K_SCROLLLOCK = 85
    K_PAUSE = 86
    K_INSERT = 87
    K_HOME = 88
    K_PAGEUP = 89
    K_DELETE = 90
    K_END = 91
    K_PAGEDOWN = 92
    K_RIGHT = 93
    K_LEFT = 94
    K_DOWN = 95
    K_UP = 96
    K_NUMLOCKCLEAR = 97
    K_KP_DIVIDE = 98
    K_KP_MULTIPLY = 99
    K_KP_MINUS = 100
    K_KP_PLUS = 101
    K_KP_ENTER = 102
    K_KP_1 = 103
    K_KP_2 = 104
    K_KP_3 = 105
    K_KP_4 = 106
    K_KP_5 = 107
    K_KP_6 = 108
    K_KP_7 = 109
    K_KP_8 = 110
    K_KP_9 = 111
    K_KP_0 = 112
    K_KP_PERIOD = 113
    K_APPLICATION = 114
    K_POWER = 115
    K_KP_EQUALS = 116
    K_F13 = 117
    K_F14 = 118
    K_F15 = 119
    K_F16 = 120
    K_F17 = 121
    K_F18 = 122
    K_F19 = 123
    K_F20 = 124
    K_F21 = 125
    K_F22 = 126
    K_F23 = 127
    K_F24 = 128
    K_EXECUTE = 129
    K_HELP = 130
    K_MENU = 131
    K_SELECT = 132
    K_STOP = 133
    K_AGAIN = 134
    K_UNDO = 135
    K_CUT = 136
    K_COPY = 137
    K_PASTE = 138
    K_FIND = 139
    K_MUTE = 140
    K_VOLUMEUP = 141
    K_VOLUMEDOWN = 142
    K_KP_COMMA = 143
    K_KP_EQUALSAS400 = 144
    K_ALTERASE = 145
    K_SYSREQ = 146
    K_CANCEL = 147
    K_CLEAR = 148
    K_PRIOR = 149
    K_RETURN2 = 150
    K_SEPARATOR = 151
    K_OUT = 152
    K_OPER = 153
    K_CLEARAGAIN = 154
    K_CRSEL = 155
    K_EXSEL = 156
    K_KP_00 = 157
    K_KP_000 = 158
    K_THOUSANDSSEPARATOR = 159
    K_DECIMALSEPARATOR = 160
    K_CURRENCYUNIT = 161
    K_CURRENCYSUBUNIT = 162
    K_KP_LEFTPAREN = 163
    K_KP_RIGHTPAREN = 164
    K_KP_LEFTBRACE = 165
    K_KP_RIGHTBRACE = 166
    K_KP_TAB = 167
    K_KP_BACKSPACE = 168
    K_KP_A = 169
    K_KP_B = 170
    K_KP_C = 171
    K_KP_D = 172
    K_KP_E = 173
    K_KP_F = 174
    K_KP_XOR = 175
    K_KP_POWER = 176
    K_KP_PERCENT = 177
    K_KP_LESS = 178
    K_KP_GREATER = 179
    K_KP_AMPERSAND = 180
    K_KP_DBLAMPERSAND = 181
    K_KP_VERTICALBAR = 182
    K_KP_DBLVERTICALBAR = 183
    K_KP_COLON = 184
    K_KP_HASH = 185
    K_KP_SPACE = 186
    K_KP_AT = 187
    K_KP_EXCLAM = 188
    K_KP_MEMSTORE = 189
    K_KP_MEMRECALL = 190
    K_KP_MEMCLEAR = 191
    K_KP_MEMADD = 192
    K_KP_MEMSUBTRACT = 193
    K_KP_MEMMULTIPLY = 194
    K_KP_MEMDIVIDE = 195
    K_KP_PLUSMINUS = 196
    K_KP_CLEAR = 197
    K_KP_CLEARENTRY = 198
    K_KP_BINARY = 199
    K_KP_OCTAL = 200
    K_KP_DECIMAL = 201
    K_KP_HEXADECIMAL = 202
    K_LCTRL = 203
    K_LSHIFT = 204
    K_LALT = 205
    K_LGUI = 206
    K_RCTRL = 207
    K_RSHIFT = 208
    K_RALT = 209
    K_RGUI = 210
    K_MODE = 211
    K_AUDIONEXT = 212
    K_AUDIOPREV = 213
    K_AUDIOSTOP = 214
    K_AUDIOPLAY = 215
    K_AUDIOMUTE = 216
    K_MEDIASELECT = 217
    K_WWW = 218
    K_MAIL = 219
    K_CALCULATOR = 220
    K_COMPUTER = 221
    K_AC_SEARCH = 222
    K_AC_HOME = 223
    K_AC_BACK = 224
    K_AC_FORWARD = 225
    K_AC_STOP = 226
    K_AC_REFRESH = 227
    K_AC_BOOKMARKS = 228
    K_BRIGHTNESSDOWN = 229
    K_BRIGHTNESSUP = 230
    K_DISPLAYSWITCH = 231
    K_KBDILLUMTOGGLE = 232
    K_KBDILLUMDOWN = 233
    K_KBDILLUMUP = 234
    K_EJECT = 235
    K_SLEEP = 236
    K_APP1 = 237
    K_APP2 = 238
    K_AUDIOREWIND = 239
    K_AUDIOFASTFORWARD = 240


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
