import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    property string title: ""
    property alias page_color: rectPageColor.color
    signal btnClicked()

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

    Rectangle{
        id : rectPageColor
        anchors.top: header.bottom
        anchors.topMargin: 9
        color: "#C9DBE5"
        radius: 10
        height: 36
        width: parent.width/2 - 3
        antialiasing: true

        MouseArea{
            anchors.fill: parent
            onClicked: btnClicked()
        }
    }

}
