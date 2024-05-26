import QtQuick 2.0
import "../../qml"

BaseCard {
    id : titleCard
    property string title: "Navigate"


    Text{
        id : txtTitle
        height: 25
        verticalAlignment: Text.AlignVCenter
        text: title
        width: parent.width
        color: "#4D365D"
        font.family: "Nunito"
        font.pixelSize: 18
        font.weight: Font.DemiBold

        anchors{
            top: parent.top
            left: parent.left
            topMargin: 9
            leftMargin: 11
        }
    }

    Image{
        id :btnClose
        height: 20
        width: 20
        anchors{
            top: parent.top
            right: parent.right
            topMargin: 9
            rightMargin: 8
        }
        source: "qrc:/assets/ic_close.png"
    }

    Image{
        id : btnExpand
        height: 20
        width: 20
        anchors{
            top: parent.top
            right: btnClose.left
            topMargin: 9
            rightMargin: 4
        }
        source: "qrc:/assets/ic_expand.png"
    }
}
