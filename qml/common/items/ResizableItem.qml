import QtQuick 2.0

Rectangle {
    id: selComp
    border {
        width: 2
        color: active_color
    }
    color: "transparent"

    property int rulersSize: 12
    property color active_color : activeFocus ? "steelblue" : "transparent"
    property alias content: _content.data
    property string item_id: ""

    function updateCurrentItemId(activeId){
        controller.current_page.current_element_id = activeId
    }

    function removeItem(item_id){
        controller.current_page.remove_child(item_id)
    }

    Item{
        id : _content
        anchors.fill: parent
    }

    MouseArea {
        anchors.fill: parent
        drag{
            target: parent
            minimumX: 0
            minimumY: 0
            maximumX: parent.parent.width - parent.width
            maximumY: parent.parent.height - parent.height
            smoothed: true
        }
        onClicked: {
            console.log("Item Actived : " ,item_id)
            selComp.forceActiveFocus()
            updateCurrentItemId(item_id)
        }
    }

    Rectangle {
        width: rulersSize
        height: rulersSize*2
        radius: rulersSize
        color: active_color
        anchors.horizontalCenter: parent.left
        anchors.verticalCenter: parent.verticalCenter

        MouseArea {
            anchors.fill: parent
            drag{ target: parent; axis: Drag.XAxis }
            onMouseXChanged: {
                if(drag.active){
                    selComp.width = selComp.width - mouseX
                    selComp.x = selComp.x + mouseX
                    if(selComp.width < 30)
                        selComp.width = 30
                }
            }
        }
    }

    Rectangle {
        width: rulersSize
        height: rulersSize*2
        radius: rulersSize
        color: active_color
        anchors.horizontalCenter: parent.right
        anchors.verticalCenter: parent.verticalCenter

        MouseArea {
            anchors.fill: parent
            drag{ target: parent; axis: Drag.XAxis }
            onMouseXChanged: {
                if(drag.active){
                    selComp.width = selComp.width + mouseX
                    if(selComp.width < 50)
                        selComp.width = 50
                }
            }
        }
    }

    Rectangle {
        width: rulersSize
        height: rulersSize
        radius: rulersSize
        x: parent.x / 2
        y: 0
        color: active_color
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.top

        MouseArea {
            anchors.fill: parent
            drag{ target: parent; axis: Drag.YAxis }
            onMouseYChanged: {
                if(drag.active){
                    selComp.height = selComp.height - mouseY
                    selComp.y = selComp.y + mouseY
                    if(selComp.height < 50)
                        selComp.height = 50
                }
            }
        }
    }

    Rectangle {
        width: rulersSize
        height: rulersSize
        radius: rulersSize
        x: parent.x / 2
        y: parent.y
        color: active_color
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.bottom

        MouseArea {
            anchors.fill: parent
            drag{ target: parent; axis: Drag.YAxis }
            onMouseYChanged: {
                if(drag.active){
                    selComp.height = selComp.height + mouseY
                    if(selComp.height < 50)
                        selComp.height = 50
                }
            }
        }
    }

}
