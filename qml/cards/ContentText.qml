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
        tbBg.td_color = item_data.td_color
        numberSelector.updateValue(item_data.td_size);
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
        content.height: 150
    }

    ComboBoxTitle{
        id : tbBg
        height: 95
        title: "Text Colour"
        width: parent.width
        property color td_color: "black"

        anchors{
            top : tfTitle.bottom
            topMargin: tfTitle.content.height - 50
        }
        page_color: td_color
        onBtnClicked: {
            popupColorPicker.currentColor = td_color
            popupColorPicker.syncColor(td_color)
            popupColorPicker.show()
        }
    }

    NumberSelector{
        id : numberSelector
        height: 62
        width: 62
        z:2
        anchors{
            top : tfTitle.bottom
            topMargin: tfTitle.content.height - 50
            right: parent.right
            rightMargin: 70
        }
        onValueUpdated: item_data.td_size = getValue()
    }

    PopupColorPicker{
        id : popupColorPicker
        visible: false
        onAccepted: {
            tbBg.td_color = newColor
            item_data.td_color = newColor
            console.log("Update Colour : ",newColor)
        }
    }

    TextFieldWarning{
        id : deletePageSection
        title: "Delete Page"
        height: 113
        width: parent.width
        z:-1
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
