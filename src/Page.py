# This Python file uses the following encoding: utf-8
from PySide2 import QtCore
from PySide2.QtCore import Signal, Property


class Page(QtCore.QObject):
    # Member Property page_name
    _page_name: str = str()
    _page_nameChanged = Signal(str)

    def get_page_name(self):
        return self._page_name

    def set_page_name(self, val):
        if val != self._page_name:
            self._page_name = val
            self._page_nameChanged.emit(self._page_name)

    page_name = Property(str, get_page_name, set_page_name, notify=_page_nameChanged)
    # End Section Member Property page_name

    # Member Property page_id
    _page_id: str = str()
    _page_idChanged = Signal(str)

    def get_page_id(self):
        return self._page_id

    def set_page_id(self, val):
        if val != self._page_id:
            self._page_id = val
            self._page_idChanged.emit(self._page_id)

    page_id = Property(str, get_page_id, set_page_id, notify=_page_idChanged)

    # End Section Member Property page_id

    # Member Property page_background
    _page_background: str = str()
    _page_backgroundChanged = Signal(str)

    def get_page_background(self):
        return self._page_background

    def set_page_background(self, val):
        if val != self._page_background:
            self._page_background = val
            self._page_backgroundChanged.emit(self._page_background)

    page_background = Property(str, get_page_background, set_page_background, notify=_page_backgroundChanged)
    # End Section Member Property page_background

    def __init__(self, page_id, page_name, page_color):
        super().__init__()
        self._page_id = page_id
        self.page_name = page_name
        self.page_background = page_color
