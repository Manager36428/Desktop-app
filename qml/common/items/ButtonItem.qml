import QtQuick 2.0

ResizableItem {
    height: 40
    width: 120
    property string text_data: "Button"

    content: Item{
        anchors.fill: parent
        Rectangle {
            id : btnRoot
            property bool isActive: true
            property string btnName: text_data
            radius: 10
            color: "#7E69FF"
            anchors.fill: parent

            Text {
                text: text_data
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
