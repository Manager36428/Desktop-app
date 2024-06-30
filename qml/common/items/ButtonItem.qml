import QtQuick 2.0
import QtQml 2.0

ResizableItem {
    height: 40
    width: txtBtnName.width + 40
    property string btn_name: "Button"
    property string btn_source: ""
    property color btn_color: "#7E69FF"

    onBtn_nameChanged: {
        txtBtnName.text = btn_name
        tf.text = btn_name
    }

    function get_html(){
        let action_click = btn_source.length == 0 ? "" : `onclick="window.open('${btn_source}', '_blank')"`
        let html = `<button ${action_click}  href="${btn_source}" style=" background-color: ${btn_color};
        width: 100%; height: 100%; font-size: 16px;"> ${btn_name} </button>`
        console.log(html)
        return html
    }

    function handleFocusChild(){
        console.log("HandleFocusChild")
        tf.forceActiveFocus()
        tf.text = btn_name
        tf.selectAll()
    }

    signal contentUpdated()

    Component.onCompleted: {
        focusChild.connect(handleFocusChild)
    }

    content: Item{
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
                font.pixelSize: 16
                visible: !tf.activeFocus
                anchors.centerIn: parent
            }
        }
        TextInput{
            id : tf
            height: 40
            font.weight: Font.DemiBold
            color: "white"
            font.family: "Nunito"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.centerIn: parent
            onTextChanged: {
                btn_name = tf.text
                contentUpdated()
            }

            visible: tf.activeFocus
            text: btn_name
        }
    }

    onItem_idChanged: element_tag = "btn_" + item_id
}
