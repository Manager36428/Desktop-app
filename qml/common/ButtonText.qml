import QtQuick 2.0

Rectangle {
    id : btnRoot
    property bool isActive: false
    property string btnName: ""
    property string icSrc: ""
    radius: 10
    color: isActive ? "#7E69FF" : Qt.rgba(0.2235, 0.2118, 0.2196, 0.5)
    height: 36

    Item{
        id : content
        height: 22
        width: childrenRect.width
        anchors.centerIn: parent

        Image{
            id : icon
            source: icSrc
            height: 20
            width: icSrc == "" ? 0 : 20
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {            
            text: btnName
            color: "white"
            verticalAlignment: Text.AlignVCenter
            font.family: "Nunito"
            font.weight: Font.DemiBold
            font.pixelSize: 16
            anchors{
                left: icon.right
                leftMargin: 4
            }
        }
    }
}
