import QtQuick 2.0

Rectangle {
    height: 69
    width: 69
    radius: 10
    color: isActive ? "#7E69FF" : Qt.rgba(0.2235, 0.2118, 0.2196, 0.5)

    property bool isActive: false
    property string elementName: ""
    property string elementIcon: ""

    Image{
        id : iconElement
        height: 33
        width: 33
        source: elementIcon
        anchors{
            top: parent.top
            topMargin: 9
            horizontalCenter: parent.horizontalCenter
        }
    }

    Text{
        height: 18
        font.pixelSize: 13
        font.weight: Font.DemiBold
        lineHeight: 18
        font.family: "Nunito"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "white"
        text: elementName
        anchors{
            left: parent.left
            right: parent.right
            top: iconElement.bottom
            margins: 2
        }
    }
}
