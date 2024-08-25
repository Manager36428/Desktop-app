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
        item_data.contentUpdated.connect(handleContentUpdated)
    }

    function handleContentUpdated(){
        tfButtonHome.content.text = item_data.btn_name
    }

    TextFieldTitle{
        id : tfButtonHome
        height: 61
        width: parent.width
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
        width: parent.width
        title: "Button URL"
        anchors{
            top: tfButtonHome.bottom
            topMargin: 20
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
        width: parent.width
        property color btn_color: "#26D842"

        anchors{
            top : tfButtonUrl.bottom
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
