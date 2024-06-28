import QtQuick 2.0

Rectangle {
    id : btnRoot
    property bool isActive: false
    property string btnName: ""
    property string icSrc: ""
    radius: 10
    color: isActive ? "#7E69FF" : Qt.rgba(0.2235, 0.2118, 0.2196, 0.5)
    height: 36
    border.width: mouseArea.containsMouse ? 1 : 0
    border.color: "white"
    signal btnClicked()
    property alias theMouseArea: mouseArea

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
