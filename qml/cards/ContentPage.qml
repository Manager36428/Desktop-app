import QtQuick 2.0
import "../common"
import "../components"

ContentBase{
    id : detailContent

    TextFieldTitle{
        id : tfHome
        height: 61
        width: parent.width
        title: "Page Name"
        content.text: detailContent.currentPage != undefined ? detailContent.currentPage.page_name : ""
        anchors{
            top: parent.top
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
        }

        content.text: detailContent.currentPage.page_id

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
                controller.refresh_current_page()
                return;
            }

            if(controller.check_id_valid(content.text)){
                console.log("Update Page Id :" + detailContent.currentPage.page_name + " - " + content.text)
                detailContent.currentPage.page_id = content.text
            }else{
                controller.refresh_current_page()
                tfPageDes.warning = "ID already exists !"
            }
        }
    }

    ComboBoxTitle{
        id : cbBg
        height: 95
        title: "Page Background Colour"
        width: parent.width
        anchors{
            top : tfPageDes.bottom
            topMargin: 19
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
        width: parent.width
        is_page: true
        anchors{
            bottom: parent.bottom
        }
        content.onAccepted: {
            if(content.text == "DELETE"){
                controller.delete_page(controller.current_page)
                content.text = ""
            }
        }
    }
}
