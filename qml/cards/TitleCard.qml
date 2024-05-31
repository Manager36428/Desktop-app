import QtQuick 2.0
import "../../qml"
import "../common"
import "../components"

DockBase {
    id : titleCard
    property alias contentDock: _contentHolder.data
    property bool isDocked: mode == 0
    property bool isActive: mode != 2

    onHeightDockChanged: height = heightDock
    onWidthDockChanged: width = widthDock

    function changeToClosedState(){
       titleCard.mode = 2
    }

    function changeToDockedState(){
        titleCard.mode = 0
    }

    contents: Item{
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        Item{
            height: 25
            width: parent.width
            z:2
            visible: isDocked

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

            Icon{
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
                onBtnClicked: mode = 2
            }

            Icon{
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
                onBtnClicked: mode = 1
            }

        }

        Rectangle{
            id : _contentHolder            
            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: isDocked ? 0 : 8
            }
            gradient: Gradient {
                GradientStop { position: 1.0; color: Qt.rgba(0.6549, 0.6157, 0.6509, 0.55) }
                GradientStop { position: 0.0; color: Qt.rgba(0.8275, 0.7922, 0.8275, 0.55) }
            }
            radius: 10
        }
    }
}
