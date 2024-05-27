import QtQuick 2.12
import QtQuick.Window 2.12
import "qml/components"
import "qml/cards"

Window {
    id : windowRoot
    visible: true
    minimumHeight: 945
    minimumWidth: 930
    title: qsTr("FlowSta")

    Image{
        anchors.fill: parent
        source: "qrc:/assets/img_bg.jpg"
    }

    TopBar{
        id : topBar
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: 8
        }
        height: 31
    }

    BottomBar{
        id : bottomBar
        anchors{
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            margins: 8
        }
    }

    NavigateCard{
        id : navCard
        heightDock: 308
        widthDock: 300
        anchors{
            top: topBar.bottom
            left: parent.left
            topMargin: 8
            leftMargin: 8
        }
        z:1
    }

    DetailsCard{
        id : detailsCard
        width: 300
        anchors{
            top: navCard.bottom
            bottom: bottomBar.top
            left: parent.left
            margins: 8
        }
    }

    ElementsCard{
        id : elementsCard
        heightDock: 263
        anchors{
            top: topBar.bottom
            left: navCard.right
            right: parent.right
            margins: 8
        }
    }

    PageCard{
        id : pageCard
        anchors {
            top: elementsCard.bottom
            bottom: bottomBar.top
            left: detailsCard.right
            right: parent.right
            margins: 8
        }
    }


    onHeightChanged: console.log("Window Root  H : ", height)
    onWidthChanged: console.log("Window Root W: " , width)
}
