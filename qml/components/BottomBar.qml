import QtQuick 2.0
import "../common"
import "../../qml"

BaseCard {
    height: 78
    width: parent.width

    property var cards : []

    signal popupClicked(var popupId, var titlePopup)


    Image{
        height: 46
        width: 200
        anchors{
            left: parent.left
            leftMargin: 16
        }

        source: "qrc:/assets/img_logo.png"
        anchors.verticalCenter: parent.verticalCenter
    }

    function updateBottomButtons(btnIndex){
        bottomButtons.setProperty(btnIndex, "btn_active", false)
    }

    ListModel{
        ListElement{
            icon : "qrc:/assets/ic_new.png"
            text : "New"
            btn_active : false
        }
        ListElement{
            icon : "qrc:/assets/ic_open.png"
            text : "Open"
            btn_active : false
        }
        ListElement{
            icon : "qrc:/assets/ic_settings.png"
            text : "Settings"
            btn_active : false
        }
        ListElement{
            icon : "qrc:/assets/ic_publish.png"
            text : "Publish"
            btn_active : false
        }
        id : bottomButtons
    }

    ListModel{
        ListElement{
            icon : "qrc:/assets/ic_navigate.png"
            text : "Navigate"
        }
        ListElement{
            icon : "qrc:/assets/ic_page.png"
            text : "Page"
        }
        ListElement{
            icon : "qrc:/assets/ic_elements.png"
            text : "Elements"
        }
        ListElement{
            icon : "qrc:/assets/ic_details.png"
            text : "Details"
        }
        id : rightButtons
    }


    Row{
        spacing: 5
        height: 69
        width: childrenRect.width
        anchors.centerIn: parent
        z:2
        Repeater{
            model: bottomButtons
            delegate: IconButton{
                height: 69
                width: 69
                elementIcon: icon
                elementName: text
                isActive: btn_active
                onBtnClicked: {
                    bottomButtons.setProperty(index, "btn_active", true)
                    popupClicked(index, text)
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
