import QtQuick 2.12

Rectangle {
    width:10
    height:10

    x:parent.mapFromGlobal(windowRoot.dragCenter.x,0).x
    y:parent.mapFromGlobal(0,windowRoot.dragCenter.y).y
    z:100

    color:"transparent"

    Drag.active:windowRoot.dragCenter.active
    Drag.keys: windowRoot.dragCenter.keys


}
