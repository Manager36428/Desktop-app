import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQml 2.0

ResizableItem {
    height: 40
    width: text.width + 20
    property string text_data: "Default Text"

    content: Item{
        anchors.fill: parent
        TextField {
            id: text
            text: text_data
            height: 40
            font.pixelSize: 18
            font.weight: Font.DemiBold
            color: "#4D365D"
            font.family: "Nunito"
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            background: Item {}
        }
    }

    onItem_idChanged : {
        element_tag = "text_" + item_id
    }
}
