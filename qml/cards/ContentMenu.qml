import QtQuick 2.0
import "../common"
import "../components"
import QtQuick.Controls 2.0

ContentBase{
    id : detailContent

    property var item_data: undefined

    property bool isUpdating: false

    function update_content(item){
        console.log("Updating Content")
        detailContent.item_data = item
        isUpdating = true;
        for(var i =0;i<list_pages.count;i++){
            let radio_btn = list_pages.contentItem.children[i];
            radio_btn.checked = item_data.check_contains(radio_btn.text)
        }
        isUpdating = false;
    }

    function update_item_data(){
        let arr_pages = []
        for(var i =0;i<list_pages.count;i++){
            if(list_pages.contentItem.children[i].checked){
                arr_pages.push(controller.pages[i].page_name)
            }
        }
        item_data.update_list(arr_pages)
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

    ListView{
        id : list_pages
        clip: true
        anchors{
            top: titleHeader.bottom
            bottom: deletePageSection.top
            left: parent.left
            right: parent.right
            margins: 15
            leftMargin: 0
        }

        model : controller.pages
        delegate: RadioButton{
            font.family: "Nunito"
            font.pixelSize: 16
            autoExclusive: false
            text: modelData.page_name
            icon.color: "#454045"
            checked: item_data.check_contains(modelData.page_name)
            onCheckedChanged: if(!isUpdating) update_item_data()
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
