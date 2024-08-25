import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.15
import "../common"

Window {
    id: mainWindow
    visible: true
    color: "#00000000"
    flags: Qt.Window | Qt.FramelessWindowHint

    property alias content: contentData.data

    property int windowStatus: 0
    property int windowMargin: 10

    // Properties to save the last size and position
    property int lastWidth: width
    property int lastHeight: height
    property int lastX: x
    property int lastY: y

    // Define a property to manage the icon source
    property string maximizeRestoreIcon: "qrc:/assets/ic_new_expand.png"

    QtObject {
        id: internal

        // Close Left Top Menu Popup
        function closeLeftPopup() {
            topTitleMenusExited.running = true
            console.log("Closed Popup")
            leftPopupMenu.activeMenu = true
            leftPopupMenu.rotateNormal()
            topTitleMenus.visible = false
        }

        // Maximize Restore
        function maximizeRestore() {
            if (windowStatus === 0) {
                // Save current size and position
                mainWindow.lastWidth = mainWindow.width;
                mainWindow.lastHeight = mainWindow.height;
                mainWindow.lastX = mainWindow.x;
                mainWindow.lastY = mainWindow.y;

                mainWindow.showMaximized();
                windowStatus = 1;
                windowMargin = 0;
                maximizeRestoreIcon = "qrc:/assets/ic_new_window.png"; // Change icon
            } else {
                // Restore saved size and position
                mainWindow.showNormal();
                mainWindow.width = mainWindow.lastWidth;
                mainWindow.height = mainWindow.lastHeight;
                mainWindow.x = mainWindow.lastX;
                mainWindow.y = mainWindow.lastY;

                windowStatus = 0;
                windowMargin = 10;
                maximizeRestoreIcon = "qrc:/assets/ic_new_expand.png"; // Change icon
            }
        }

        // If Maximized Restore
        function ifMaximizedRestore() {
            if (windowStatus === 1) {
                // Restore saved size and position
                mainWindow.showNormal();
                mainWindow.width = mainWindow.lastWidth;
                mainWindow.height = mainWindow.lastHeight;
                mainWindow.x = mainWindow.lastX;
                mainWindow.y = mainWindow.lastY;

                windowStatus = 0;
                windowMargin = 10;
                maximizeRestoreIcon = "qrc:/assets/ic_new_expand.png"; // Change icon
            }
        }

        // Restore Margins
        function restoreMargins() {
            windowStatus = 0;
            windowMargin = 10;
            maximizeRestoreIcon = "qrc:/assets/ic_new_expand.png"; // Reset icon
        }
    }

    DropShadow {
        anchors.fill: bgApp
        horizontalOffset: 4
        verticalOffset: 4
        radius: 8.0
        samples: 17
        color: "#800000"
        opacity: 0.25
        source: bgApp
    }

    Item {
        id: bgApp
        anchors.fill: parent
        anchors.rightMargin: windowMargin
        anchors.leftMargin: windowMargin
        anchors.bottomMargin: windowMargin
        anchors.topMargin: windowMargin
        z: 1
        clip: true

        Item {
            z: 10
            id: header
            height: 40
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }

            Image {
                z: 2
                id: iconApp
                height: 20
                width: 20
                source: "qrc:/assets/ic_app.png"
                anchors {
                    top: parent.top
                    left: parent.left
                    leftMargin: 11
                    topMargin: 10
                }
            }

            Text {
                z: 2
                id: titleWindow
                height: 40
                width: 205
                anchors {
                    verticalCenter: parent
                    left: iconApp.right
                    leftMargin: 8
                    top: parent.top
                }
                font.family: "Nunito"
                font.weight: Font.DemiBold
                font.pixelSize: 18
                verticalAlignment: Text.AlignVCenter
                color: "#4D365D"
                text: mainWindow.title
            }

            Rectangle {
                z: 1
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                color: "#e1dce1"
                height: 15
                radius: 15
                id: radiusRect
            }

            Rectangle {
                z: 1
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    topMargin: 10
                }
                color: "#e1dce1"
                height: 30
            }

            Item {
                id: btnTopContent
                width: 90
                height: 40
                z: 2
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 14
                anchors.topMargin: 0

                Row {
                    height: 20
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    z: 100
                    spacing: 8

                    Icon {
                        height: 20
                        width: 20
                        id: btnShirk
                        source: "qrc:/assets/ic_new_shink.png"
                        onBtnClicked: {
                            windowMargin = 10
                            windowStatus = 0
                            mainWindow.showMinimized()
                        }
                    }

                    Icon {
                        height: 20
                        width: 20
                        id: btnExpaned
                        source: mainWindow.maximizeRestoreIcon // Use the property
                        onBtnClicked: {
                            internal.maximizeRestore()
                        }
                    }

                    Icon {
                        height: 20
                        width: 20
                        id: btnClose
                        source: "qrc:/assets/ic_new_close.png"
                        onBtnClicked: mainWindow.close()
                    }
                }
            }
        }

        Item {
            id: top_bar_app
            height: 40
            anchors.left: parent.left
            anchors.right: bgApp.right
            anchors.top: bgApp.top
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0

            MouseArea {
                id: titleBarMouseArea
                anchors.fill: parent
                onDoubleClicked: {
                    internal.maximizeRestore();
                }
                onClicked: {
                    if (windowStatus === 0) {
                        mainWindow.startSystemMove();
                    }
                }
            }

            DragHandler {
                onActiveChanged: {
                    if (active) {
                        if (windowStatus === 1) {
                            // Switch from maximized to normal on drag
                            internal.ifMaximizedRestore();
                        }
                        mainWindow.startSystemMove();
                    }
                }
            }
        }

        Item {
            id: contentData
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                topMargin: 40
            }

            Rectangle {
                id: bgImg
                anchors.fill: parent
                radius: 15
                clip: true
                color: "#00000000"
                Image {
                    anchors.fill: parent
                    source: "qrc:/assets/img_bg.jpg"
                }
            }
        }
    }

    MouseArea {
        id: leftResize
        width: 5
        anchors.left: bgApp.left
        anchors.top: bgApp.top
        anchors.bottom: bgApp.bottom
        anchors.leftMargin: -5
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        cursorShape: Qt.SizeHorCursor
        DragHandler {
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.LeftEdge) }
        }
    }

    MouseArea {
        id: rightResize
        width: 5
        anchors.right: bgApp.right
        anchors.top: bgApp.top
        anchors.bottom: bgApp.bottom
        anchors.rightMargin: -5
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        cursorShape: Qt.SizeHorCursor
        DragHandler {
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.RightEdge) }
        }
    }

    MouseArea {
        id: topResize
        height: 5
        anchors.left: bgApp.left
        anchors.right: bgApp.right
        anchors.top: bgApp.top
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: -5
        cursorShape: Qt.SizeVerCursor
        DragHandler {
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.TopEdge) }
        }
    }

    MouseArea {
        id: bottomResize
        height: 5
        anchors.left: bgApp.left
        anchors.right: bgApp.right
        anchors.bottom: bgApp.bottom
        anchors.bottomMargin: -5
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        cursorShape: Qt.SizeVerCursor
        DragHandler {
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.BottomEdge) }
        }
    }

    MouseArea {
        id: topLeftResize
        width: 10
        height: 10
        anchors.left: bgApp.left
        anchors.top: bgApp.top
        anchors.leftMargin: -10
        anchors.topMargin: -10
        cursorShape: Qt.SizeFDiagCursor
        DragHandler {
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.TopEdge | Qt.LeftEdge) }
        }
    }

    MouseArea {
        id: topRightResize
        width: 10
        height: 10
        anchors.right: bgApp.right
        anchors.top: bgApp.top
        anchors.rightMargin: -10
        anchors.topMargin: -10
        cursorShape: Qt.SizeBDiagCursor
        DragHandler {
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.TopEdge | Qt.RightEdge) }
        }
    }

    MouseArea {
        id: bottomLeftResize
        width: 10
        height: 10
        anchors.left: bgApp.left
        anchors.bottom: bgApp.bottom
        anchors.leftMargin: -10
        anchors.bottomMargin: -10
        cursorShape: Qt.SizeBDiagCursor
        DragHandler {
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.BottomEdge | Qt.LeftEdge) }
        }
    }

    MouseArea {
        id: bottomRightResize
        width: 10
        height: 10
        anchors.right: bgApp.right
        anchors.bottom: bgApp.bottom
        anchors.rightMargin: -10
        anchors.bottomMargin: -10
        cursorShape: Qt.SizeFDiagCursor
        DragHandler {
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.BottomEdge | Qt.RightEdge) }
        }
    }
}
