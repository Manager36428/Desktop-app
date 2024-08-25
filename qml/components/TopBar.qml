import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../../qml"

Rectangle {
    width: 400
    height: 300
    color: "#E0D7E3"
    radius: 10

    property bool fileBold: false
    property bool fileMenuOpen: false
    property bool viewBold: false
    property bool viewMenuOpen: false

    Rectangle {
        id: topBar
        width: parent.width
        height: 40
        color: "#C9AFCB"
        radius: 10

        Text {
            id: fileText
            text: "File"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            font.pixelSize: 18
            font.family: "Nunito"
            font.weight: fileBold ? Font.Bold : Font.Medium  // Toggle boldness
            color: "#4D365D"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    fileMenuOpen = !fileMenuOpen; // Toggle menu visibility
                    viewMenuOpen = false; // Close view menu when file menu is opened
                }
                onEntered: { fileBold = true; viewBold = false; fileMenuOpen = true; viewMenuOpen = false; }
                onExited: {
                if (!fileMenuOpen) {
                    fileBold = false;
                    fileMenuOpen = true;
                }
                }
            }
        }

        Text {
            id: viewText
            text: "View"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: fileText.right
            anchors.leftMargin: 20
            font.pixelSize: 18
            font.family: "Nunito"
            font.weight: viewBold ? Font.Bold : Font.Medium  // Toggle boldness
            color: "#4D365D"

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    viewMenuOpen = !viewMenuOpen; // Toggle menu visibility
                    fileMenuOpen = false; // Close file menu when view menu is opened
                }
                onEntered: { viewBold = true; fileBold = false; viewMenuOpen = true; fileMenuOpen = false; }
                onExited: if (!viewMenuOpen) viewBold = false;
            }
        }
    }

    Menu {
        id: fileMenu
        visible: fileMenuOpen
        width: 220
        x: fileText.x - 2
        y: topBar.height + 5
        background: Rectangle {
            color: Qt.rgba(0.9, 0.8, 0.9, 1)
            border.color: Qt.rgba(1, 1, 1, 0)
            border.width: 1
            radius: 10
        }

        MenuItem {
            id: newItem
            text: "New"
            font.pixelSize: 16
            font.family: "Nunito"
            font.weight: hovered ? Font.Bold : Font.Medium
            onTriggered: {
                console.log("New triggered");
                // Reset boldness when a menu item is triggered
                fileBold = false;
                viewBold = false;
                fileMenuOpen = false;
                console.log(newItem.text);
            }
            background: Rectangle {
                color: Qt.rgba(1, 1, 1, 0)
                radius: 5
                border.color: Qt.rgba(1, 1, 1, 0)
                border.width: 1
            }
            Item {
                anchors.right: parent.right
                width: 30
                Text {
                    text: "F1 "
                    anchors.right: parent.right
                    color: "#4D365D"
                    font.pixelSize: 16
                    font.family: "Nunito"
                    font.weight: Font.Medium
                }
            }
        }

        MenuItem {
            id: openItem
            text: "Open"
            font.pixelSize: 16
            font.family: "Nunito"
            font.weight: hovered ? Font.Bold : Font.Medium
            onTriggered: {
                console.log("Open triggered");
                // Reset boldness when a menu item is triggered
                fileBold = false;
                viewBold = false;
                fileMenuOpen = false;
                console.log(openItem.text);
            }
            background: Rectangle {
                color: Qt.rgba(1, 1, 1, 0)
                radius: 5
                border.color: Qt.rgba(1, 1, 1, 0)
                border.width: 1
            }
            Item {
                anchors.right: parent.right
                width: 30
                Text {
                    text: "F2 "
                    anchors.right: parent.right
                    color: "#4D365D"
                    font.pixelSize: 16
                    font.family: "Nunito"
                    font.weight: Font.Medium
                }
            }
        }

        MenuItem {
            id: settingsItem
            text: "Settings"
            font.pixelSize: 16
            font.family: "Nunito"
            font.weight: hovered ? Font.Bold : Font.Medium
            onTriggered: {
                console.log("Settings triggered");
                // Reset boldness when a menu item is triggered
                fileBold = false;
                viewBold = false;
                fileMenuOpen = false;
                console.log(settingsItem.text);
            }
            background: Rectangle {
                color: Qt.rgba(1, 1, 1, 0)
                radius: 5
                border.color: Qt.rgba(1, 1, 1, 0)
                border.width: 1
            }
            Item {
                anchors.right: parent.right
                width: 30
                Text {
                    text: "F3 "
                    anchors.right: parent.right
                    color: "#4D365D"
                    font.pixelSize: 16
                    font.family: "Nunito"
                    font.weight: Font.Medium
                }
            }
        }

        MenuItem {
            id: publishItem
            text: "Publish"
            font.pixelSize: 16
            font.family: "Nunito"
            font.weight: hovered ? Font.Bold : Font.Medium
            onTriggered: {
                console.log("Publish triggered");
                // Reset boldness when a menu item is triggered
                fileBold = false;
                viewBold = false;
                fileMenuOpen = false;
                console.log(publishItem.text);
            }
            background: Rectangle {
                color: Qt.rgba(1, 1, 1, 0)
                radius: 5
                border.color: Qt.rgba(1, 1, 1, 0)
                border.width: 1
            }
            Item {
                anchors.right: parent.right
                width: 30
                Text {
                    text: "F4 "
                    anchors.right: parent.right
                    color: "#4D365D"
                    font.pixelSize: 16
                    font.family: "Nunito"
                    font.weight: Font.Medium
                }
            }
        }
    }

    Menu {
        id: viewMenu
        visible: viewMenuOpen
        width: 220
        x: viewText.x - 2
        y: topBar.height + 5
        background: Rectangle {
            color: Qt.rgba(0.9, 0.8, 0.9, 1)
            border.color: Qt.rgba(1, 1, 1, 0)
            border.width: 1
            radius: 10
        }

        MenuItem {
            id: navigateItem
            text: "Navigate"
            font.pixelSize: 16
            font.family: "Nunito"
            font.weight: hovered ? Font.Bold : Font.Medium
            onTriggered: {
                console.log("Navigate triggered");
                // Reset boldness when a menu item is triggered
                fileBold = false;
                viewBold = false;
                viewMenuOpen = false;
                console.log(navigateItem.text);
            }
            background: Rectangle {
                color: Qt.rgba(1, 1, 1, 0)
                radius: 5
                border.color: Qt.rgba(1, 1, 1, 0)
                border.width: 1
            }
            Item {
                anchors.right: parent.right
                width: 30
                Text {
                    text: "F9 "
                    anchors.right: parent.right
                    color: "#4D365D"
                    font.pixelSize: 16
                    font.family: "Nunito"
                    font.weight: Font.Medium
                }
            }
        }

        MenuItem {
            id: pageItem
            text: "Page"
            font.pixelSize: 16
            font.family: "Nunito"
            font.weight: hovered ? Font.Bold : Font.Medium
            onTriggered: {
                console.log("Page triggered");
                // Reset boldness when a menu item is triggered
                fileBold = false;
                viewBold = false;
                viewMenuOpen = false;
                console.log(pageItem.text);
            }
            background: Rectangle {
                color: Qt.rgba(1, 1, 1, 0)
                radius: 5
                border.color: Qt.rgba(1, 1, 1, 0)
                border.width: 1
            }
            Item {
                anchors.right: parent.right
                width: 30
                Text {
                    text: "F10 "
                    anchors.right: parent.right
                    color: "#4D365D"
                    font.pixelSize: 16
                    font.family: "Nunito"
                    font.weight: Font.Medium
                }
            }
        }

        MenuItem {
            id: elementsItem
            text: "Elements"
            font.pixelSize: 16
            font.family: "Nunito"
            font.weight: hovered ? Font.Bold : Font.Medium
            onTriggered: {
                console.log("Elements triggered");
                // Reset boldness when a menu item is triggered
                fileBold = false;
                viewBold = false;
                viewMenuOpen = false;
                console.log(elementsItem.text);
            }
            background: Rectangle {
                color: Qt.rgba(1, 1, 1, 0)
                radius: 5
                border.color: Qt.rgba(1, 1, 1, 0)
                border.width: 1
            }
            Item {
                anchors.right: parent.right
                width: 30
                Text {
                    text: "F11 "
                    anchors.right: parent.right
                    color: "#4D365D"
                    font.pixelSize: 16
                    font.family: "Nunito"
                    font.weight: Font.Medium
                }
            }
        }

        MenuItem {
            id: detailsItem
            text: "Details"
            font.pixelSize: 16
            font.family: "Nunito"
            font.weight: hovered ? Font.Bold : Font.Medium
            onTriggered: {
                console.log("Details triggered");
                // Reset boldness when a menu item is triggered
                fileBold = false;
                viewBold = false;
                viewMenuOpen = false;
                console.log(detailsItem.text);
            }
            background: Rectangle {
                color: Qt.rgba(1, 1, 1, 0)
                radius: 5
                border.color: Qt.rgba(1, 1, 1, 0)
                border.width: 1
            }
            Item {
                anchors.right: parent.right
                width: 30
                Text {
                    text: "F12 "
                    anchors.right: parent.right
                    color: "#4D365D"
                    font.pixelSize: 16
                    font.family: "Nunito"
                    font.weight: Font.Medium
                }
            }
        }
    }
}