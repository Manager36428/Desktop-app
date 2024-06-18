# This Python file uses the following encoding: utf-8
import os

from PySide2 import QtCore
from PySide2.QtCore import Slot, QFile, QIODevice, QResource
from PySide2.QtGui import QColor, QImage


class Utils(QtCore.QObject):
    def __init__(self):
        super().__init__()

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

    @staticmethod
    def convert_file_path_to_url(file_path):
        file_path = file_path.replace("\\", "/")
        if not file_path.startswith("file:///"):
            file_path = "file:///" + file_path

        return file_path
