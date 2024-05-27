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

    ButtonGroup {
        buttons: colorRadio.children
    }

    Row{
        id : colorRadio
        height: 26
        spacing: 9
        width: parent.width
        anchors{
            top: header.bottom
            topMargin: 8
        }

        RadioButton{
            checked: true
            text: "Colour"
            font.pixelSize: 16
            icon.color: "#454045"
        }
        RadioButton{
            text: "Image"
            font.pixelSize: 16
            icon.color: "#454045"
        }
    }

    Row{
        height: 36
        spacing: 6

        anchors{
            top: colorRadio.bottom
            topMargin: 18
            left: parent.left
            right: parent.right
        }

        Rectangle{
            color: "#C9DBE5"
            radius: 10
            height: 36
            width: parent.width/2 - 3
        }

        TextField{
            id : _tfcontent
            width:  parent.width/2 - 3
            height: 36

            background: Rectangle{
                antialiasing: true
                color: "#FFFFFF"
                radius: 10
            }
            color: "#585D6C"
            font.pixelSize: 16
            font.family: "Nunito"
            wrapMode: Text.WordWrap
            placeholderText: "#585D6C"
        }

    }

}
