import QtQuick 2.0
import QtGraphicalEffects 1.0

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
            colorOverlay.color = "#00FFFFFF" // Fully transparent
        }
        onExited: {
            btnRoot.scale = 1.0
            colorOverlay.color = "#66FFFFFF" // 40% transparency
        }
    }

    ColorOverlay {
        id: colorOverlay
        anchors.fill: btnRoot
        source: btnRoot
        color: "#66FFFFFF" // 40% transparency (hex value 66)
    }
}
