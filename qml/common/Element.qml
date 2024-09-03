import QtQuick 2.0
import "../dragdrop"

GDrager {
    height: 80
    width: 150
    property string elementName: ""
    property string elementIcon: ""
    hotSpotX: 0
    hotSpotY: 0

    Rectangle {
        id: btnRoot
        anchors.fill: parent
        radius: 10
        border.width: mouseArea.containsMouse && !mouseArea.drag.active && !mouseArea.pressed ? 1 : 0
        border.color: "white"

        // Change color based on hover, active, drag, and press-and-hold states
        color: (mouseArea.pressed && mouseArea.containsMouse) || mouseArea.drag.active
                ? Qt.rgba(0.2235, 0.2118, 0.2196, 0.5)  // Default color when pressed or dragged
                : (mouseArea.containsMouse
                    ? "#454045"  // Hover color when mouse is over and not pressed
                    : (isActive
                        ? "#7E69FF"  // Active color when not pressed but active
                        : Qt.rgba(0.2235, 0.2118, 0.2196, 0.5)))  // Default color

        property bool isActive: false
        signal btnClicked()

        GDragAgent {}

        Image {
            id: iconElement
            height: 36
            width: 36
            source: elementIcon
            anchors {
                top: parent.top
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
        }

        Text {
            height: 22
            font.pixelSize: 16
            font.weight: Font.DemiBold
            lineHeight: 22
            font.family: "Nunito"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: "white"
            text: elementName
            anchors {
                left: parent.left
                right: parent.right
                top: iconElement.bottom
                margins: 4
            }
        }

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
            onStopped: {
                btnClicked()
                btnRoot.forceActiveFocus()
            }
        }

        MouseArea {
            id: mouseArea
            z: 10
            anchors.fill: parent
            onClicked: zoomInOutAnim.restart()
            hoverEnabled: true

            // Handle press and hold
            onPressAndHold: {
                btnRoot.color = Qt.rgba(0.2235, 0.2118, 0.2196, 0.5);  // Change to default color
            }
        }
    }
}
