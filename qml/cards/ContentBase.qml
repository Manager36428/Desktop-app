import QtQuick 2.0
import "../common"
import "../components"

Item{
    id : contentBase
    property var currentPage: controller.current_page

    anchors.fill: parent

    function removeItem(item_id){
        currentPage.remove_child(item_id)
    }

}
