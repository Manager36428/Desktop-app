import QtQuick 2.0
import "../common"

TitleCard {
    title: "Details"
    windowParent.minimumHeight: 704
    property var currentPage: controller.current_page

    contentDock: Item{
        anchors.fill: parent
        Row{
            id : detailType
            height: 36
            spacing: 6
            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
                margins: 10
                topMargin: 44
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
            content.text: currentPage.page_name
            anchors{
                top: detailType.bottom
                topMargin: 15
                left: parent.left
                right: parent.right
                leftMargin: 11
                rightMargin: 7
            }
            content.onTextChanged: {
                currentPage.page_name = content.text
            }
        }

        TextFieldTitle{
            id : tfPageDes
            height: 61
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
            content.text: currentPage.page_id
            content.onTextChanged: {
                currentPage.page_id = content.text
            }
        }

        ComboBoxTitle{
            id : cbBg
            height: 95
            title: "Page Background Color"
            anchors{
                bottom: deletePageSection.top
                bottomMargin: 19
                left: parent.left
                right: parent.right
                leftMargin: 11
                rightMargin: 7
            }
            page_color: currentPage.page_background
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
                    content.text == ""
                }
            }
        }

    }

}
