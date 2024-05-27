import QtQuick 2.0

Image{
    id : btnRoot
    signal btnClicked()

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
        onStopped: btnClicked()
    }

    MouseArea{
        id : mouseArea
        z:10
        anchors.fill: parent
        onEntered: scaleDownAnim.restart()
        onReleased: scaleUpAnim.restart()
    }
}
