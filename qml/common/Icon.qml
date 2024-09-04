import QtQuick 2.0

Image {
    id: btnRoot
    signal btnClicked()

    SequentialAnimation {
        loops: 1

        PropertyAnimation {
            id: scaleDownAnim
            targets: btnRoot
            properties: "scale"
            from: 1.0
            to: 0.9
            duration: 100
        }

        PropertyAnimation {
            id: scaleUpAnim
            targets: btnRoot
            properties: "scale"
            from: 0.9
            to: 1.0
            duration: 100
        }

        id: zoomInOutAnim
        onStopped: btnClicked()
    }

    MouseArea {
        id: mouseArea
        z: 10
        anchors.fill: parent
        onClicked: zoomInOutAnim.restart()
        hoverEnabled: true

        // Scale effect on hover
        onEntered: {
            btnRoot.scale = 1.1
        }
        onExited: {
            btnRoot.scale = 1.0
        }
    }
}
