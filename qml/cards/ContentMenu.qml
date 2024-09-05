import QtQuick 2.0
import "../common"
import "../components"
import QtQuick.Controls 2.0
import QtQuick.Controls 2.15

ContentBase{
    id : detailContent

    property var item_data: undefined


    function update_content(item){
        detailContent.item_data = item
        detailContent.item_data.sync.connect(handleSync)
        handleSync()
    }

    function handleSync(){
        console.log("handle Sync :", list_pages.count)
        for(var i=0;i< list_pages.count;i++){
            let radio_btn = list_pages.itemAt(i);
            radio_btn.checked = item_data.check_contains(radio_btn.text)
        }
        cbBg.btn_color = item_data.bg_color
        cbBg2.btn_color2 = item_data.bg_hover_color
        cbTextColor.btn_color3 = item_data.text_color
        btnTextSize.updateValue(item_data.text_size)
    }

    function update_item_data(index){
        item_data.update_list(index)
    }

    Text{
        id :titleHeader
        height: 16
        font.pixelSize: 16
        font.weight: Font.DemiBold
        width: parent.width
        text : "Pages on Menu"
        color: "#4D365D"
        font.family: "Nunito"
    }

    Connections{
        target: controller
        function onPagesChanged(){
            handleSync()
        }
    }

    ScrollView{
        clip: true
        anchors{
            top: titleHeader.bottom
            bottom: cbBg.top
            left: parent.left
            right: parent.right
            margins: 15
            leftMargin: 0
        }
        Column{
            id : pagesContainer
            anchors.fill: parent
            Repeater{
                id : list_pages
                clip: true
                anchors.fill: parent
                model: controller.pages
                delegate: RadioButton{
                    id : radioBtn
                    font.family: "Nunito"
                    font.pixelSize: 16
                    autoExclusive: false
                    text: modelData.page_name
                    icon.color: "#7E69FF"
                    indicator: Rectangle {
                        implicitWidth: 26
                        implicitHeight: 26
                        x: control.leftPadding
                        y: parent.height / 2 - height / 2
                        radius: 13

                        Rectangle {
                            width: 16
                            height: 16
                            anchors.centerIn: parent
                            radius: 7
                            color: "#7E69FF"
                            visible: radioBtn.checked
                        }
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: update_item_data(index)
                    }
                }
            }
        }
    }

    ComboBoxTitle{
        id : cbBg
        height: 62
        title: "BG Colour"
        width: parent.width - 4
        property color btn_color: "#26D842"

        anchors{
            bottom: btnTextSize.top
            bottomMargin: 9
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
            item_data.bg_color = newColor
            console.log("Update Colour : ",newColor)
        }
    }

    ComboBoxTitle{
        id : cbBg2
        height: 62
        title: "BG Hover Colour"
        width: parent.width
        property color btn_color2: "#A936A1"

        anchors{
            left : parent.left
            bottom: btnTextSize.top
            bottomMargin: 9
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
            item_data.bg_hover_color = newColor
            console.log("Update Colour : ",newColor)
        }
    }

    NumberSelector{
        id : btnTextSize
        anchors.left: parent.left
        anchors.bottom: deletePageSection.top
        anchors.bottomMargin: 9
        height: 62
        width: 62
        z:100
        onValueUpdated: item_data.text_size = getValue()
    }

    ComboBoxTitle{
        id : cbTextColor
        height: 62
        title: "Text Colour"
        width: parent.width
        property color btn_color3: "#160C34"

        anchors{
            left : parent.left
            bottom: deletePageSection.top
            bottomMargin: 9
            leftMargin: parent.width / 2 + 4
        }
        page_color: btn_color3
        onBtnClicked: {
            popupColorPicker3.currentColor = btn_color3
            popupColorPicker3.syncColor(btn_color3)
            popupColorPicker3.show()
        }
    }

    PopupColorPicker{
        id : popupColorPicker3
        visible: false
        onAccepted: {
            cbTextColor.btn_color3 = newColor
            item_data.text_color = newColor
            console.log("Update Colour : ",newColor)
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
