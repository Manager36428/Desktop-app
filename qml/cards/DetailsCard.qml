import QtQuick 2.0
import "../common"

TitleCard {
    title: "Details"
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

    Flickable
    {
        clip: true

        anchors{
            top: detailType.bottom
            topMargin: 19
            bottom: deletePageSection.top
            bottomMargin: 15
            left: parent.left
            right: parent.right
            leftMargin: 11
            rightMargin: 7
        }
        Column{
            id : contentDetail

            spacing: 15
            anchors.fill: parent
            TextFieldTitle{
                height: 61
                width: parent.width
                title: "Page Name"
                content.text: "Home"
            }

            TextFieldTitle{
                height: 96
                width: parent.width
                title: "Page Description"
                content.text: "Page description that will be used for meta description"
            }

            ComboBoxTitle{
                height: 95
                width: parent.width
                title: "Page Background"
            }

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
