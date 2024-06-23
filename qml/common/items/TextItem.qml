import QtQuick 2.0

ResizableItem {
    height: 40
    width: text.width + 20
    property string text_data: "Default Text"

    content: Item{
        anchors.fill: parent
        Text {
            id: text
            text: "Default Text"
            height: 40
            font.pixelSize: 18
            font.weight: Font.DemiBold
            color: "#4D365D"
            font.family: "Nunito"
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}
