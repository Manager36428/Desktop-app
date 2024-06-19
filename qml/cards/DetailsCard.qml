import QtQuick 2.0
import "../common"
import "../components"

TitleCard {
    id : detailCard
    title: currentPage != undefined ? "Details" + " : " + currentPage.page_name : "Details"

    windowParent.minimumHeight: 500


    contentDock: Item{
        id : detailContent
        anchors.fill: parent
        property var currentPage: controller.current_page
        onCurrentPageChanged: {
            detailCard.title = currentPage != undefined ? "Details" + " : " + currentPage.page_name : "Details"
            tfPageDes.content.text = currentPage.page_id
        }

        Row{
            id : detailType
            height: 36
            spacing: 6
            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
                margins: 10
                topMargin: isDocked ? 54 : 24
            }

            ButtonText{
                btnName: "Page"
                isActive: true
                width: parent.width/2 - 3
            }

            ButtonText{
                btnName: "Element"
                width: parent.width/2 - 3
            }
        }

        TextFieldTitle{
            id : tfHome
            height: 61
            width: parent.width
            title: "Page Name"
            content.text: detailContent.currentPage != undefined ? detailContent.currentPage.page_name : ""
            anchors{
                top: detailType.bottom
                topMargin: 15
                left: parent.left
                right: parent.right
                leftMargin: 11
                rightMargin: 7
            }
            content.onTextChanged: {
                detailContent.currentPage.page_name = content.text
            }
        }       

        TextFieldTitle{
            id : tfPageDes
            height: 86
            width: parent.width
            title: "Page ID"
            anchors{
                top: tfHome.bottom
                topMargin: 15
                left: parent.left
                right: parent.right
                leftMargin: 11
                rightMargin: 7
            }

            content.onTextChanged: {
                if(tfPageDes.content.activeFocus){
                    checkIdTimer.restart()
                }
            }

            Timer{
                id : checkIdTimer
                interval: 500
                repeat: false
                onTriggered: tfPageDes.checkId()
            }

            function checkId(){
                console.log("Checking ID")
                if(detailContent.currentPage.page_id == content.text) return

                if(content.text.length == 0){
                    tfPageDes.warning = "ID cannot be empty !"
                    content.text = detailContent.currentPage.page_id
                    return;
                }

                if(controller.check_id_valid(content.text)){
                    console.log("Update Page Id :" + detailContent.currentPage.page_name + " - " + content.text)
                    detailContent.currentPage.page_id = content.text
                }else{
                    content.text = detailContent.currentPage.page_id
                    tfPageDes.warning = "ID already exists !"
                }
            }
        }

        ComboBoxTitle{
            id : cbBg
            height: 95
            title: "Page Background Color"
            anchors{
                top : tfPageDes.bottom
                topMargin: 19
                left: parent.left
                right: parent.right
                leftMargin: 11
                rightMargin: 7
            }
            page_color: detailContent.currentPage.page_background
            onBtnClicked: {
                popupColorPicker.currentColor = detailContent.currentPage.page_background
                popupColorPicker.syncColor(detailContent.currentPage.page_background)
                popupColorPicker.show()
            }
        }

        PopupColorPicker{
            id : popupColorPicker
            visible: false
            onAccepted: detailContent.currentPage.page_background = newColor
        }

        TextFieldWarning{
            id : deletePageSection
            title: "Delete Page"
            height: 113
            anchors{
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                bottomMargin: 17
                leftMargin: 11
                rightMargin: 7
            }
            content.onAccepted: {
                if(content.text == "DELETE"){
                    controller.delete_page(controller.current_page)
                    content.text = ""
                }
            }
        }

    }

}
