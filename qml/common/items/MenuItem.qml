import QtQuick 2.0

ResizableItem {
    height: 68
    width: 120
    property string text_data: "Button"
    property var list_pages: []

    Component.onCompleted: {
        list_pages = controller.get_init_menu()
        console.log(list_pages)
    }

    function check_contains(page_name){
        for(var i = 0;i<list_pages.length;i++){
            if(page_name == list_pages[i]) return true
        }
        return false
    }

    function update_list(new_pages){
        console.log("Update : " + new_pages)
        list_pages = new_pages
        lv_pages.model = list_pages
    }

    content: Item{
        anchors.fill: parent
        Rectangle {
            id : btnRoot
            property bool isActive: true
            property string btnName: text_data
            radius: 10
            color: "transparent"
            anchors.fill: parent
            border.width: 1
            border.color: "black"
            antialiasing: true

            ListView{
                id : lv_pages
                anchors{
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                    margins: 2
                }
                clip: true
                model: list_pages.length
                spacing : 4
                delegate: Item{
                    height: 20
                    width: parent.width
                    Text{
                        id : txtTitle
                        height: 20
                        verticalAlignment: Text.AlignVCenter
                        text: "\u2022 " + list_pages[index]
                        width: parent.width
                        color: "#4D365D"
                        font.family: "Nunito"
                        font.pixelSize: 18
                        font.weight: Font.DemiBold
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }


            }
        }
    }
}
