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

    Row{
        spacing: 5
        height: 69
        width: childrenRect.width
        anchors{
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 13
        }

        Repeater{
            model: rightButtons
            delegate: IconButton{
                height: 69
                width: 69
                elementIcon: icon
                elementName: text
                isActive: cards[index].isActive
                onBtnClicked: {
                    if(cards[index].isActive){
                        cards[index].changeToClosedState()
                    }else{
                        cards[index].changeToDockedState()
                    }
                }
            }
        }
    }

}
