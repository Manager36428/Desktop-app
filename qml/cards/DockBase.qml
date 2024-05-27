import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQml 2.12

Item {
    id: root
    default property alias contents: placeholder.data
    property alias title: window.title
    property alias windowParent : window
    property int mode: 0 // 0 = Docked , 1 = Undocked
    property int heightDock: 0
    property int widthDock: 0


    onStateChanged: {
        console.log(state)
    }

    onModeChanged: {
        if(mode == 0)
            content.state = "docked"
        else
            content.state = "undocked"
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
            },
            State {
                name: "docked"
                PropertyChanges { target: window; visible: false }
                ParentChange { target: content; parent: root }
            }
        ]
    }
    Window {
        id: window
        width: heightDock
        height: widthDock
        minimumWidth: 950
        onHeightChanged: console.log("Window Dock  H : ", height)
        onWidthChanged: console.log("Window Dock W: " , width)

        Image{
            anchors.fill: parent
            source: "qrc:/assets/img_bg.jpg"
        }

        Item {
            id: undockedContainer
            anchors.fill: parent
        }

        onClosing: root.mode = 0

    }
}
