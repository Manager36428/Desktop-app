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

    property string name_updating: ""
    property string title_updating: ""
    property int textsize_updating: 0
    property var heading_sizes_updating: []

    function save_checkpoint()
    {
        name_updating     = settings.project_name
        title_updating    = settings.project_title
        textsize_updating = settings.default_text_size
        for(var i=0;i<6;i++)
        {
            heading_sizes_updating.push(settings.get_heading_size_at(i))
        }
    }

    function restore_checkpoint()
    {
        settings.project_name       = name_updating
        settings.project_title      = title_updating
        settings.default_text_size  = textsize_updating
        for(var i=0;i<6;i++)
        {
            settings.set_heading_size_at(i,heading_sizes_updating[i])
        }
    }

    Component.onCompleted: save_checkpoint()

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
                content.text: settings.project_name
                anchors{
                    top: parent.top
                }
                content.onTextChanged: {
                    settings.project_name = content.text
                }
            }

            TextFieldTitle{
                id : tfPageTitle
                height: 61
                width: parent.width / 2 - 6
                title: "Page Title"
                content.placeholderText: "Page Title"
                content.text: settings.project_title
                anchors{
                    top: parent.top
                }
                content.onTextChanged: {
                    settings.project_title = content.text
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
            Component.onCompleted: updateValue(settings.default_text_size)
            onValueUpdated: settings.default_text_size = getValue()
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
                    Component.onCompleted: updateValue(settings.get_heading_size_at(index))
                    onValueUpdated: settings.set_heading_size_at(index, getValue())
                }
            }
        }

        Item{
            height: 36
            width: 258
            anchors{
                bottom: parent.bottom
                right: parent.right
                rightMargin: 11
                bottomMargin: 25
            }

            Row{
                anchors.fill: parent
                spacing: 18
                ButtonText{
                    id : btnOk
                    btnName: "Ok"
                    height: 36
                    width: 120
                    onBtnClicked: {
                        popupSettings.close()
                    }
                }

                ButtonText{
                    id : btnCancel
                    btnName: "Cancel"
                    height: 36
                    width: 120
                    onBtnClicked: {
                        restore_checkpoint()
                        popupSettings.close()
                    }
                }
            }

        }
    }
}
