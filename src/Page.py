# This Python file uses the following encoding: utf-8
import math

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
        grid_rows = ""
        grid_columns = ""
        for cell_row in self._grid_temp_row:
            grid_rows += str(cell_row) + "vh "
        for cell_col in self._grid_temp_col:
            grid_columns += str(cell_col) + "vw "
        print(grid_rows)
        print(grid_columns)

        css_element_template = """
        .{element_tag}{{
            grid-area: {tl_y}/ {tl_x} / {br_y} / {br_x};
        }}
        """

        css_elements = ""
        for child in self._children:
            top_left_x = int(child.property("x"))
            top_left_y = int(child.property("y"))
            height_child = int(child.property("height"))
            width_child = int(child.property("width"))

            css_elements += css_element_template.format(element_tag=child.property("element_tag"),
                                                        tl_y=self._cor_css_y[top_left_y],
                                                        tl_x=self._cor_css_x[top_left_x],
                                                        br_y=self._cor_css_y[top_left_y + height_child],
                                                        br_x=self._cor_css_x[top_left_x + width_child])

        css_template = """
/* {section_name} Section */
#{section_id} {{
    flex-direction: column;
    max-width: 100%;
    margin: 0 auto;
    width: 100%;
    display : grid;
    background-color: {bg_color};
    grid-template-columns: {grid_template_columns};
    grid-template-rows: {grid_template_rows};
}}

{css_elements_section}
    
/* End {section_name} Section */
    """
        return css_template.format(section_name=self._page_name, section_id=self._page_id,
                                   bg_color=self._page_background, grid_template_rows=grid_rows,
                                   grid_template_columns=grid_columns, css_elements_section=css_elements)

    def generate_css_for_mobile(self):
        grid_temp_rows = ""
        total = 0
        for item_width in self._grid_temp_row_mobile:
            total += item_width
            grid_temp_rows += str(item_width) + "vh "

        css_element_template = """
.{element_tag}{{
    grid-area: {tl_y}/ {tl_x} / {br_y} / {br_x};
    display: block;
}}
        """
        css_elements_mobile = ""

        for idx, child in enumerate(self._sorted_child):
            css_elements_mobile += css_element_template.format(element_tag=child.property("element_tag"),
                                                               tl_y=str(idx + 1),
                                                               tl_x=1,
                                                               br_y=str(idx + 2),
                                                               br_x=2)
        print(css_elements_mobile)

        css_template = """
/* {section_name} Section */
#{section_id} {{
    grid-template-columns: 1fr;
    grid-template-rows: {grid_template_rows};
}}

{css_elements_section}
/* End {section_name} Section */
            """
        return css_template.format(section_name=self.page_name, section_id=self._page_id,
                                   grid_template_rows=grid_temp_rows,
                                   css_elements_section=css_elements_mobile)

    def gen_list_tag(self):
        html = f'<li><a href="#{self._page_id}" data-after="{self._page_name}">{self._page_name}</a></li>'
        return html

    def gen_section_tag(self):
        element_tag = """
<div class="{element_id}">
    {html_element}
</div>
        """
        elements = ""
        for child in self._children:
            print(child.get_html())
            elements += element_tag.format(html_element=child.get_html(), element_id=child.property("element_tag"))

        section_tag = f"""
        <section id="{self._page_id}">
            {elements}
        </section>
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

    _cor_css_x = {}
    _cor_css_y = {}
    _grid_temp_col = []
    _grid_temp_row = []
    _grid_temp_row_mobile = []
    _sorted_child = []

    def prepare_grid_css(self, parent_h, parent_w):
        temp_xs = []
        temp_ys = []
        self._grid_temp_row_mobile.clear()
        dict_child = {}
        self._sorted_child = {}

        for child in self._children:
            top_left_x = int(child.property("x"))
            top_left_y = int(child.property("y"))
            height_child = int(child.property("height"))
            width_child = int(child.property("width"))
            bottom_right_x = top_left_x + width_child
            bottom_right_y = top_left_y + height_child
            dict_child[child.property("y")] = child

            temp_xs.append(top_left_x)
            temp_xs.append(bottom_right_x)
            temp_ys.append(top_left_y)
            temp_ys.append(bottom_right_y)

        self._sorted_child = dict(sorted(dict_child.items())).values()
        for child in self._sorted_child:
            width_child = int(child.property("width"))
            self._grid_temp_row_mobile.append(math.ceil(float(width_child / parent_w) * 100))

        self._grid_temp_row.clear()
        self._grid_temp_col.clear()
        self._cor_css_x.clear()
        self._cor_css_y.clear()
        temp_xs = list(set(temp_xs))
        temp_ys = list(set(temp_ys))
        temp_xs.sort()
        temp_ys.sort()

        pre_x = 0
        remain_space = 100
        for x in temp_xs:
            percent = math.ceil(float((x - pre_x) / parent_w) * 100)
            remain_space -= percent
            self._grid_temp_col.append(percent)
            pre_x = x
            self._cor_css_x[x] = temp_xs.index(x) + 2
        if remain_space > 0:
            self._grid_temp_col.append(remain_space)

        pre_y = 0
        remain_space = 100
        for y in temp_ys:
            percent = math.ceil(float((y - pre_y) / parent_h) * 100)
            self._grid_temp_row.append(percent)
            pre_y = y
            remain_space -= percent
            self._cor_css_y[y] = temp_ys.index(y) + 2
        if remain_space > 0:
            self._grid_temp_row.append(remain_space)

        print(self._grid_temp_row)
        print(self._grid_temp_col)

    def __init__(self, page_id, page_name, page_color):
        super().__init__()
        self._page_id = page_id
        self.page_name = page_name
        self.page_background = page_color
        self._current_element_id = 0
        self._children = []
        self._cor_css_x = {}
        self._cor_css_y = {}
        self._grid_temp_col = []
        self._grid_temp_row = []
