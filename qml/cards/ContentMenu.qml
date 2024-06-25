import QtQuick 2.0
import "../common"
import "../components"
import QtQuick.Controls 2.0

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
            let radio_btn = list_pages.contentItem.children[i];
            radio_btn.checked = item_data.check_contains(radio_btn.text)
        }
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
        cacheBuffer: 1000
        model : controller.pages
        onModelChanged: {
            item_data.sync_pages()
            handleSync()
        }

        delegate: RadioButton{
            font.family: "Nunito"
            font.pixelSize: 16
            autoExclusive: false
            text: modelData.page_name
            icon.color: "#454045"
            MouseArea{
                anchors.fill: parent
                onClicked: update_item_data(index)
            }
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
