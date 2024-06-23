import QtQuick 2.0
import "../common"
import "../components"

Item{
    id : detailContent
    anchors.fill: parent
    property var currentPage: controller.current_page
    onCurrentPageChanged: detailCard.title = currentPage != undefined ? "Details" + " : " + currentPage.page_name : "Details"

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

    Item{
        anchors{
            top: detailType.bottom
            bottom: parent.bottom
            bottomMargin: 17
            topMargin: 15
            left: parent.left
            right: parent.right
            leftMargin: 11
            rightMargin: 7
        }

        ContentPage{
            anchors.fill: parent
        }
    }
}
