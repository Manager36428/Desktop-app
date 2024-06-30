import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQml 2.0

ResizableItem {
    id :rootItem
    height: tf.contentHeight + 10
    width: tf.contentWidth + 20
    property string text_data: "Default Text"
    onText_dataChanged: {
        tf.text = text_data
        contentUpdated()
    }

    signal contentUpdated()

    function get_html(){
        let html = `<p style="width: 100%; height: 100%; font-size: 16px;"> ${text_data} </p>`
        return html
    }

    function handleFocusChild(){
        console.log("HandleFocusChild")
        tf.forceActiveFocus()
        tf.text = text_data
        tf.selectAll()
    }

    Component.onCompleted: {
        focusChild.connect(handleFocusChild)
    }

    content: Item{
        anchors.fill: parent
        Rectangle{
            anchors.fill: parent
            color: "transparent"
            border.width: /*tf.activeFocus ? 1 : 0*/ 1
            border.color: "steelblue"
        }

        TextArea {
            id: tf
            text: text_data
            anchors.fill: parent
            font.pixelSize: 18
            font.weight: Font.DemiBold
            color: "#4D365D"
            font.family: "Nunito"
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            onTextChanged: text_data = tf.text
            background: Item{}
        }
    }

    onItem_idChanged : {
        element_tag = "text_" + item_id
    }
}
