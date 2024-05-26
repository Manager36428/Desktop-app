import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    antialiasing: true
    property alias background: rectBg

//    DropShadow {
//        anchors.fill: rectBg
//        horizontalOffset: 3
//        verticalOffset: 3
//        radius: 8
//        samples: 18
//        color: Qt.rgba(0,0,0,0.25)
//        source: rectBg
//    }

    Rectangle{
        id : rectBg

        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }

        gradient: Gradient {
            GradientStop { position: 1.0; color: Qt.rgba(0.6549, 0.6157, 0.6509, 0.55) }
            GradientStop { position: 0.0; color: Qt.rgba(0.8275, 0.7922, 0.8275, 0.55) }
        }
        radius: 10
    }

}
