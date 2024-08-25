import QtQuick 2.0
import "../common"
import "../../qml"

BaseCard {
    height: 78
    width: parent.width

    property var cards: []

    signal popupClicked(var popupId, var titlePopup)

    Image {
        height: 46
        width: 200
        anchors {
            left: parent.left
            leftMargin: 16
            verticalCenter: parent.verticalCenter
        }
        source: "qrc:/assets/img_logo.png"
    }

    function updateBottomButtons(btnIndex) {
        bottomButtons.setProperty(btnIndex, "btn_active", false)
    }

    ListModel {
        ListElement {
            icon: "qrc:/assets/ic_new.png"
            text: "New"
            btn_active: false
        }
        ListElement {
            icon: "qrc:/assets/ic_open.png"
            text: "Open"
            btn_active: false
        }
        ListElement {
            icon: "qrc:/assets/ic_settings.png"
            text: "Settings"
            btn_active: false
        }
        ListElement {
            icon: "qrc:/assets/ic_publish.png"
            text: "Publish"
            btn_active: false
        }
        id: bottomButtons
    }

    ListModel {
        ListElement {
            icon: "qrc:/assets/ic_navigate.png"
            text: "Navigate"
        }
        ListElement {
            icon: "qrc:/assets/ic_page.png"
            text: "Page"
        }
        ListElement {
            icon: "qrc:/assets/ic_elements.png"
            text: "Elements"
        }
        ListElement {
            icon: "qrc:/assets/ic_details.png"
            text: "Details"
        }
        id: rightButtons
    }

    Row {
        spacing: 5
        height: 69
        width: childrenRect.width
        anchors.centerIn: parent
        z: 2

        Repeater {
            model: bottomButtons
            delegate: IconButton {
                height: 69
                width: 69
                elementIcon: model.icon
                elementName: model.text
                isActive: model.btn_active

                onBtnClicked: {
                    if (model.btn_active) {
                        // If the clicked button is already active, reset all buttons
                        popupClicked(index, text)
                        for (var i = 0; i < bottomButtons.count; i++) {
                            bottomButtons.set(i, { "btn_active": false });
                        }
                    } else {
                        // Reset all and activate the clicked one
                        popupClicked(index, text)
                        for (var i = 0; i < bottomButtons.count; i++) {
                            bottomButtons.set(i, { "btn_active": false });
                        }
                        bottomButtons.set(index, { "btn_active": true });
                    }
                }
            }
        }
    }

    Row {
        spacing: 5
        height: 69
        width: childrenRect.width
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 13
        }

        Repeater {
            model: rightButtons
            delegate: IconButton {
                height: 69
                width: 69
                elementIcon: icon
                elementName: text
                isActive: cards[index].isActive
                onBtnClicked: {
                    if (cards[index].isActive) {
                        cards[index].changeToClosedState()
                    } else {
                        cards[index].changeToDockedState()
                    }
                }
            }
        }
    }

    // Ensure the keyboard input is captured
    FocusScope {
        focus: true   // Ensure that this FocusScope can receive focus

        Keys.onPressed: {
            switch (event.key) {
            case Qt.Key_F1:
                triggerButton(0);  // Trigger 'New' button
                break;
            case Qt.Key_F2:
                triggerButton(1);  // Trigger 'Open' button
                break;
            case Qt.Key_F3:
                triggerButton(2);  // Trigger 'Settings' button
                break;
            case Qt.Key_F4:
                triggerButton(3);  // Trigger 'Publish' button
                break;
            case Qt.Key_F9:
                triggerRightButton(0);  // Trigger 'Navigate' button
                break;
            case Qt.Key_F10:
                triggerRightButton(1);  // Trigger 'Page' button
                break;
            case Qt.Key_F11:
                triggerRightButton(2);  // Trigger 'Elements' button
                break;
            case Qt.Key_F12:
                triggerRightButton(3);  // Trigger 'Details' button
                break;
            }
            event.accept();  // Accept the event to prevent further propagation
        }

        // Function to trigger bottom button based on index
        function triggerButton(index) {
            if (index >= 0 && index < bottomButtons.count) {
                var btn = bottomButtons.get(index);
                if (btn.btn_active) {
                    popupClicked(index, btn.text);
                    for (var i = 0; i < bottomButtons.count; i++) {
                        bottomButtons.set(i, { "btn_active": false });
                    }
                } else {
                    popupClicked(index, btn.text);
                    for (var i = 0; i < bottomButtons.count; i++) {
                        bottomButtons.set(i, { "btn_active": false });
                    }
                    bottomButtons.set(index, { "btn_active": true });
                }
            }
        }

        // Function to trigger right button based on index
        function triggerRightButton(index) {
            if (index >= 0 && index < rightButtons.count) {
                var btn = cards[index];
                if (btn.isActive) {
                    btn.changeToClosedState();
                } else {
                    btn.changeToDockedState();
                }
            }
        }
    }
}
