# This Python file uses the following encoding: utf-8

import webbrowser

from PySide2 import QtCore
from PySide2.QtCore import Property, Signal, Slot, QObject

from src.Page import Page
from src.Utils import Utils


class Controller(QtCore.QObject):
    _last_idx_page: int

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

    # Member Property current_page
    _current_page: QObject = QObject()
    current_pageChanged = Signal(QObject)

    def get_current_page(self):
        return self._current_page

    def set_current_page(self, val):
        self._current_page = val
        self.current_pageChanged.emit(self._current_page)

    current_page = Property(QObject, get_current_page, set_current_page, notify=current_pageChanged)

    # End Section Member Property current_page

    # Member Property pages
    _pages = []
    pagesChanged = Signal()

    def get_pages(self):
        return self._pages

    pages = Property(list, get_pages, notify=pagesChanged)

    # End Section Member Property pages

    # Member Property current_page_idx
    _current_page_idx: int = int()
    _current_page_idxChanged = Signal(int)

    def get_current_page_idx(self):
        return self._current_page_idx

    def set_current_page_idx(self, val):
        print("Current Page Idx : ", val)
        self._current_page_idx = val
        self._current_page_idxChanged.emit(self._current_page_idx)
        self.set_current_page(self._pages[self._current_page_idx])

    current_page_idx = Property(int, get_current_page_idx, set_current_page_idx, notify=_current_page_idxChanged)

    # End Section Member Property current_page_idx

    @Slot()
    def add_page(self):
        print("Add New Page ", self._last_idx_page)
        str_idx = str(self._last_idx_page)
        page = Page("page_" + str_idx, "Page " + str_idx, "#FFFFFF")
        self._pages.append(page)
        self.pagesChanged.emit()
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
        self.pagesChanged.emit()

    @Slot()
    def create_new_project(self):
        print("[Controller] Create New Project")
        self._pages.clear()
        self._last_idx_page = 0
        page = Page("home", "Home", "#FFFFFF")
        self._pages.append(page)
        self.pagesChanged.emit()
        self.set_current_page_idx(0)
        self.set_current_page(page)

    generateDone = Signal(str)

    def generate_css_code(self):
        css_content = Utils.read_file(":web_temp/style.css")
        for page in self._pages:
            css_content += page.generate_css_block()
        return css_content

    def generate_html_code(self):
        html_content = Utils.read_file(":web_temp/index.html")
        html_gen_list = ""
        html_gen_section = ""
        for page in self._pages:
            html_gen_list += page.gen_list_tag()
            html_gen_section += page.gen_section_tag()

        html_content = html_content.replace("<%CODE_GEN_LIST%>", html_gen_list)
        html_content = html_content.replace("<%CODE_GEN_SECTION%>", html_gen_section)
        html_content = html_content.replace("<%CODE_GEN_PROJECT_NAME%>", self._project_name)
        return html_content

    @Slot()
    def generate_html(self):
        print("[Controller] Generate HTML")
        # Utils.save_file_to_des(Utils.read_file(":web_temp/app.js"), "app.js", "web")
        path_idx = Utils.save_file_to_des(self.generate_html_code(), "index.html", "web")
        Utils.copy_image_from_qrc_to_folder(":web_temp/img/hero-bg.png", "hero-bg.png", "web/img/")
        Utils.save_file_to_des(self.generate_css_code(), "style.css", "web")

        webbrowser.open(path_idx)

    @Slot(str, result=bool)
    def check_id_valid(self, page_id):
        print("Check ID Valid : ", page_id)
        for page in self._pages:
            print(page_id)
            if page_id == page.page_id:
                return False
        return True

    reqCreateItem = Signal(int, int, str)

    @Slot(int, int, str)
    def request_create_item(self, x, y, item_type):
        self.reqCreateItem.emit(x, y, item_type)

    @Slot(result=list)
    def get_init_menu(self):
        if len(self._pages) > 0:
            return [self._pages[0].get_page_name()]
        return ""

    def __init__(self):
        super().__init__()
        self.create_new_project()
