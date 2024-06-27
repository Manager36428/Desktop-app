import QtQuick 2.0
import QtQml 2.0

ResizableItem {
    height: 200
    width: 200
    property string image_source: "qrc:/web_temp/img/hero-bg.png"

    content: Item{
        anchors.fill: parent
        Image{
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: image_source
        }
    }

    onItem_idChanged: {
        element_tag = "img_" + item_id
    }
}
