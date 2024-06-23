# This Python file uses the following encoding: utf-8
import os
import sys

from PySide2 import QtCore
from PySide2.QtGui import QGuiApplication, QIcon
from PySide2.QtQml import QQmlApplicationEngine, QQmlComponent
from PySide2.QtCore import QUrl

import assets
import qml
from src.Controller import Controller
from src.Utils import Utils


def qt_message_handler(mode, context, message):
    if mode == QtCore.QtInfoMsg:
        mode = 'Info'
    elif mode == QtCore.QtWarningMsg:
        mode = 'Warning'
    elif mode == QtCore.QtCriticalMsg:
        mode = 'critical'
    elif mode == QtCore.QtFatalMsg:
        mode = 'fatal'
    else:
        mode = 'Debug'
    print("%s: %s (%s:%d, %s)" % (mode, message, context.file, context.line, context.file))


if __name__ == "__main__":
    QtCore.qInstallMessageHandler(qt_message_handler)
    app = QGuiApplication(sys.argv)
    app.setApplicationName("FlowSta")
    app.setWindowIcon(QIcon(":/assets/app.ico"))
    app.setApplicationVersion("v1.0")
    engine = QQmlApplicationEngine()
    controller = Controller()
    utils = Utils()
    engine.rootContext().setContextProperty("controller", controller)
    engine.rootContext().setContextProperty("utils", utils)

    url = QUrl("qrc:/main.qml")
    engine.load(url)
    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())
