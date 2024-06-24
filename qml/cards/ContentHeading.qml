import QtQuick 2.0
import "../common"
import "../components"

ContentBase{
    id : detailContent

    property var item_data: undefined

    function update_content(item){
        console.log("Updating Content")
        detailContent.item_data = item
        item_data.contentUpdated.connect(handleContentUpdated)
        tfTitle.content.text = item.text_data
        heading_list.setIndexByTag(item.tag_heading)
    }

    function handleContentUpdated(){
        tfTitle.content.text = item.text_data
    }

    TextFieldTitle{
        id : tfTitle
        height: 96
        width: parent.width
        title: "Title"
        content.text: "title"
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

        content.height: 72
    }

    DropdownList{
        id : heading_list
        z:10
        anchors{
            top: tfTitle.bottom
            topMargin: 13
        }
        onValueUpdated: {
            item_data.tag_heading = tag_value
            console.log(item_data.tag_heading)
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
