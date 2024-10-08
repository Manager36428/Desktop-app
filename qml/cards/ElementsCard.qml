import QtQuick 2.0
import "../common"

TitleCard {
    title: "Elements"
    windowParent.minimumHeight: 420
    windowParent.minimumWidth: 720

    contentDock: Item{
        anchors.fill: parent

        ListModel{
            id : listElement
            ListElement{
                icon : "qrc:/assets/ic_heading.png"
                text : "Heading"
            }
            ListElement{
                icon : "qrc:/assets/ic_text.png"
                text : "Text"
            }
            ListElement{
                icon : "qrc:/assets/ic_img.png"
                text : "Image"
            }
            ListElement{
                icon : "qrc:/assets/ic_video.png"
                text : "Video"
            }
            ListElement{
                icon : "qrc:/assets/ic_button.png"
                text : "Button"
            }
            ListElement{
                icon : "qrc:/assets/ic_menu.png"
                text : "Menu"
            }
        }

        GridView{
            id : gvElements
            model: listElement
            height: 205
            width: 684
            cellHeight : 101
            cellWidth: 171
            interactive: false
            anchors{
                top: parent.top
                topMargin: 55
                left: parent.left
                leftMargin: 11
            }

            delegate: Element{
                elementIcon: icon
                elementName: text
                onDropDone: {
                    console.log("Drop Ok", x + " - " + y)
                    controller.request_create_item(x,y,text)
                }
                onDropCanceled: {
                    console.log("onDropCanceled")
                }
            }
        }
    }

}
