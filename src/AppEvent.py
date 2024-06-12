# This Python file uses the following encoding: utf-8
from PySide2 import QtCore


class AppEvent(QtCore.QObject):
    def __init__(self):
        super().__init__()
