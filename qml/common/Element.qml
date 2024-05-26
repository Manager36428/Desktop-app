import QtQuick 2.0

Rectangle {
    height: 80
    width: 150
    radius: 10
    color: isActive ? "#7E69FF" : Qt.rgba(0.2235, 0.2118, 0.2196, 0.5)
    property string elementName: ""
    property string elementIcon: ""
    property bool isActive: false

    Image{
        id : iconElement
        height: 36
        width: 36
        source: elementIcon
        anchors{
            top: parent.top
            topMargin: 10
            horizontalCenter: parent.horizontalCenter
        }
    }

    Text{
        height: 22
        font.pixelSize: 16
        font.weight: Font.DemiBold
        lineHeight: 22
        font.family: "Nunito"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "white"
        text: elementName
        anchors{
            left: parent.left
            right: parent.right
            top: iconElement.bottom
            margins: 4
        }
    }
}
