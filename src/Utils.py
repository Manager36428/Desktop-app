# This Python file uses the following encoding: utf-8
import ctypes
import os
from datetime import datetime

import pyautogui
from PIL import ImageGrab
from PySide2 import QtCore
from PySide2.QtCore import Slot, QFile, QIODevice, QResource, Signal
from PySide2.QtGui import QColor, QImage

from src.AppEvent import AppEvent


class Utils(QtCore.QObject):
    _app_event = AppEvent()

    def __init__(self):
        super().__init__()
        self._app_event.clickedFromWindow.connect(self.handle_signal_from_app_event)

    @staticmethod
    def percent_to255(value):
        return 255 * (float(value) / 100)

    @Slot(str, result=int)
    def hsv_hue(self, color):
        qcolor = QColor(color)
        return qcolor.hsvHue()

    @Slot(str, result=int)
    def hsv_s(self, color):
        qcolor = QColor(color)
        return qcolor.hsvSaturation()

    @Slot(str, result=float)
    def hsv_sF(self, color):
        qcolor = QColor(color)
        return qcolor.hsvSaturationF()

    @Slot(str, result=float)
    def hsl_saturationF(self, color):
        qcolor = QColor(color)
        return qcolor.hslSaturationF()

    @Slot(str, result=float)
    def hsl_lightnessF(self, color):
        qcolor = QColor(color)
        return qcolor.lightnessF()

    @Slot(str, result=bool)
    def is_valid_color(self, color):
        return QColor(color).isValid()

    @Slot(int, int, int, result=str)
    def color_from_hsv(self, h, s, v):
        return QColor.fromHsv(h, self.percent_to255(s), self.percent_to255(v)).name()

    @Slot(int, int, int, int, result=str)
    def color_from_cmyk(self, c, m, y, k):
        return QColor.fromCmyk(self.percent_to255(c), self.percent_to255(m), self.percent_to255(y),
                               self.percent_to255(k)).name()

    @Slot(result=str)
    def get_time_string(self):
        now = datetime.now()
        time_string = now.strftime("%H%M%S%f")[:-3]
        return time_string

    @Slot(result=str)
    def get_mouse_color(self):
        x, y = pyautogui.position()
        screenshot = ImageGrab.grab()
        color = screenshot.getpixel((x, y))
        return self.rgb_to_hex(color)

    @Slot()
    def change_system_cursor(self):
        self._app_event.start_mouse_listener()
        cursor_id = 32515

        user32 = ctypes.WinDLL('user32', use_last_error=True)

        cursor_handle = user32.LoadCursorW(0, cursor_id)
        if not cursor_handle:
            raise ctypes.WinError(ctypes.get_last_error())

        for cursor_id in [32512, 32513, 32514, 32515, 32516]:
            success = user32.SetSystemCursor(cursor_handle, cursor_id)
            if not success:
                raise ctypes.WinError(ctypes.get_last_error())

    @Slot()
    def reset_system_cursor(self):
        self._app_event.stop_mouse_listener()
        user32 = ctypes.WinDLL('user32', use_last_error=True)

        # Reset the system cursors using SystemParametersInfo
        SPI_SETCURSORS = 0x0057
        success = user32.SystemParametersInfoW(SPI_SETCURSORS, 0, None, 0)
        if not success:
            raise ctypes.WinError(ctypes.get_last_error())

    @staticmethod
    def rgb_to_hex(rgb):
        return '#{:02x}{:02x}{:02x}'.format(rgb[0], rgb[1], rgb[2])

    @staticmethod
    def save_file_to_des(file_data, file_name, target_folder_name):
        desktop_path = os.path.join(os.path.expanduser("~"), "Desktop")
        target_folder_path = os.path.join(desktop_path, target_folder_name)
        print("[Des]", target_folder_path)

        if not os.path.exists(target_folder_path):
            os.makedirs(target_folder_path)
        target_file_path = os.path.join(target_folder_path, file_name)
        with open(target_file_path, 'w', encoding='utf-8') as target_file:
            target_file.write(file_data)

        print(f"File saved to: {target_file_path}")
        return target_file_path

    @staticmethod
    def read_file(file_path):
        file = QFile(file_path)
        if not file.open(QIODevice.ReadOnly | QIODevice.Text):
            print(f"Failed to open file: {file_path}")
            return None

        content = file.readAll()
        file.close()

        return str(content, 'utf-8')

    @staticmethod
    def copy_image_from_qrc_to_folder(qrc_path, file_name, target_folder_name):
        # Convert QRC path to absolute file path
        qrc_file_path = QResource(qrc_path).absoluteFilePath()

        # Load image from QRC file
        image = QImage(qrc_file_path)

        # Check if image loaded successfully
        if image.isNull():
            print(f"Failed to load image from {qrc_path}")
            return False

        desktop_path = os.path.join(os.path.expanduser("~"), "Desktop")
        target_folder_path = os.path.join(desktop_path, target_folder_name, file_name)
        print("[Des]", target_folder_path)

        # Save image to destination path
        if not image.save(target_folder_path):
            print(f"Failed to save image to {target_folder_path}")
            return False

        print(f"Image file copied from {qrc_path} to {target_folder_path}")
        return True

    stopColorPicking = Signal()

    def handle_signal_from_app_event(self):
        print("Handle Signal from App Event")
        self.stopColorPicking.emit()

    @staticmethod
    def convert_file_path_to_url(file_path):
        file_path = file_path.replace("\\", "/")
        if not file_path.startswith("file:///"):
            file_path = "file:///" + file_path

        return file_path
