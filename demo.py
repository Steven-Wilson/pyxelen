import time

from pyxelen import (
    open_window,
    run_fixed_frame_rate,
    WindowFlag,
)

window = open_window("this is a triumph", 800, 600, WindowFlag.SHOWN | WindowFlag.RESIZABLE)

frame_start = 0
frame_render_start = 0
frame_render_end = 0
frame_end = 0

for event in run_fixed_frame_rate(16):
    if event.name == 'on_frame_start':
        frame_start = event.timestamp
    elif event.name == 'on_frame_render_start':
        frame_render_start = event.timestamp
        #print(f"EVENT:  {frame_render_start - frame_start}")
        window.clear()
        window.present()
    elif event.name == 'on_frame_render_end':
        frame_render_end = event.timestamp
        #print(f"RENDER: {frame_render_end - frame_render_start}")
    elif event.name == 'on_frame_end':
        frame_end = event.timestamp
        #print(f"WAIT:   {frame_end - frame_render_end}")
    elif event.name == 'on_mouse_motion':
        mouse = event.mouse
        window.set_draw_color(mouse.x_position % 255, mouse.y_position % 255, 23, 255)
    elif "controller" in event.name:
        print(event)

