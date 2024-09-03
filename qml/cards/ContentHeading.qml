import QtQuick 2.0
import "../common"
import "../components"

ContentBase{
    id : detailContent

    property var item_data: undefined

    function update_content(item){
        console.log("Updating Content")
        detailContent.item_data = item
        hbBg.hd_color = item_data.hd_color
        item_data.contentUpdated.connect(handleContentUpdated)
        tfTitle.content.text = item.text_data
        heading_list.setIndexByTag(item.tag_heading)
    }

    function handleContentUpdated(){
        tfTitle.content.text = item_data.text_data
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

    ComboBoxTitle{
        id : hbBg
        height: 95
        title: "Heading Colour"
        width: parent.width
        property color hd_color: "black"

        anchors{
            top : heading_list.bottom
            topMargin: 20
        }
        page_color: hd_color
        onBtnClicked: {
            popupColorPicker.currentColor = hd_color
            popupColorPicker.syncColor(hd_color)
            popupColorPicker.show()
        }
    }

    PopupColorPicker{
        id : popupColorPicker
        visible: false
        onAccepted: {
            hbBg.hd_color = newColor
            item_data.hd_color = newColor
            console.log("Update Colour : ",newColor)
        }
    }

    DropdownList{
        id : heading_list
        z:10
        anchors{
            top: tfTitle.bottom
            topMargin: 13
            left: parent.left
            right: parent.right
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
