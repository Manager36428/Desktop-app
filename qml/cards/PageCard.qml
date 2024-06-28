import QtQuick 2.0
import "../common"
import "../dragdrop"

TitleCard {
    title: "Page : " + controller.current_page.page_name
    clip: true
    windowParent.minimumWidth: 720
    windowParent.minimumHeight: 510
    property alias viewport : content

    contentDock: Item{
        id : rootContentCard
        anchors.fill: parent
        anchors{
            top: parent.bottom
            bottom: parent.bottom
            right: parent.right
            left: parent.left
            margins: 1
            topMargin: isDocked ? 40 : 0
        }

        Rectangle{
            id : content
            color: controller.current_page.page_background
            property real old_height : 0
            property real old_width : 0
            property var all_items: []

            Component.onCompleted: {
                old_height = height
                old_width = width
            }

            onHeightChanged: {
                if(old_height == 0 ) return
                let ratio = height/old_height
                for(var i =0 ;i < content.all_items.length ; i++){
                    var child = content.all_items[i];
                    if (child != null) {
                        child.height = child.height*ratio
                        child.y = child.y * ratio
                    }
                }
                old_height = height
                controller.set_viewport_size(content.height, content.width)
            }

            onWidthChanged: {
                if(old_width == 0 ) return

                let ratio = width/old_width
                for(var i =0 ;i < content.all_items.length ; i++){
                    var child = content.all_items[i];
                    if (child != null) {
                        child.width = child.width*ratio
                        child.x = child.x * ratio
                    }
                }
                old_width = width
                controller.set_viewport_size(content.height, content.width)
            }

            width: {
                if (rootContentCard.width / rootContentCard.height > 16 / 9) {
                    return (rootContentCard.height * 16 / 9) - 4
                } else {
                    return rootContentCard.width - 4
                }
            }
            height: (width * 9 / 16) - 4
            anchors.centerIn: parent
            GDropArea{
                anchors.fill: parent
                property int item_id : 9999
                id : dropArea
                clip: true
                GDragAgent{}
            }

            Item{
                id : item_holder
                visible: false
                anchors.fill: parent
            }

            Connections{
                target: controller
                function onReqCreateItem(x,y,item_type){
                    console.log(x + " - " + y + " - " + item_type)
                    let itemPath = 'qrc:/qml/common/items/'+ item_type +'Item.qml'
                    console.log(itemPath)

                    var component = Qt.createComponent(itemPath)
                    console.log("Create OK");
                    if (component.status === Component.Ready) {
                        console.log("Component is Ready !")
                        var textItem = component.createObject(content,{ x: x, y: y })
                        textItem.objectName = item_type
                        textItem.item_id = utils.get_time_string()
                        controller.current_page.add_child(textItem)
                        content.all_items.push(textItem)
                        console.log("Object created : ", textItem.item_id)
                    } else if (component.status === Component.Error) {
                        console.log("Error loading component:", component.errorString());
                    }
                    console.log("Add new Content Itemt: " ,content.children.length)
                }

                function onCurrent_pageChanged(){
                    console.log("Current Page Name : ", controller.current_page.page_name)
                    var childrenCopy = [];
                    for (var i = 0; i < content.children.length; i++) {
                        if(content.children[i].item_id == dropArea.item_id){
                            continue;
                        }
                        childrenCopy.push(content.children[i]);
                    }
                    for(var i =0 ;i < childrenCopy.length ; i++){
                        var child = childrenCopy[i];
                        console.log("Item : ", child.item_id)
                        child.parent = item_holder
                    }
                    let current_page_children = controller.current_page.children;
                    console.log(current_page_children.length)
                    for(var j=0;j< current_page_children.length;j++){
                        var cpchild = current_page_children[j];
                        cpchild.parent = content
                    }
                }
            }
        }
    }
}
