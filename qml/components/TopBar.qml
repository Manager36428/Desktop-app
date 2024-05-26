import QtQuick 2.0
import "../../qml"

BaseCard{
    id : rootTopBar

    Text{
        id : fileBtn
        anchors{
            top: parent.top
            left: parent.left
            leftMargin: 11
            topMargin: 4
        }

        height: 23
        lineHeight: 23
        font.pixelSize: 17
        verticalAlignment: Text.AlignVCenter
        text: "<u>F</u>ile"
        font.family: "Nunito"
        font.weight: Font.DemiBold
        color: "#4D365D"
    }

    Text{
        anchors{
            top: parent.top
            left: fileBtn.right
            leftMargin: 11
            topMargin: 4
        }

        height: 23
        lineHeight: 23
        font.pixelSize: 17
        verticalAlignment: Text.AlignVCenter
        color: "#4D365D"
        text: "<u>V</u>iew"
        font.family: "Nunito"
        font.weight: Font.DemiBold
    }
}
