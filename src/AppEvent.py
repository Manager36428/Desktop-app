# This Python file uses the following encoding: utf-8

import threading
import time

from PySide2 import QtCore
from PySide2.QtCore import Signal, Slot
from pynput import mouse


class AppEvent(QtCore.QObject):
    _mouse_listener = None
    _mouse_thread = None

    def on_click(self, x, y, button, pressed):
        if pressed:
            print(f"Mouse clicked at ({x}, {y}) with {button}")
            self.emit_signal()

    def start_mouse_listener(self):
        global mouse_listener, mouse_thread

        mouse_listener = mouse.Listener(on_click=self.on_click)
        mouse_thread = threading.Thread(target=mouse_listener.start)
        mouse_thread.start()

    def stop_mouse_listener(self):
        global mouse_listener, mouse_thread

        if mouse_listener is not None:
            mouse_listener.stop()
            mouse_listener = None

        if mouse_thread is not None:
            mouse_thread.join()
            mouse_thread = None

    def run(self):
        try:
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            self.stop_mouse_listener()

    def __init__(self):
        super().__init__()

    clickedFromWindow = Signal()

    def emit_signal(self):
        self.clickedFromWindow.emit()
