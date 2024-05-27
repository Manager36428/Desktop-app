import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    antialiasing: true
    property alias background: rectBg

    MouseArea{
        anchors.fill: parent
        drag.target: rectBg

    }

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
