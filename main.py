# This Python file uses the following encoding: utf-8
import sys

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QUrl

import assets
import qml


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    app.setApplicationName("FlowSta")
    engine = QQmlApplicationEngine()
    url = QUrl("qrc:/main.qml")
    engine.load(url)
    if not engine.rootObjects():
        sys.exit(-1)
    print("App started...")

    sys.exit(app.exec_())
