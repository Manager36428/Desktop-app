import QtQuick 2.0
import "../common"
import "../components"

ContentBase{
    id : detailContent

    TextFieldTitle{
        id : tfYoutubeVideo
        height: 61
        width: parent.width
        title: "Youtube URL"
        content.text: "ForBiggerFun.mp4"
        anchors{
            top: parent.top
        }
        content.onTextChanged: {

        }
    }

    TextFieldWarning{
        id : deletePageSection
        title: "Delete Page"
        height: 113
        width: parent.width
        anchors{
            bottom: parent.bottom
        }
        content.onAccepted: {
            if(content.text == "DELETE"){
                currentPage.remove_current_item();
                content.text = ""
            }
        }
    }
}
