import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQml 2.0

ResizableItem {
    id :rootItem
    height: tf.height + 10
    width: tf.width + 20
    property string text_data: "Default Text"
    onText_dataChanged: {
        tf.text = text_data
        contentUpdated()
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

function get_html() {
    let safeTextData = text_data ? escapeHtml(text_data) : "Default Text";

    let html = `
    <style>
        .text-container {
            display: grid; place-items: center; width: 100%; height: 100%; font-size: 18px; color: #4D365D; font-family: 'Nunito', sans-serif; font-weight: 600; padding: 10px; box-sizing: border-box; background-color: transparent;  /* Set background to transparent */
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
            border.width: /*tf.activeFocus ? 1 : 0*/ 1
            border.color: "steelblue"
        }

        TextArea {
            id: tf
            text: text_data
            font.pixelSize: 18
            font.weight: Font.DemiBold
            color: "#4D365D"
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
