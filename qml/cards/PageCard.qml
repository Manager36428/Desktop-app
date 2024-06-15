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
            height: /*isDocked ? 40 : 0*/ 0
            visible: /*isDocked*/ false
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

        RectangleOneSideRounded{
            side: "bottom"
            id : content
            radius: 10            
            anchors{
                top: header.bottom
                bottom: parent.bottom
                right: parent.right
                left: parent.left
                margins: 1
            }
            color: controller.current_page.page_background
        }
    }
}
