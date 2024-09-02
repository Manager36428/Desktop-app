import QtQuick 2.12
import QtQuick.Window 2.12
import "qml/components"
import "qml/cards"
import "qml/dragdrop"

MainWindow {
    id : windowRoot
    visible: true
    minimumHeight: 1008
    minimumWidth: 1025
    title: qsTr("Flowsta Page Builder") + projectName
    property var currentPopup: undefined
    property string projectName: ""
    property alias dragCenter: dragerCenter

    GDragerCenter{
        id : dragerCenter
    }

    onClosing:{
        currentPopup.close();
    }

    function removePopup(popup_id){
        console.log("Remove Popup, ", popup_id)
        bottomBar.updateBottomButtons(popup_id)
        currentPopup = undefined
    }

    function handleProjectCreated(project_name){
        console.log("Project Created :" + project_name);
        projectName = " : " + project_name
        controller.project_name = project_name
        controller.create_new_project()
    }

    function showPopup(popup_id, title) {
        console.log("Create Popup:", popup_id)

        // Check if the current popup is already open and matches the requested popup
        if (currentPopup !== undefined && currentPopup.popupId === popup_id) {
            // If the same popup is open, close it and reset `currentPopup`
            currentPopup.close();
            currentPopup = undefined;
            return;  // Exit the function since the popup was closed
        }

        // Close any other open popup
        if (currentPopup !== undefined) {
            bottomBar.updateBottomButtons(currentPopup.popupId)
            currentPopup.close();
        }

        var pathPopup = "qrc:/qml/components/Popup.qml";
        if (popup_id === 0) {
            title = "Create a New Project";
            pathPopup = "qrc:/qml/components/PopupNewProject.qml";
        } else if (popup_id === 3) {
            title = "Publish";
            controller.set_viewport_size(pageCard.viewport.height, pageCard.viewport.width);
            pathPopup = "qrc:/qml/components/PopupPublish.qml";
        } else if (popup_id === 2)
        {
            pathPopup = "qrc:/qml/components/PopupSettings.qml";
        }

        var component = Qt.createComponent(pathPopup);

        if (component.status === Component.Ready) {
            var window = component.createObject(null);
            if (window !== null) {
                currentPopup = window;
                window.popupId = popup_id;
                window.popupDestroyed.connect(removePopup);
                if (popup_id === 0) {
                    window.projectCreated.connect(handleProjectCreated);
                }

                window.title = title;
                window.show();
            } else {
                console.log("Error: Could not create window.");
            }
        } else {
            console.log("Error: Component not ready.");
        }
    }

    function handleKeyMenu(key)
    {
        console.log("HandleKeyMenu :", key === Qt.Key_F1);
        switch(key){
        case Qt.Key_F1:
            bottomBar.toggleBottomButtons(0, "New")
            break;
        case Qt.Key_F2:
            bottomBar.toggleBottomButtons(1, "Open")
            break;
        case Qt.Key_F3:
            bottomBar.toggleBottomButtons(2, "Settings")
            break;
        case Qt.Key_F4:
            bottomBar.toggleBottomButtons(3, "Publish")
            break;
        case Qt.Key_F9:
            bottomBar.toggleCards(0)
            break;
        case Qt.Key_F10:
            bottomBar.toggleCards(1)
            break;
        case Qt.Key_F11:
            bottomBar.toggleCards(2)
            break;
        case Qt.Key_F12:
            bottomBar.toggleCards(3)
            break;
        }
    }

    Keys.onPressed: {
        console.log("HandleKeyMenu :", event.key);
        handleKeyMenu(event.key)
    }


    Connections{
        target : controller

        function onKeyPressed(key){
            console.log("HandleKeyMenu :", key);
            handleKeyMenu(key)
        }
    }

    content: Item {
        anchors.fill: parent        
        TopBar{
            z:100
            id : topBar
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: 8
            }
            height: 31

            onMenuItemClicked: {
                console.log(event_key);
                switch(event_key){
                case "New":
                    bottomBar.toggleBottomButtons(0, "New")
                    break;
                case "Open":
                    bottomBar.toggleBottomButtons(1, "Open")
                    break;
                case "Settings":
                    bottomBar.toggleBottomButtons(2, "Settings")
                    break;
                case "Publish":
                    bottomBar.toggleBottomButtons(3, "Publish")
                    break;
                case "Navigate":
                    bottomBar.toggleCards(0)
                    break;
                case "Page":
                    bottomBar.toggleCards(1)
                    break;
                case "Elements":
                    bottomBar.toggleCards(2)
                    break;
                case "Details":
                    bottomBar.toggleCards(3)
                    break;
                default:
                    console.log("Ignore Menu : ", event_key);
                }
            }
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

            onModeChanged: {
                if(!detailsCard.isDocked){
                    navCard.anchors.bottom = bottomBar.top
                }else{
                    //Reset Navigation Card height
                    navCard.heightDock = 308
                    navCard.height = 308
                    navCard.anchors.bottom = undefined
                }
            }

            anchors{
                top: topBar.bottom
                left: parent.left
                bottom: detailsCard.isDocked ? undefined  : bottomBar.top
                topMargin: 16
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
                topMargin: navCard.isDocked ? 8 : 16
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
                topMargin: 16
            }

            onModeChanged: {
                if(!pageCard.isDocked){
                    elementsCard.anchors.bottom = bottomBar.top
                }else{
                    //Reset Element Card height
                    elementsCard.heightDock = 263
                    elementsCard.height = 263
                    elementsCard.anchors.bottom = undefined
                }
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
                topMargin: elementsCard.isDocked ? 8 : 16
            }
        }

    }

    onHeightChanged: console.log("Window Root  H : ", height)
    onWidthChanged: console.log("Window Root W: " , width)
}
