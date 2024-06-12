# This Python file uses the following encoding: utf-8
from PySide2 import QtCore
from PySide2.QtCore import Property, Signal, Slot, QObject

from src.Page import Page


class Controller(QtCore.QObject):
    _last_idx_page: int

    # Member Property current_page
    _current_page: QObject = QObject()
    _current_pageChanged = Signal(QObject)

    def get_current_page(self):
        return self._current_page

    def set_current_page(self, val):
        if val != self._current_page:
            self._current_page = val
            self._current_pageChanged.emit(self._current_page)

    current_page = Property(QObject, get_current_page, set_current_page, notify=_current_pageChanged)

    # End Section Member Property current_page

    # Member Property pages
    _pages = []
    _pagesChanged = Signal()

    def get_pages(self):
        return self._pages

    pages = Property(list, get_pages, notify=_pagesChanged)

    # End Section Member Property pages

    # Member Property current_page_idx
    _current_page_idx: int = int()
    _current_page_idxChanged = Signal(int)

    def get_current_page_idx(self):
        return self._current_page_idx

    def set_current_page_idx(self, val):
        print("Current Page Idx : ", val)
        if val != self._current_page_idx:
            self._current_page_idx = val
            self._current_page_idxChanged.emit(self._current_page_idx)
            self.set_current_page(self._pages[self._current_page_idx])

    current_page_idx = Property(int, get_current_page_idx, set_current_page_idx, notify=_current_page_idxChanged)

    # End Section Member Property current_page_idx

    @Slot()
    def add_page(self):
        print("Add New Page ", self._last_idx_page)
        str_idx = str(self._last_idx_page)
        page = Page("page_id_" + str_idx, "Page " + str_idx, "#FFFFFF")
        self._pages.append(page)
        self._pagesChanged.emit()
        self._last_idx_page += 1

    @Slot(QObject)
    def delete_page(self, page):
        print("Delete Page", page)
        self._pages.remove(page)
        if page not in self._pages:
            if len(self._pages) > 0:
                self.set_current_page_idx(0)
                self.set_current_page(self._pages[0])
            else:
                self.set_current_page(None)
        self._pagesChanged.emit()

    @Slot()
    def create_new_project(self):
        print("[Controller] Create New Project")
        self._pages.clear()
        self._last_idx_page = 0
        page = Page("home_id", "Home", "#FFFFFF")
        self._pages.append(page)
        self._pagesChanged.emit()
        self.set_current_page_idx(0)
        self.set_current_page(page)

    def __init__(self):
        super().__init__()
        self.create_new_project()
