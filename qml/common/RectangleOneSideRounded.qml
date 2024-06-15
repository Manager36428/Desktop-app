import QtQuick 2.0

Item {
    id : rootRect
    clip: true
    property string side: "top"
    property alias rect: _rect
    property alias color: _rect.color
    property alias radius: _rect.radius

    onSideChanged: updateSide()

    function updateSide(){
        _rect.anchors.top = undefined
        _rect.anchors.bottom = undefined
        _rect.anchors.left = undefined
        _rect.anchors.right = undefined
        console.log("Side :",side);
        switch(side){
        case "top":
            _rect.anchors.top = rootRect.top
            break;
        case "bottom":
            _rect.anchors.bottom = rootRect.bottom
            break;
        case "left":
            _rect.anchors.left = rootRect.left
            break;
        case "right":
            _rect.anchors.right = rootRect.right
            break;
        }
    }

    Rectangle {
        id : _rect
        width: parent.width
        height: parent.height + radius
        radius: 10
        color: "blue"
    }

    Component.onCompleted: updateSide()
}
