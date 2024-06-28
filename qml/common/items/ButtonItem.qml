import QtQuick 2.0
import QtQml 2.0

ResizableItem {
    height: 40
    width: 120
    property string btn_name: "Button"
    property string btn_source: ""
    property color btn_color: "#7E69FF"

    function get_html(){
        let action_click = btn_source.length == 0 ? "" : `onclick="window.open('${btn_source}', '_blank')"`
        let html = `<button ${action_click}  href="${btn_source}" style=" background-color: ${btn_color};
        width: 100%; height: 100%; font-size: 16px;"> ${btn_name} </button>`
        console.log(html)
        return html
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
                text: btn_name
                color: "white"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "Nunito"
                font.weight: Font.DemiBold
                anchors.fill: parent
                font.pixelSize: 16
            }
        }
    }

    onItem_idChanged: element_tag = "btn_" + item_id
}
