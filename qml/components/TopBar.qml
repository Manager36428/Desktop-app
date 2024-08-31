import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../../qml"
import "../common/menu"

Rectangle {
    width: 400
    height: 300
    color: "transparent"
    radius: 10

    property bool fileBold: false
    property bool fileMenuOpen: false
    property bool viewBold: false
    property bool viewMenuOpen: false

    signal menuItemClicked(var event_key);

    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
    }

    Rectangle {
        id: topBar
        width: parent.width
        height: 40
        gradient: Gradient {
            GradientStop { position: 1.0; color: Qt.rgba(0.6549, 0.6157, 0.6509, 0.55) }
            GradientStop { position: 0.0; color: Qt.rgba(0.8275, 0.7922, 0.8275, 0.55) }
        }
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

    DropShadow {
        anchors.fill: fileMenu
        horizontalOffset: 4
        verticalOffset: 4
        radius: 8.0
        samples: 17
        color: "#800000"
        opacity: 0.25
        source: fileMenu
        visible: fileMenuOpen
    }

    Rectangle {
        id: fileMenu
        visible: fileMenuOpen
        x: fileText.x - 2
        y: topBar.height + 5
        gradient: Gradient{
            GradientStop{ color: "#A79DA6"; position: 1.0}
            GradientStop{ color: "#D3CAD3"; position: 0.0}
        }
        radius: 10
        height: 117
        width: 220

        Column{
            height: parent.height - 12
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2

            MenuItemText{
                menu_item_name: "New"
                menu_item_shortcut: "F1"

                onClicked: {
                    console.log("New triggered");
                    // Reset boldness when a menu item is triggered
                    fileBold = false;
                    viewBold = false;
                    fileMenuOpen = false;
                    menuItemClicked("New");
                }
            }

            MenuItemText {
                id: openItem
                menu_item_name: "Open"
                menu_item_shortcut: "F2"
                onClicked: {
                    console.log("Open triggered");
                    // Reset boldness when a menu item is triggered
                    fileBold = false;
                    viewBold = false;
                    fileMenuOpen = false;
                    menuItemClicked("Open");
                }
            }

            MenuItemText {
                id: settingsItem
                menu_item_name: "Settings"
                menu_item_shortcut: "F3"
                onClicked: {
                    console.log("Settings triggered");
                    // Reset boldness when a menu item is triggered
                    fileBold = false;
                    viewBold = false;
                    fileMenuOpen = false;
                    menuItemClicked("Settings");
                }
            }

            MenuItemText {
                id: publishItem
                menu_item_name: "Publish"
                menu_item_shortcut: "F4"
                onClicked: {
                    console.log("Publish triggered");
                    // Reset boldness when a menu item is triggered
                    fileBold = false;
                    viewBold = false;
                    fileMenuOpen = false;
                    menuItemClicked("Publish");
                }
            }
        }
    }


    DropShadow {
        anchors.fill: viewMenu
        horizontalOffset: 4
        verticalOffset: 4
        radius: 8.0
        samples: 17
        color: "#800000"
        opacity: 0.25
        source: viewMenu
        visible: viewMenuOpen
    }

    Rectangle {
        id: viewMenu
        visible: viewMenuOpen
        x: viewText.x - 2
        y: topBar.height + 5
        gradient: Gradient{
            GradientStop{ color: "#A79DA6"; position: 1.0}
            GradientStop{ color: "#D3CAD3"; position: 0.0}
        }
        radius: 10
        height: 117
        width: 220

        Column{
            height: parent.height - 12
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2

            MenuItemText{
                menu_item_name: "Navigate"
                menu_item_shortcut: "F9"

                onClicked: {
                    console.log("Navigate triggered");
                    // Reset boldness when a menu item is triggered
                    fileBold = false;
                    viewBold = false;
                    viewMenuOpen = false;
                    menuItemClicked("Navigate");
                }
            }

            MenuItemText{
                menu_item_name: "Page"
                menu_item_shortcut: "F10"

                onClicked: {
                    console.log("Page triggered");
                    // Reset boldness when a menu item is triggered
                    fileBold = false;
                    viewBold = false;
                    viewMenuOpen = false;
                    menuItemClicked("Page");
                }
            }

            MenuItemText{
                menu_item_name: "Elements"
                menu_item_shortcut: "F11"

                onClicked: {
                    console.log("Elements triggered");
                    // Reset boldness when a menu item is triggered
                    fileBold = false;
                    viewBold = false;
                    viewMenuOpen = false;
                    menuItemClicked("Elements");
                }
            }

            MenuItemText{
                menu_item_name: "Details"
                menu_item_shortcut: "F12"

                onClicked: {
                    console.log("Details triggered");
                    // Reset boldness when a menu item is triggered
                    fileBold = false;
                    viewBold = false;
                    viewMenuOpen = false;
                    menuItemClicked("Details");
                }
            }

        }

    }
}
