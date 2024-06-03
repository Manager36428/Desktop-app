import QtQuick 2.12
import QtQuick.Window 2.12
import "qml/components"
import "qml/cards"

MainWindow {
    id : windowRoot
    visible: true
    minimumHeight: 1008
    minimumWidth: 1025
    title: qsTr("Flowsta Creator App")
    property var popupIds: []

    function removePopup(popup_id){
        var arrIds = windowRoot.popupIds
        console.log("Array Ids: " , arrIds)
        console.log("Remove Popup: ", popup_id)
        let index = arrIds.indexOf(popup_id);
        console.log("Remove Popup Idx: ", index)
        if (index !== -1) {
            arrIds.splice(index, 1);
            bottomBar.updateBottomButtons(popup_id)
            popupIds = arrIds
        }        
    }


    function showPopup(popup_id, title) {
        console.log("Create Popup:", popup_id)
        if(popupIds.indexOf(popup_id) == -1)
        {
            var arrIds = windowRoot.popupIds
            arrIds.push(popup_id)
            windowRoot.popupIds = arrIds
            console.log("array Id : ", windowRoot.popupIds)
            var component = Qt.createComponent("qrc:/qml/components/Popup.qml");

            if (component.status === Component.Ready) {
                var window = component.createObject(null);
                if (window !== null) {
                    window.popupId = popup_id
                    window.popupDestroyed.connect(removePopup)
                    window.title = title                    
                    window.show();


                } else {
                    console.log("Error: Could not create window.");
                }
            } else {
                console.log("Error: Component not ready.");
            }            
        }
    }

    content: Item {
        anchors.fill: parent
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
            cards: [navCard, pageCard, elementsCard, detailsCard]
            onPopupClicked: showPopup(popupId, titlePopup)
        }

        NavigateCard{
            id : navCard
            heightDock: 300
            widthDock: 300
            heightInit: 420
            widthInit: 300

            anchors{
                top: topBar.bottom
                left: parent.left
                bottom: detailsCard.isDocked ? undefined  : bottomBar.top
                topMargin: 8
                leftMargin: 8
                bottomMargin: 8
            }
            z:1

        }

        DetailsCard{
            id : detailsCard
            width: 300
            onModeChanged: {
                if(!detailsCard.isDocked){
                    navCard.anchors.bottom = undefined
                    navCard.heightDock = 308
                    navCard.height = 308
                }else{
                    navCard.anchors.bottom = bottomBar.top
                }
            }

            anchors{
                top: navCard.isDocked ? navCard.bottom : topBar.bottom
                bottom: bottomBar.top
                left: parent.left
                margins: 8
            }
        }

        ElementsCard{
            id : elementsCard
            heightDock: 263
            widthDock: 720
            widthInit: 720
            heightInit: 420
            anchors{
                top: topBar.bottom
                left: navCard.right
                right: parent.right
                bottom: pageCard.isDocked ? undefined : bottomBar.top
                margins: 8
            }
        }

        PageCard{
            id : pageCard
            onModeChanged: {
                if(!pageCard.isDocked)
                {
                    elementsCard.anchors.bottom = undefined
                    elementsCard.height = 263
                    elementsCard.heightDock = 263
                }else{
                    elementsCard.anchors.bottom = bottomBar.top
                }
            }

            anchors {
                top: elementsCard.isDocked ? elementsCard.bottom : topBar.bottom
                bottom: bottomBar.top
                left: detailsCard.right
                right: parent.right
                margins: 8
            }
        }

    }

    onHeightChanged: console.log("Window Root  H : ", height)
    onWidthChanged: console.log("Window Root W: " , width)
}
