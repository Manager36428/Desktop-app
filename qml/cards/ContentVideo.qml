import QtQuick 2.0
import "../common"
import "../components"

ContentBase{
    id : detailContent

    property var item_data: undefined

    function update_content(item){
        console.log("Updating Content")
        detailContent.item_data = item
        tfYoutubeVideo.content.text = item.video_source
    }

    TextFieldTitle{
        id : tfYoutubeVideo
        height: 61
        width: parent.width
        title: "Youtube URL"
        content.text: item.video_source
        anchors{
            top: parent.top
        }
        content.onTextChanged: {
            detailContent.item_data.video_source = tfYoutubeVideo.content.text
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
