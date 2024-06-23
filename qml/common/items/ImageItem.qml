import QtQuick 2.0

ResizableItem {
    height: 200
    width: 200
    property string text_data: "qrc:/web_temp/img/hero-bg.png"

    content: Item{
        anchors.fill: parent
        Image{
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: text_data
        }
    }
}
