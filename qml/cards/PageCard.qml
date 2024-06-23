import QtQuick 2.0
import "../common"
import "../dragdrop"

TitleCard {
    title: "Page : " + controller.current_page.page_name
    clip: true
    windowParent.minimumWidth: 720
    windowParent.minimumHeight: 510

    contentDock: Item{
        anchors.fill: parent

        RectangleOneSideRounded{
            side: "bottom"
            id : content
            radius: 10
            anchors{
                top: parent.bottom
                bottom: parent.bottom
                right: parent.right
                left: parent.left
                margins: 1
                topMargin: isDocked ? 40 : 0
            }
            color: controller.current_page.page_background

            anchors.fill: parent
            GDropArea{
                anchors.fill: parent
                GDragAgent{}
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
                        console.log("Object created : ", textItem.item_id)
                    } else if (component.status === Component.Error) {
                        console.log("Error loading component:", component.errorString());
                    }
                }
            }
        }
    }
}
