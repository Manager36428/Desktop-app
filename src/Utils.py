# This Python file uses the following encoding: utf-8
from PySide2 import QtCore
from PySide2.QtCore import Slot
from PySide2.QtGui import QColor


class Utils(QtCore.QObject):
    def __init__(self):
        super().__init__()

    @Slot(str, result=int)
    def hsv_hue(self, color):
        qcolor = QColor(color)
        return qcolor.hsvHue()

    @Slot(str, result=int)
    def hsv_s(self, color):
        qcolor = QColor(color)
        return qcolor.hsvSaturation()

    @Slot(str, result=bool)
    def is_valid_color(self, color):
        return QColor(color).isValid()
