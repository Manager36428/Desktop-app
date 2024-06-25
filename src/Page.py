# This Python file uses the following encoding: utf-8
from PySide2 import QtCore
from PySide2.QtCore import Signal, Property, QObject, Slot


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

    def generate_css_block(self):
        css_template = """
    /* {section_name} Section */
    #{section_id} {{
        flex-direction: column;page_name
        max-width: 100%;
        margin: 0 auto;
        width: 100%;
        background-color: {bg_color};
    }}
    /* End {section_name} Section */
    """
        return css_template.format(section_name=self._page_name, section_id=self._page_id,
                                   bg_color=self._page_background)

    def gen_list_tag(self):
        html = f'<li><a href="#{self._page_id}" data-after="{self._page_name}">{self._page_name}</a></li>'
        return html

    def gen_section_tag(self):
        section_tag = f"""
        <!-- Contact Section -->
        <section id="{self._page_id}">
          <div class="contact container">
            <div>
              <h1 class="{self._page_id}"></h1>
            </div>
          </div>
        </section>
        <!-- End Contact Section -->
        """
        return section_tag

    # Member Property children
    _children: list = []
    _childrenChanged = Signal()

    def get_children(self):
        return self._children

    def set_children(self, val):
        if val != self._children:
            self._children = val
            self._childrenChanged.emit()

    children = Property(list, get_children, set_children, notify=_childrenChanged)

    # End Section Member Property children

    # Member Property current_element_id
    _current_element_id: int = int()
    currentElementIdChanged = Signal()

    def get_current_element_id(self):
        return self._current_element_id

    def set_current_element_id(self, val):
        if val != self._current_element_id:
            self._current_element_id = val
            self.set_current_element(self.get_element_by_id(val))
            self.currentElementIdChanged.emit()
            print("Set Current Element ID : ", val)

    current_element_id = Property(int, get_current_element_id, set_current_element_id,
                                  notify=currentElementIdChanged)
    # End Section Member Property current_element_id

    # Member Property current_element
    _current_element: QObject = QObject()
    _current_elementChanged = Signal()

    def get_current_element(self):
        return self._current_element

    def set_current_element(self, val):
        if val != self._current_element:
            self._current_element = val
            self._current_elementChanged.emit()

    current_element = Property(QObject, get_current_element, set_current_element, notify=_current_elementChanged)

    # End Section Member Property current_element

    @Slot(QObject)
    def add_child(self, child):
        self._children.append(child)
        self._childrenChanged.emit()
        print(self._page_name + " - " + str(len(self._children)))

    @Slot(int)
    def remove_child(self, item_id):
        for item in self._children:
            if int(item.property("item_id")) == item_id:
                print("Found Item to Removed : ", item_id)
                self._children.remove(item)
                item.deleteLater()
                self.set_current_element_id(0)

    @Slot()
    def remove_current_item(self):
        if self._current_element is not None:
            print("Remove Current Item")
            self._children.remove(self._current_element)
            self._current_element.deleteLater()
            self.set_current_element_id(0)

    @Slot(int)
    def get_element_by_id(self, item_id):
        for item in self._children:
            if int(item.property("item_id")) == item_id:
                print("Found : ", item_id)
                return item
        return None

    def __init__(self, page_id, page_name, page_color):
        super().__init__()
        self._page_id = page_id
        self.page_name = page_name
        self.page_background = page_color
        self._current_element_id = 0
        self._children = []
