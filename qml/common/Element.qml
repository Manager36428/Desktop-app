import QtQuick 2.0
import "../dragdrop"

GDrager{
    height: 80
    width: 150
    property string elementName: ""
    property string elementIcon: ""
    hotSpotX:0
    hotSpotY:0

    Rectangle {
        id : btnRoot
        anchors.fill: parent
        radius: 10
        border.width: mouseArea.containsMouse ? 1 : 0
        border.color: "white"
        color: isActive ? "#7E69FF" : Qt.rgba(0.2235, 0.2118, 0.2196, 0.5)
        property bool isActive: false
        signal btnClicked()

        GDragAgent{}

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

        SequentialAnimation {
            loops: 1
            PropertyAnimation {
                id: scaleDownAnim
                targets: btnRoot
                properties: "scale"
                from: 1.0
                to: 0.9
                duration: 100
            }

            PropertyAnimation {
                id: scaleUpAnim
                targets: btnRoot
                properties: "scale"
                from: 0.9
                to: 1.0
                duration: 100
            }
            id :zoomInOutAnim
            onStopped: btnClicked()
        }

        MouseArea{
            id : mouseArea
            z:10
            anchors.fill: parent
            onClicked: zoomInOutAnim.restart()
            hoverEnabled: true
        }
    }

}

