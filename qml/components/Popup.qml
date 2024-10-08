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
    height: 500
    width: 700

    flags: Qt.Window | Qt.FramelessWindowHint    

    property alias content: contentData.data
    property int popupId: -1

    onPopupIdChanged: {
        console.log("popupId changed : " ,popupId)
    }

    property int windowStatus: 0
    property int windowMargin: 10

    signal popupDestroyed(var popup_id)

    onClosing :popupDestroyed(popupId)

    QtObject{
        id: internal

        // Close Left Top Menu Popup
        function closeLeftPopup(){
            topTitleMenusExited.running = true
            console.log("Closed Popup")
            leftPopupMenu.activeMenu = true
            leftPopupMenu.rotateNormal()
            topTitleMenus.visible = false
        }

        // Maximize Restore
        function maximizeRestore(){
            if(windowStatus == 0){
                mainWindow.showMaximized()
                windowStatus = 1
                windowMargin = 0
            }
            else{
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
            }
        }

        // If Maximized Restore
        function ifMaximizedRestore(){
            if(windowStatus == 1){
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
            }
        }

        // Restore Margins
        function restoreMargins(){
            windowStatus = 0
            windowMargin = 10
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

    Rectangle{
        id: bgApp        
        anchors.fill: parent
        anchors.rightMargin: windowMargin
        anchors.leftMargin: windowMargin
        anchors.bottomMargin: windowMargin
        anchors.topMargin: windowMargin
        radius: 15
        gradient: Gradient {
            GradientStop { position: 1.0; color: Qt.rgba(167/255, 157/255, 166/255,) }
            GradientStop { position: 0.0; color: Qt.rgba(211/255, 202/255, 211/255) }
        }
        z: 100

        Item{
            z:10
            id : header
            height: 30
            anchors{
                top: bgApp.top
                left: bgApp.left
                right: bgApp.right
            }

            Text{
                z:2
                id : titleWindow
                height: 20
                width: 205
                anchors{                    
                    left: parent.left
                    leftMargin: 11
                    top: parent.top
                    topMargin: 9
                }
                font.family: "Nunito"
                font.weight: Font.DemiBold
                font.pixelSize: 18
                verticalAlignment: Text.AlignVCenter
                color: "#4D365D"
                text: mainWindow.title
            }

            Item {
                id: btnTopContent
                width: 90
                height: 20
                z:2
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 13
                anchors.topMargin: 8

                Row{
                    height: 20
                    anchors.right: parent.right
                    z: 100
                    spacing: 8

                    Icon{
                        height: 20
                        width: 20
                        id: btnClose
                        source: "qrc:/assets/ic_close.png"
                        onBtnClicked: mainWindow.close()
                    }

                }
            }
        }

        Item {
            id: top_bar_app
            height: 30
            anchors.left: parent.left
            anchors.right: bgApp.right
            anchors.top: bgApp.top
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0

            DragHandler{
                onActiveChanged: if(active){
                                     mainWindow.startSystemMove()
                                     internal.ifMaximizedRestore()
                                 }
            }
        }

        Item {
            id : contentData
            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                topMargin: 30
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
        DragHandler{
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
        DragHandler{
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
        DragHandler{
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
        DragHandler{
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
        DragHandler{
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.LeftEdge | Qt.TopEdge) }
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
        DragHandler{
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.RightEdge | Qt.TopEdge) }
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
        DragHandler{
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.LeftEdge | Qt.BottomEdge) }
        }
    }

    MouseArea {
        id: bottomRightResize
        width: 10
        height: 10
        anchors.right: bgApp.right
        anchors.bottom: bgApp.bottom
        anchors.bottomMargin: -10
        anchors.rightMargin: -10
        cursorShape: Qt.SizeFDiagCursor
        DragHandler{
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.RightEdge | Qt.BottomEdge) }
        }
    }

}
