import QtQuick 2.0

ResizableItem {
    height: 68
    width: 120
    property string text_data: "Button"

    content: Item{
        anchors.fill: parent
        Rectangle {
            id : btnRoot
            property bool isActive: true
            property string btnName: text_data
            radius: 10
            color: "transparent"
            anchors.fill: parent
            border.width: 1
            border.color: "black"
            antialiasing: true

            ListModel{
                id : naviModel
                ListElement{
                    name: "Home"
                    btn_active : true
                }
                ListElement{
                    name: "Page 1"
                    btn_active : false
                }
                ListElement{
                    name: "Page 2"
                    btn_active : false
                }
                ListElement{
                    name: "Page 3"
                    btn_active : false
                }
            }

            ListView{
                anchors{
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                    margins: 2
                }
                clip: true
                model: naviModel
                spacing : 4
                delegate: Item{
                    height: 20
                    width: parent.width
                    Text{
                        id : txtTitle
                        height: 20
                        verticalAlignment: Text.AlignVCenter
                        text: "\u2022 " + name
                        width: parent.width
                        color: "#4D365D"
                        font.family: "Nunito"
                        font.pixelSize: 18
                        font.weight: Font.DemiBold
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }


            }
        }
    }
}
