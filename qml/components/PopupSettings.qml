import QtQuick 2.0
import QtQuick.Controls 2.0
import "../components"
import "../common"

Popup{
    id : popupSettings
    height: 500
    width: 720
    minimumHeight: height
    minimumWidth: width
    title: "Settings"

    content: Item {
        anchors.fill: parent

        Row{
            id : projectInfoContainer
            height: 61
            spacing: 12
            anchors{
                top: parent.top
                topMargin: 25
                left: parent.left
                right: parent.right
                margins: 11
            }

            TextFieldTitle{
                id : tfProjectName
                height: 61
                width: parent.width / 2 - 6
                title: "Project Name"
                content.placeholderText: "Project Name"
                content.text: ""
                anchors{
                    top: parent.top
                }
                content.onTextChanged: {
                    detailContent.currentPage.page_name = content.text
                }
            }

            TextFieldTitle{
                id : tfPageTitle
                height: 61
                width: parent.width / 2 - 6
                title: "Page Title"
                content.placeholderText: "Page Title"
                content.text: ""
                anchors{
                    top: parent.top
                }
                content.onTextChanged: {
                    detailContent.currentPage.page_name = content.text
                }
            }
        }

        NumberSelector{
            id : numberSelector
            title: "Default Text Size"

            anchors{
                top: projectInfoContainer.bottom
                left: parent.left
                leftMargin: 11
                topMargin: 21
            }

            height: 62
            width: 62
            z:2
            anchors{
                top : tfTitle.bottom
                topMargin: tfTitle.content.height - 50
                right: parent.right
                rightMargin: 70
            }
        }

        Text{
            id :headingSizeTitle
            height: 16
            font.pixelSize: 16
            font.weight: Font.DemiBold
            width: parent.width
            text : "Heading Sizes"
            color: "#4D365D"
            font.family: "Nunito"

            anchors{
                top: numberSelector.bottom
                topMargin: 21
                left: parent.left
                leftMargin: 11
            }
        }

        Row{

            height: 36
            width: parent.width
            spacing: 22

            anchors{
                top: headingSizeTitle.bottom
                topMargin: 9
                left: parent.left
                leftMargin: 11
            }

            anchors{
                top: numberSelector.bottom
                topMargin: 21
                left: parent.left
                leftMargin: 11
            }

            Repeater{
                model: 6
                NumberSelectorHeader{
                    title : "H" + (index +1)
                    // Reverse z order.
                    z: 6 - index
                    // Remove offset incase of last item.
                    offsetPopup: index == 5 ? -90 : 17
                }
            }
        }
    }
}
