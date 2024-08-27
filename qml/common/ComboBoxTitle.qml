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

    Row{
        height: 36
        spacing: 6

        anchors{
            top: header.bottom
            topMargin: 18
            left: parent.left
            right: parent.right
        }

        Rectangle{
            id : rectPageColor
            color: "#C9DBE5"
            radius: 10
            height: 36
            width: parent.width/2 - 3
            //border.width: 1
            //border.color: "white"
            antialiasing: true

            MouseArea{
                anchors.fill: parent
                onClicked: btnClicked()
            }
        }
    }

}
