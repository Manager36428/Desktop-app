import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    property string title: ""
    property alias content : _tfcontent
    property string warning: ""

    onWarningChanged: if(warning.length > 0) resetWarning.restart()

    Timer{
        id : resetWarning
        interval: 2000
        repeat: false
        onTriggered: warning = ""
    }

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
        }

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
        verticalAlignment: Text.AlignTop
    }

    Text{
        id : warningTxt
        height: warning.length > 0 ? 16 : 0
        font.pixelSize: 16
        font.weight: Font.DemiBold
        width: parent.width
        text : warning
        color: "red"
        font.family: "Nunito"

        anchors{
            top : _tfcontent.bottom
            topMargin: 9
            left: parent.left
            right: parent.right
        }
    }

}
