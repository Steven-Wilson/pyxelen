class DemoEventHandler:

    def __init__(self, pyxelen):
        self.pyxelen = pyxelen
        self.window = self.pyxelen.open_window('This is a test', 500, 500)
        self.renderer = self.window.create_renderer()

    def run(self):
        self.pyxelen.run(self, 16)

    def on_update_and_render(self):
        self.renderer.clear()
        self.renderer.present()


def main(pyxelen):
    DemoEventHandler(pyxelen).run()
