import QtQuick 2.0
import QtQml 2.0

ResizableItem {
    height: 200
    width: 200
    property string image_source: "qrc:/assets/img_place_holder.png"
    onImage_sourceChanged: img_preview = image_source

   function get_html() {
    let html = `
    <style>
        .grid-container {
            display: grid;
            grid-template-columns: 1fr;
            grid-template-rows: 1fr;
            place-items: center;
            width: 100%;
            height: 100%;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
        .image-element {
            max-width: 100%;
            max-height: 100%;
            object-fit: cover;
            border-radius: 5px;
            transition: transform 0.3s ease-in-out;
        }
    </style>
    <div class="grid-container">
        <img src="${image_source}" class="image-element">
    </div>`;
    return html;
}


    content: Item{
        anchors.fill: parent
        Image{
            id : img_preview
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: image_source
        }
    }

    onItem_idChanged: {
        element_tag = "img_" + item_id
    }
}
