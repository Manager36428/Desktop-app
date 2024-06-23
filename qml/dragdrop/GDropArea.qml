import QtQuick 2.0

Rectangle
{
    id:root
    color: "transparent"
    property bool containsDrag: dropArea.containsDrag && windowRoot.dragCenter.dragTarget === root
    property alias keys: dropArea.keys
    signal itemDropped()

    DropArea
    {
        id:dropArea
        anchors.fill: parent
        property bool itemInside: false

        onDropped: {
            console.log("OnDropped ", dropArea.containsDrag)
            console.log("OnDropped Changed: ", drag.x + " - " + drag.y)

        }

        onEntered: itemInside = true
        onExited: itemInside = false

        onPositionChanged:
        {
            console.log("Position Changed: ", drag.x + " - " + drag.y)
            console.log("onPositionChanged ", dropArea.containsDrag)
            windowRoot.dragCenter.isDroppedOk = itemInside
            windowRoot.dragCenter.positionDropped.x = drag.x
            windowRoot.dragCenter.positionDropped.y = drag.y
        }
    }

    MouseArea{
        anchors.fill: parent
        onClicked: root.forceActiveFocus()
    }
}


