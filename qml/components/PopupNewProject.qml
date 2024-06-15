import QtQuick 2.0
import QtQuick.Controls 2.0
import "../components"
import "../common"

Popup{
    id: popupNewProject
    height: 135
    minimumHeight: height
    maximumHeight: height
    minimumWidth: width
    maximumWidth: width

    signal projectCreated(var projectName)

    content: Item{
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        TextField{
            id : tfProjectName
            height: 36
            anchors{
                top: parent.top
                topMargin: 23
                left: parent.left
                leftMargin: 13
                right: btnCreate.left
                rightMargin: 10
            }

            background: Rectangle{
                antialiasing: true
                color: "#FFFFFF"
                radius: 10
            }
            color: "#585D6C"
            font.pixelSize: 16
            font.family: "Nunito"
            wrapMode: Text.WordWrap
            verticalAlignment: Text.AlignTop
            placeholderText: "Project Name"
            placeholderTextColor: "#585D6C"
        }

        ButtonText{
            id : btnCreate
            btnName: "Create"
            height: 36
            width: 150
            anchors{
                top: parent.top
                right: parent.right
                topMargin: 23
                rightMargin: 13
            }
            onBtnClicked: {
                if(tfProjectName.text.length > 0){
                    projectCreated(tfProjectName.text)
                    popupNewProject.close()
                }
            }
        }
    }
}
