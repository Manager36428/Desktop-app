import QtQuick 2.0
Item {
    property bool active : false
    property GDropArea dragTarget:null
    property GDrager   dragItem:null
    property var keys : []
    property var positionDropped: {"x":0,"y":0}
    property bool isDroppedOk: false

    function clearData(){
        positionDropped.x = 0
        positionDropped.y = 0
        isDroppedOk = false;
    }
}
