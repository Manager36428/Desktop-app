import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQml 2.12
import "../components"

Item {
    id: root
    default property alias contents: placeholder.data
    property alias title: window.title
    property alias windowParent : window
    property int mode: 0 // 0 = Docked , 1 = Undocked , 2 = Closed
    property int heightDock: 0
    property int widthDock: 0
    property int heightInit: 0
    property int widthInit: 0


    onStateChanged: {
        console.log(state)
    }

    onModeChanged: {
        if(mode == 0)
            content.state = "docked"
        else if (mode == 1)
            content.state = "undocked"
        else if (mode == 2)
            content.state = "closed"
    }

    Item {
        id: content
        anchors.fill: parent
        state: "docked"

        Item {
            id: placeholder
            anchors.fill: parent
        }

        states: [
            State {
                name: "undocked"
                PropertyChanges { target: window; visible: true }
                ParentChange { target: content; parent: undockedContainer }
                PropertyChanges {target: root; visible: true }
            },
            State {
                name: "docked"
                PropertyChanges { target: window; visible: false }
                ParentChange { target: content; parent: root }
            },
            State {
                name : "closed"
                PropertyChanges {target: root; height: 0 }
                PropertyChanges {target: root; visible: false }
                PropertyChanges {target: window; visible: false }
            }

        ]
    }
    FramelessWindow {
        id: window
        width: heightDock
        height: widthDock
        minimumWidth: 300
        onHeightChanged: console.log("Window Dock  H : ", height)
        onWidthChanged: console.log("Window Dock W: " , width)
        onBtnCloseClicked: {
            root.mode = 0
            root.mode = 2
        }

        property bool resizeAtFirst: true

        onBtnShirkClicked: root.mode = 0

        content : Item {
            id: undockedContainer
            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
        }

        onVisibleChanged: {
            if(resizeAtFirst){
                window.setHeight(heightInit)
                window.setWidth(widthInit)
                resizeAtFirst=false
            }
        }

    }
}
