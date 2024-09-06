import QtQuick 2.0
import QtQml 2.0

ResizableItem {
    height: 40
    width: txtBtnName.width + 40
    property string btn_name: "Button"
    property string btn_source: ""
    property color btn_color: "#26D842"
    property color btn_color2: "#262FD8"

    // Responsive padding and font size based on width
    property real padding_horizontal: Math.max(width * 0.5, 12)
    property real padding_vertical: Math.max(height * 0.75, 8)
    property real font_size: 16

    onBtn_nameChanged: {
        txtBtnName.text = btn_name
        tf.text = btn_name
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

    function isValidColor(color) {
        let hexColorRegex = /^#([0-9A-F]{3}){1,2}$/i;
        let namedColors = ['red', 'blue', 'green', 'yellow', 'purple', 'black', 'white', 'gray', 'orange'];
        return hexColorRegex.test(color) || namedColors.includes(color.toLowerCase());
    }

function get_html() {
    let safeBtnName = escapeHtml(btn_name);
    let safeBtnSource = escapeHtml(btn_source);
    let safeBtnColor = isValidColor(btn_color) ? btn_color : "#26D842";
    let safeBtnColor2 = isValidColor(btn_color2) ? btn_color2 : "#262FD8";

    // Calculate padding and font size based on button size
    let padding = `${Math.round(padding_vertical)}px ${Math.round(padding_horizontal)}px`;
    let fontSize = `${font_size}px`;

    let action_click = safeBtnSource.length === 0 ? "" : `onclick="window.open('${safeBtnSource}', '_blank')"`;

    let html = `
        <div style="display: grid; place-items: center; width: 100%; height: 100%;">
            <button ${action_click} style="
                background-color: ${safeBtnColor};
                color: white;
                border: none;
                border-radius: 10px;
                padding: ${padding};
                font-family: 'Nunito', sans-serif;
                font-weight: 600;
                font-size: ${fontSize};
                cursor: pointer;
                transition: background-color 0.3s, transform 0.3s;
            "
            onmouseover="this.style.backgroundColor='${safeBtnColor2}';"
            onmouseout="this.style.backgroundColor='${safeBtnColor}';">
                ${safeBtnName}
            </button>
        </div>
            <style>
                @media (max-width: 768px) {
                    .container {
                        grid-template-columns: 1fr;
                        grid-template-rows: auto;
                        gap: 10px;
                        padding: 10px;
                        width: 100%;
                        max-width: 100vw;
                        height: auto;
                    }

                    .responsive-button {
                        padding: 12px 20px;
                        font-size: 14px;
                        width: auto;
                        max-width: 100%;
                        border-radius: 8px;
                    }
                }
            </style>
        `;
        return html;
    }

    function handleFocusChild() {
        console.log("HandleFocusChild");
        tf.forceActiveFocus();
        tf.text = btn_name;
        tf.selectAll();
    }

    signal contentUpdated()

    Component.onCompleted: {
        focusChild.connect(handleFocusChild);
    }

    content: Item {
        anchors.fill: parent
        Rectangle {
            id : btnRoot
            property bool isActive: true
            radius: 10
            color: btn_color
            anchors.fill: parent

            Text {
                id : txtBtnName
                text: btn_name
                color: "white"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "Nunito"
                font.weight: Font.DemiBold
                font.pixelSize: font_size // Adjust font size dynamically
                visible: !tf.activeFocus
                anchors.centerIn: parent
            }
        }
        TextInput {
            id : tf
            height: 40
            font.weight: Font.DemiBold
            color: "white"
            font.family: "Nunito"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.centerIn: parent
            font.pixelSize: font_size // Adjust font size dynamically
            onTextChanged: {
                btn_name = tf.text
                contentUpdated();
            }

            visible: tf.activeFocus
            text: btn_name
        }
    }

    onItem_idChanged: element_tag = "btn_" + item_id;
}
