import QtQuick 2.0
import "../common"
import "../components"

Item{
    id : detailContent
    anchors.fill: parent
    property var currentPage: controller.current_page
    onCurrentPageChanged: detailCard.title = currentPage != undefined ? "Details" + " : " + currentPage.page_name : "Details"

    Row{
        id : detailType
        height: 36
        spacing: 6
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
            margins: 10
            topMargin: isDocked ? 54 : 24
        }

        ButtonText{
            btnName: "Page"
            isActive: contentLoader.source == "qrc:/qml/cards/ContentPage.qml"
            width: parent.width/2 - 3
        }

        ButtonText{
            btnName: "Element"
            width: parent.width/2 - 3
            isActive: contentLoader.source != "qrc:/qml/cards/ContentPage.qml"
        }
    }

    Item{
        anchors{
            top: detailType.bottom
            bottom: parent.bottom
            bottomMargin: 17
            topMargin: 15
            left: parent.left
            right: parent.right
            leftMargin: 11
            rightMargin: 7
        }

        Loader{
            id : contentLoader
            anchors.fill: parent
            source: getSource()

            active: true

            Component.onCompleted: source = getSource()

            onLoaded: {
                console.log("Loaded update_content")
                contentLoader.item.update_content(currentPage.current_element)
            }

            function getSource(){
                console.log("Get Source : " + currentPage.current_element_id )
                if(currentPage.current_element_id == 0){
                    console.log("[Content Page]")
                    return "qrc:/qml/cards/ContentPage.qml"
                }else{
                    let compName = currentPage.current_element.objectName;
                    let path = "qrc:/qml/cards/Content"+ compName+ ".qml"
                    console.log("[Content Element] " + path)
                    return path
                }
            }

            Connections{
                target: controller.current_page
                onCurrentElementIdChanged :{
                    console.log("New Id : ", currentPage.current_element_id)
                    contentLoader.source = contentLoader.getSource()
                }
            }
        }
    }
}
