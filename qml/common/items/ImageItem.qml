import QtQuick 2.0
import QtQml 2.0

ResizableItem {
    height: 200
    width: 200
    property string image_source: "qrc:/assets/img_place_holder.png"
    onImage_sourceChanged: img_preview = image_source

    function get_html(){
        let html = `<img src="${image_source}" style="width: 100%; height: 100%;">`
        return html
    }

    content: Item{
        anchors.fill: parent
        Image{
            id : img_preview
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: image_source
        }
    }

    onItem_idChanged: {
        element_tag = "img_" + item_id
    }
}
