import QtQuick 2.6
import QtQuick.Window 2.2
import QtQml 2.0

Item {

    id: root
    readonly property alias dragging: mouseArea.pressed
    // @disable-check M16
    default property alias data: draggable.data
    property int hotSpotX: 0
    property int hotSpotY: 0
    property int threshold: 0
    property var keys : []

    signal dropDone(var x, var y);
    signal dropCanceled();


    Item {
        id: draggable
        width:root.width
        height: root.height
    }


    Component {
        id: windowComponent
        Window {
            visible: true
            color: "transparent"
            flags: Qt.Tool | Qt.FramelessWindowHint | Qt.WindowDoesNotAcceptFocus
            width: root.width
            height: root.height
            data: draggable
        }
    }

    Item {

        id: dymmy
        width:root.width
        height: root.height
    }

    MouseArea {
        id: mouseArea
        property Window window: null
        width:root.width
        height: root.height
        drag.target: dymmy
        drag.threshold: root.threshold
        property int startx:0
        property int starty:0
        z: 1

        onPressed:
        {
            startx=mouseX;
            starty=mouseY;
        }

        drag.onActiveChanged:
        {
            if(drag.active)
            {
                var pos=draggable.mapToGlobal(0,0);
                window = windowComponent.createObject(Window.window, {})
                window.x= pos.x;
                window.x=Qt.binding(function(){return root.mapToGlobal(mouseX-startx,0).x})
                window.y=Qt.binding(function(){return root.mapToGlobal(0,mouseY-starty).y})
                windowRoot.dragCenter.x=Qt.binding(function(){return window.x+hotSpotX})
                windowRoot.dragCenter.y=Qt.binding(function(){return window.y+hotSpotY})
                windowRoot.dragCenter.dragTarget=null;
                windowRoot.dragCenter.dragItem=root;
                windowRoot.dragCenter.keys=root.keys
                windowRoot.dragCenter.active=true;
            }
            else
            {
                if(windowRoot.dragCenter.isDroppedOk){
                    dropDone(windowRoot.dragCenter.positionDropped.x, windowRoot.dragCenter.positionDropped.y)
                    windowRoot.dragCenter.clearData()
                }else{
                    dropCanceled();
                }

                draggable.parent = root;
                draggable.x=0;
                draggable.y=0;
                dymmy.x=0;
                dymmy.y=0;
                windowRoot.dragCenter.active=false;
                windowRoot.dragCenter.dragItem=null;
                windowRoot.dragCenter.x=0;//break bind
                windowRoot.dragCenter.y=0;//break bind
                window.destroy();
            }
        }
    }
}
