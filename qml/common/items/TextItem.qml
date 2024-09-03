import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQml 2.0

ResizableItem {
    id :rootItem
    height: tf.height + 10
    width: tf.width + 20
    property string text_data: "Default Text"
    property color td_color: "#4D365D"
    property int td_size: settings.default_text_size
    onText_dataChanged: {
        tf.text = text_data
        contentUpdated()
    }

    // Force redraw text
    onTd_sizeChanged: {
        console.log("New Td Size : ", td_size)
        text_data += " "
        forceRedrawText.start()
    }

    Timer{
        id : forceRedrawText
        repeat: false
        interval: 20
        onTriggered: {
            text_data = text_data.slice(0, -1);
        }
    }

    signal contentUpdated()

    function escapeHtml(text) {
        let map = {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#039;'
        };
        return text.replace(/[&<>"']/g, function(m) { return map[m]; });
    }
    function isValidColor(color) {
        let hexColorRegex = /^#([0-9A-F]{3}){1,2}$/i;
        let namedColors = ['red', 'blue', 'green', 'yellow', 'purple', 'black', 'white', 'gray', 'orange'];
        return hexColorRegex.test(color) || namedColors.includes(color.toLowerCase());
    }

    function get_html() {
        let safeTextData = text_data ? escapeHtml(text_data) : "Default Text";
        let safetdColor = isValidColor(td_color) ? td_color : "#4D365D";

        let html = `
        <style>
        .text-container {
        display: grid; place-items: center; width: 100%; height: 100%; font-size: ${td_size}px; color: ${safetdColor}; font-family: 'Nunito', sans-serif; font-weight: 600; padding: 10px; box-sizing: border-box; background-color: transparent;  /* Set background to transparent */
        }
        .text-content {
        text-align: center; line-height: 1.5; word-wrap: break-word;
        }
        </style>
        <div class="text-container">
        <div class="text-content">${safeTextData}</div>
        </div>`;

        console.log(html);
        return html;
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
            border.width: 1
            border.color: "steelblue"
        }

        TextArea {
            id: tf
            text: text_data
            font.pixelSize: td_size
            font.weight: Font.DemiBold
            color: td_color
            font.family: "Nunito"
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            onTextChanged: text_data = tf.text
            background: Item{}
            onActiveFocusChanged: isChildFocused = tf.activeFocus
        }
    }

    onItem_idChanged : {
        element_tag = "text_" + item_id
    }
}
