# This Python file uses the following encoding: utf-8
from PySide2 import QtCore
from PySide2.QtCore import Slot
from PySide2.QtGui import QColor


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
