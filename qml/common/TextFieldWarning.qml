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

    Text{
        id : txtWarning
        anchors{
            top: header.bottom
            topMargin: 9
        }

        height: 40
        font.pixelSize: 16
        font.weight: Font.DemiBold
        width: parent.width
        text : "To delete this page type the word DELETE below and press ENTER."
        color: "#454045"
        font.family: "Nunito"
        wrapMode: Text.WordWrap
    }

    TextField{
        id : _tfcontent
        anchors{
            top: txtWarning.bottom
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
