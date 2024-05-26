import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    property string title: ""
    property alias content : _tfcontent

    Text{
        id :header
        height: 16
        font.pixelSize: 16
        font.weight: Font.DemiBold
        width: parent.width
        text : title
        color: "#4D365D"
        font.family: "Nunito"
    }

    TextField{
        id : _tfcontent
        anchors{
            top: header.bottom
            topMargin: 9
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        background: Rectangle{
            antialiasing: true
            color: "#FFFFFF"
            radius: 10
        }
        color: "#585D6C"
        font.pixelSize: 16
        font.family: "Nunito"
        wrapMode: Text.WordWrap
    }

}
