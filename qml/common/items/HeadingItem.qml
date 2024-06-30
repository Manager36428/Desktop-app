import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQml 2.0

ResizableItem {
    height: 40
    width: tf.width + 20
    property string text_data: "Default Heading"
    property string tag_heading: "h3"

    onText_dataChanged: {
        tf.text = text_data
        contentUpdated()
    }

    signal contentUpdated()

    function handleFocusChild(){
        console.log("HandleFocusChild")
        tf.forceActiveFocus()
        tf.text = text_data
    }

    function get_html(){
        let html = `<${tag_heading} style="width: 100%; height: 100%; font-size: 16px;">
        ${text_data} </${tag_heading}>`
        return html
    }

    Component.onCompleted: {
        focusChild.connect(handleFocusChild)
    }

    onItem_idChanged : {
        element_tag = "heading_" + item_id
    }

    content: Item{
        anchors.fill: parent
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.width: tf.activeFocus ? 1 : 0
            border.color: "steelblue"
        }
        TextInput {
            id: tf
            height: 40
            font.pixelSize: 18
            font.weight: Font.DemiBold
            color: "#4D365D"
            font.family: "Nunito"
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: text_data
            onTextChanged: text_data = tf.text
        }
    }
}
