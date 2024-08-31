import QtQuick 2.0

MouseArea{
    id : rootMenuItem
    width: parent.width
    height: 25
    property string menu_item_name: ""
    property string menu_item_shortcut: ""
    hoverEnabled: true

    Text {
        anchors{
            left: parent.left
            leftMargin: 12
        }

        width: parent.width
        id: newItem
        verticalAlignment: Text.AlignVCenter
        text: menu_item_name
        font.pixelSize: 16
        font.family: "Nunito"
        font.weight: rootMenuItem.containsMouse ? Font.Bold : Font.Medium
    }

    Item {
        anchors.right: parent.right
        anchors.rightMargin: 12
        width: 30
        Text {
            text: menu_item_shortcut
            verticalAlignment: Text.AlignVCenter
            anchors.right: parent.right
            color: "#4D365D"
            font.pixelSize: 16
            font.family: "Nunito"
            font.weight: Font.Medium
        }
    }

}
