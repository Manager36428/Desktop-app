import QtQuick 2.0
import "../common"
import "../components"
import QtQuick.Dialogs 1.3

ContentBase{
    id : detailContent

    property var item_data: undefined

    function update_content(item){
        console.log("Updating Content")
        detailContent.item_data = item
        tfTitle.content.text = item.text_data
        heading_list.setIndexByTag(item.tag_heading)
    }

    Text{
        id :titleHeader
        height: 16
        font.pixelSize: 16
        font.weight: Font.DemiBold
        width: parent.width
        text : "Image"
        color: "#4D365D"
        font.family: "Nunito"
    }

    Rectangle{
        id : imagePreview
        color: "#B3B3B3"
        radius: 10
        height: 142
        width: 282
        anchors{
            top: titleHeader.bottom
            topMargin: 9
        }

        Image{
            id : imgPreview
            height: imagePreview.height - 10
            anchors.top: imagePreview.top
            anchors.topMargin: 5
            fillMode: Image.PreserveAspectCrop
            width: parent.width - 10
            anchors.left: imagePreview.left
            anchors.leftMargin: 5
            anchors.centerIn: parent
            source: item_data.image_source
            onSourceChanged: item_data.image_source = imgPreview.source
        }
    }

    ButtonText{
        isActive: false
        btnName: "Add Image"
        width: 100
        height: 36
        anchors{
            top: imagePreview.bottom
            topMargin: 13
        }
        onBtnClicked: fileDialog.open()
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

    FileDialog {
        id: fileDialog
        title: "Select an Image"
        folder: shortcuts.pictures
        nameFilters: ["Image files (*.png)"]
        onAccepted: {
            console.log("Image Selected: ", fileDialog.fileUrl)
            imgPreview.source = fileDialog.fileUrl
        }
    }

}
