import QtQuick 2.0
import "../common"

TitleCard{
    title: "Navigate"
    heightDock: 410
    widthDock: 300
    windowParent.minimumHeight: 410
    windowParent.minimumWidth: 300

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
           model : controller.pages
           spacing: 14
           snapMode: ListView.SnapToItem
           clip: true
           anchors{
               left: parent.left
               right: parent.right
               top: parent.top
               topMargin: 44
           }

           delegate: ButtonText{
               id : delegateContent
               btnName: modelData.page_name
               isActive: index === controller.current_page_idx
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
                   visible: index !== (naviList.count - 1)
               }
               onBtnClicked: controller.current_page_idx = index
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

            onBtnClicked: controller.add_page()

        }
    }
}
