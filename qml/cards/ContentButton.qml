import QtQuick 2.0
import "../common"
import "../components"

ContentBase{
    id : detailContent

    property var item_data: undefined

    function update_content(item){
        console.log("Updating Content")
        detailContent.item_data = item
        tfButtonHome.content.text = item_data.btn_name
        tfButtonUrl.content.text = item_data.btn_source
        cbBg.btn_color = item_data.btn_color
        cbBg2.btn_color2 = item_data.btn_color2
        btnTextSize.updateValue(item_data.font_size);
        item_data.contentUpdated.connect(handleContentUpdated)
    }

    function handleContentUpdated(){
        tfButtonHome.content.text = item_data.btn_name
    }

    TextFieldTitle{
        id : tfButtonHome
        height: 61
        width: parent.width / 2 - 4
        title: "Button Name"
        content.placeholderText: "Button"
        anchors{
            top: parent.top
        }
        content.onTextChanged: delayUpdate.restart();

        Timer{
            id : delayUpdate
            interval: 500
            repeat: false
            onTriggered: {
                item_data.btn_name = tfButtonHome.content.text
                console.log(item_data.btn_name)
            }
        }

    }

    TextFieldTitle{
        id : tfButtonUrl
        height: 61
        width: parent.width / 2 - 4
        title: "Button URL"
        anchors{
            left: tfButtonHome.right
            leftMargin: 9
            top: parent.top
        }
        content.placeholderText: "Button URL"

        content.onTextChanged: delayUrlUpdate.restart();

        Timer{
            id : delayUrlUpdate
            interval: 500
            repeat: false
            onTriggered: {
                item_data.btn_source = tfButtonUrl.content.text
                console.log(item_data.btn_source)
            }
        }
    }

    ComboBoxTitle{
        id : cbBg
        height: 95
        title: "Button Colour"
        width: parent.width - 4
        property color btn_color: "#26D842"

        anchors{
            top : tfButtonHome.bottom
            topMargin: 20
        }
        page_color: btn_color
        onBtnClicked: {
            popupColorPicker.currentColor = btn_color
            popupColorPicker.syncColor(btn_color)
            popupColorPicker.show()
        }
    }

    PopupColorPicker{
        id : popupColorPicker
        visible: false
        onAccepted: {
            cbBg.btn_color = newColor
            item_data.btn_color = newColor
            console.log("Update Colour : ",newColor)
        }
    }

    ComboBoxTitle{
        id : cbBg2
        height: 95
        title: "Hover Colour"
        width: parent.width
        property color btn_color2: "#262FD8"

        anchors{
            left : parent.left
            top : tfButtonHome.bottom
            topMargin: 20
            leftMargin: parent.width / 2 + 4
        }
        page_color: btn_color2
        onBtnClicked: {
            popupColorPicker2.currentColor = btn_color2
            popupColorPicker2.syncColor(btn_color2)
            popupColorPicker2.show()
        }
    }

    PopupColorPicker{
        id : popupColorPicker2
        visible: false
        onAccepted: {
            cbBg2.btn_color2 = newColor
            item_data.btn_color2 = newColor
            console.log("Update Colour : ",newColor)
        }
    }

    NumberSelector{
        id : btnTextSize
        anchors.left: parent.left
        anchors.top: cbBg.bottom
        anchors.topMargin: -24
        height: 62
        width: 62
        z:100
        onValueUpdated: item_data.font_size = getValue()
    }

    TextFieldWarning{
        id : deletePageSection
        title: "Delete Element"
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
