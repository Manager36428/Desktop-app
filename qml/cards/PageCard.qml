import QtQuick 2.0
import "../common"

TitleCard {
    title: "Page"
    clip: true
    windowParent.minimumWidth: 720
    windowParent.minimumHeight: 510

    contentDock: Item{
        anchors.fill: parent
        Rectangle{
            id : header
            height: isDocked ? 40 : 0
            visible: isDocked
            anchors{
                top: parent.top
                topMargin: 40
                left: parent.left
                right: parent.right
            }

            color: Qt.rgba(0.6118, 0.5765, 0.6, 0.5)
            Text{
                height: 22
                text: "Device View"
                color: "white"
                font.weight: Font.DemiBold
                font.family: "Nunito"
                font.pixelSize: 16
                verticalAlignment: Text.AlignVCenter
                anchors{
                    verticalCenter: parent.verticalCenter
                    right: devices.left
                    rightMargin: 16
                }
            }

            Row{
                id : devices
                height: 30
                width: childrenRect.width
                spacing: 10
                anchors{
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 9
                }

                Image{
                    height: 30
                    width: 30
                    source: "qrc:/assets/ic_desktop.png"
                }

                Image{
                    height: 30
                    width: 30
                    source: "qrc:/assets/ic_table.png"
                }

                Image{
                    height: 30
                    width: 30
                    source: "qrc:/assets/ic_phone.png"
                }
            }
        }

        Rectangle{
            id : content
            radius: 10
            anchors{
                top: header.bottom
                bottom: parent.bottom
                right: parent.right
                left: parent.left
                margins: 1
            }
            color: "#C9DBE5"

            Rectangle{
                height: 10
                width: parent.width
                color: "#C9DBE5"
            }

            Image{
                id : img_dummy
                height: 270
                width: 270
                anchors{
                    top: parent.top
                    topMargin: 73
                    right: parent.right
                }
                source: "qrc:/assets/img_dummy.png"
            }

            Text {
                id: txtHeading
                font.weight: Font.DemiBold
                font.family: "Open Sans"
                height: 54

                anchors{
                    top: parent.top
                    topMargin: 40
                    left: parent.left
                    leftMargin: 18
                }
                color: "black"
                font.pixelSize: 40
                text: qsTr("Heading")
            }

            Text{
                height: 273
                width: 800
                anchors{
                    top: parent.top
                    left: parent.left
                    right: img_dummy.left
                    rightMargin: 28
                    topMargin: 116
                    leftMargin: 18
                }
                text :"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud  exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                font.pixelSize: 15
                font.family: "Open Sans"
                wrapMode: Text.WordWrap

            }
        }
    }
}
