import QtQuick 2.0
import QtQml 2.0

ResizableItem {
    height: 68
    width: 120
    property string text_data: "Button"
    property string bg_color: "#CCD826"
    property string bg_hover_color: "#A936A1"
    property string text_color: "#160C34"
    property int text_size: 16
    property var list_pages: []
    signal sync()

    Component.onCompleted: {
        list_pages = controller.get_init_menu()
        console.log(list_pages)
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

    function get_html() {
        let safeListPages = Array.isArray(list_pages) ? list_pages : [];
        let html = `
        <style>
        .menu-container {
        display: grid; grid-template-columns: repeat(auto-fill, minmax(100px, 1fr)); gap: 10px; padding: 10px; background-color: ${bg_color}; font-family: 'Nunito', sans-serif;
        }
        .menu-item {
        background-color: "transparent" ; color: ${text_color}; padding: 10px; text-align: center; border-radius: 15px; transition: transform 0.2s, background-color 0.2s; cursor: pointer;
        }
        .menu-item:hover {
        background-color: ${bg_hover_color} ;
        transform: scale(1.05);
        }
        </style>
        <div class="menu-container">\n`;

        safeListPages.forEach(item => {
                                  let safeItem = escapeHtml(item);
                                  html += `  <div class="menu-item">${safeItem}</div>\n`;
                              });

        html += "</div>";
        console.log(html);
        return html;
    }


    onItem_idChanged : {
        element_tag = "menu_" + item_id
    }

    function check_contains(page_name){
        console.log("Checking : ", page_name)
        for(var i = 0; i< list_pages.length; i++){
            if(page_name == list_pages[i]) {
                console.log("True ", page_name )
                return true
            }
        }
        console.log("False ", page_name )
        return false
    }

    function sync_pages(){
        for(var i = 0;i<list_pages.length;i++){
            if(!check_page_is_existed(list_pages[i])){
                list_pages.splice(i, 1);
            }
        }
    }

    function check_page_is_existed(page_name){
        for(var j=0;j<controller.pages.length;j++){
            if(page_name == controller.pages[j].page_name){
                return true;
            }
        }
        return false;
    }


    function update_list(index){
        console.log("Update : " + index)
        let page_name_at_index = controller.pages[index].page_name
        let idx_in_list = list_pages.indexOf(page_name_at_index)
        console.log("Page NAme At Index ", page_name_at_index);
        console.log("idx_in_list ", idx_in_list);
        if(idx_in_list !== -1){
            list_pages.splice(idx_in_list, 1)
        }else{
            list_pages.push(page_name_at_index)
        }

        let temp = []
        for(var i=0;i<controller.pages.length;i++){
            let page_name = controller.pages[i].page_name
            if(list_pages.indexOf(page_name) !== -1){
                temp.push(page_name)
            }
        }

        list_pages = temp;
        console.log("List Pages : ", list_pages)
        sync();
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
