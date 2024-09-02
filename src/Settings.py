# This Python file uses the following encoding: utf-8
import math

from PySide2 import QtCore
from PySide2.QtCore import Signal, Property, QObject, Slot


class Settings(QtCore.QObject):
    # Member Property project_name
    _project_name: str = str()
    _project_nameChanged = Signal(str)

    def get_project_name(self):
        return self._project_name

    def set_project_name(self, val):
        if val != self._project_name:
            self._project_name = val
            self._project_nameChanged.emit(self._project_name)

    project_name = Property(str, get_project_name, set_project_name, notify=_project_nameChanged)

    # End Section Member Property project_name

    # Member Property project_title
    _project_title: str = str()
    _project_titleChanged = Signal(str)

    def get_project_title(self):
        return self._project_title

    def set_project_title(self, val):
        if val != self._project_title:
            self._project_title = val
            self._project_titleChanged.emit(self._project_title)

    project_title = Property(str, get_project_title, set_project_title, notify=_project_titleChanged)

    # End Section Member Property project_title


    # Member Property default_text_size
    _default_text_size: int = int()
    _default_text_sizeChanged = Signal(int)

    def get_default_text_size(self):
        return self._default_text_size

    def set_default_text_size(self, val):
        if val != self._default_text_size:
            self._default_text_size = val
            self._default_text_sizeChanged.emit(self._default_text_size)

    default_text_size = Property(int, get_default_text_size, set_default_text_size, notify=_default_text_sizeChanged)

    # End Section Member Property default_text_size
    heading_sizes = []
    heading_size_changed = Signal()

    @Slot(int, result=int)
    def get_heading_size_at(self, idx):
        print("Get heading Size:", idx, self.heading_sizes[idx])
        return self.heading_sizes[idx]

    @Slot(int, int)
    def set_heading_size_at(self, idx, value):
        self.heading_sizes[idx] = value
        self.heading_size_changed.emit()

    def __init__(self):
        super().__init__()
        self._project_title = "Flowsta"
        self._project_name = "Project Name"
        self._default_text_size = 14
        self.heading_sizes = [24, 20, 16, 14, 13, 12]


