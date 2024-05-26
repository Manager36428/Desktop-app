import QtQuick 2.12
import QtQuick.Window 2.12
import "qml/components"
import "qml/cards"

Window {
    id : windowRoot
    visible: true
    width: 1388
    height: 980
    minimumHeight: 840
    minimumWidth: 1008
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
            margins: 8
        }
    }

    NavigateCard{
        id : navCard
        height: 323
        width: 300
        anchors{
            top: topBar.bottom
            left: parent.left
            topMargin: 9
            leftMargin: 8
        }
    }

    DetailsCard{
        id : detailsCard
        title: "Details"
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
        title: "Elements"
        height: 263
        anchors{
            top: topBar.bottom
            left: navCard.right
            right: parent.right
            margins: 8
        }
    }

    PageCard{
        id : pageCard
        title: "Page"
        anchors {
            top: elementsCard.bottom
            bottom: bottomBar.top
            left: detailsCard.right
            right: parent.right
            margins: 8
        }
    }


    onHeightChanged: printDebugInfo()
    onWidthChanged: printDebugInfo()

    function printDebugInfo(){
        console.log("H ", windowRoot.height)
        console.log("W ", windowRoot.width)
    }
}
