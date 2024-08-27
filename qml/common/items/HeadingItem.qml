import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQml 2.0

ResizableItem {
    height: 40
    width: tf.width + 20
    property string text_data: "Default Heading"
    property string tag_heading: "h3"
    property color hd_color: "#4D365D"

    onText_dataChanged: {
        tf.text = text_data
        contentUpdated()
    }

    signal contentUpdated()

    function handleFocusChild(){
        console.log("HandleFocusChild")
        tf.forceActiveFocus()
        tf.text = text_data
        tf.selectAll()
    }

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

function isValidHeadingTag(tag) {
    return ['h1', 'h2', 'h3', 'h4', 'h5', 'h6'].includes(tag.toLowerCase());
}
    function isValidColor(color) {
        let hexColorRegex = /^#([0-9A-F]{3}){1,2}$/i;
        let namedColors = ['red', 'blue', 'green', 'yellow', 'purple', 'black', 'white', 'gray', 'orange'];
        return hexColorRegex.test(color) || namedColors.includes(color.toLowerCase());
    }

function get_html() {
    let safeTextData = escapeHtml(text_data);
    let safeTagHeading = isValidHeadingTag(tag_heading) ? tag_heading.toLowerCase() : 'h3';  // Default to 'h3' if invalid
    let safehdColor = isValidColor(hd_color) ? hd_color : "#4D365D";

    let html = `
        <div style="display: grid; place-items: center; width: 100%; height: 100%; padding: 10px;">
            <${safeTagHeading} style="margin: 0; font-size: 24px; font-weight: 700; color: ${safehdColor}; font-family: 'Nunito', sans-serif; text-align: center;">
                ${safeTextData}
            </${safeTagHeading}>
        </div>
    `;
    return html;
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
            border.width: /*tf.activeFocus ? 1 : 0*/ 1
            border.color: "steelblue"
        }
        TextInput {
            id: tf
            height: 40
            font.pixelSize: 18
            font.weight: Font.DemiBold
            color: hd_color
            font.family: "Nunito"
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: text_data
            onTextChanged: text_data = tf.text
            onActiveFocusChanged: isChildFocused = tf.activeFocus
        }
    }
}
