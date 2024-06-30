import QtQuick 2.0
import "../common"
import "../components"

ContentBase{
    id : detailContent

    property var item_data: undefined

    function update_content(item){
        console.log("Updating Content")
        detailContent.item_data = item
        tfTitle.content.text = item.text_data
        item_data.contentUpdated.connect(handleContentUpdated)
    }

    function handleContentUpdated(){
        tfTitle.content.text = item_data.text_data
    }

    TextFieldTitle{
        id : tfTitle
        height: 96
        width: parent.width
        title: "Text"
        content.text: item_data.text_data
        anchors{
            top: parent.top
        }
        content.onTextChanged: delayUpdate.restart();

        Timer{
            id : delayUpdate
            interval: 500
            repeat: false
            onTriggered: {
                item_data.text_data = tfTitle.content.text
                console.log(item_data.text_data)
            }
        }
        content.height: 185
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
