import QtQuick 2.0
import "../common"

TitleCard{
    title: "Navigate"
    windowParent.minimumHeight: 476

    contentDock: Item{
        anchors.fill: parent
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
           id : naviList
           height: 187
           width: 278
           model : naviModel
           spacing: 14
           interactive: false
           anchors{
               left: parent.left
               right: parent.right
               top: parent.top
               topMargin: 44
           }

           delegate: ButtonText{
               id : delegateContent
               btnName: name
               isActive: btn_active
               anchors{
                   left: parent.left
                   right: parent.right
                   leftMargin: 15
                   rightMargin: 15
               }

               Rectangle{
                   height: 14
                   width: 1
                   anchors.horizontalCenter: parent.horizontalCenter
                   color: "#F1F3F8"
                   anchors.top: parent.bottom
                   anchors.topMargin: 0
                   z:-1
                   visible: index != (naviModel.count - 1)
               }
           }
        }

        ButtonText{
            id :btnNewPage
            icSrc: "qrc:/assets/ic_add.png"
            btnName: "New Page"
            anchors.top: naviList.bottom
            anchors.topMargin: 15
            anchors{
                left: parent.left
                right: parent.right
                leftMargin: 15
                rightMargin: 15
            }

        }
    }
}
