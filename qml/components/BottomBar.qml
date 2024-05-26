import QtQuick 2.0
import "../common"

Item {
    height: 78
    width: parent.width

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

    ListModel{
        ListElement{
            icon : "qrc:/assets/ic_new.png"
            text : "New"
        }
        ListElement{
            icon : "qrc:/assets/ic_open.png"
            text : "Open"
        }
        ListElement{
            icon : "qrc:/assets/ic_settings.png"
            text : "Settings"
        }
        ListElement{
            icon : "qrc:/assets/ic_publish.png"
            text : "Publish"
        }
        id : bottomButtons
    }

    ListModel{
        ListElement{
            icon : "qrc:/assets/ic_navigate.png"
            text : "Navigate"
            btn_active  : true
        }
        ListElement{
            icon : "qrc:/assets/ic_page.png"
            text : "Page"
            btn_active  : true
        }
        ListElement{
            icon : "qrc:/assets/ic_elements.png"
            text : "Elements"
            btn_active  : true
        }
        ListElement{
            icon : "qrc:/assets/ic_details.png"
            text : "Details"
            btn_active  : false
        }
        id : rightButtons
    }


    Row{
        spacing: 5
        height: 69
        width: childrenRect.width
        anchors.centerIn: parent
        Repeater{
            model: bottomButtons
            delegate: IconButton{
                height: 69
                width: 69
                elementIcon: icon
                elementName: text
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
                isActive: btn_active
            }
        }
    }

}
