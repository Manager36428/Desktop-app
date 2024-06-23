import QtQuick 2.0

ResizableItem {
    height: 40
    width: 120
    property string btn_name: "Button"
    property string btn_source: ""
    property color btn_color: "#7E69FF"

    content: Item{
        anchors.fill: parent
        Rectangle {
            id : btnRoot
            property bool isActive: true
            radius: 10
            color: btn_color
            anchors.fill: parent

            Text {
                text: btn_name
                color: "white"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "Nunito"
                font.weight: Font.DemiBold
                anchors.fill: parent
                font.pixelSize: 16
            }
        }
    }
}
