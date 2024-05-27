import QtQuick 2.0
import "../common"

TitleCard {
    title: "Details"
    windowParent.minimumHeight: 704

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
                topMargin: 54
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


//        Flickable
//        {
//            id : flickView
//            clip: true
//            contentHeight: contentDetail.childrenRect.height + 20
//            anchors{
//                top: detailType.bottom
//                topMargin: 19
//                bottom: deletePageSection.top
//                bottomMargin: 15
//                left: parent.left
//                right: parent.right
//                leftMargin: 11
//                rightMargin: 7
//            }
//            Column{
//                id : contentDetail

//                spacing: 15
//                anchors.fill: parent

//            }
//        }

        TextFieldTitle{
            id : tfHome
            height: 61
            width: parent.width
            title: "Page Name"
            content.text: "Home"
            anchors{
                top: detailType.bottom
                topMargin: 15
                left: parent.left
                right: parent.right
                leftMargin: 11
                rightMargin: 7
            }
        }

        TextFieldTitle{
            width: parent.width
            title: "Page Description"
            content.text: "Page description that will be used for meta description"
            anchors{
                top: tfHome.bottom
                topMargin: 15
                bottom: cbBg.top
                bottomMargin: 15
                left: parent.left
                right: parent.right
                leftMargin: 11
                rightMargin: 7
            }
        }

        ComboBoxTitle{
            id : cbBg
            height: 95
            title: "Page Background"
            anchors{
                bottom: deletePageSection.top
                bottomMargin: 19
                left: parent.left
                right: parent.right
                leftMargin: 11
                rightMargin: 7
            }
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
        }

    }

}
