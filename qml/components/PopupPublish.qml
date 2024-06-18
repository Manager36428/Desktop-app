import QtQuick 2.0
import QtQuick.Controls 2.0
import QtWebEngine 1.0
import "../components"
import "../common"

Popup{
    id : popupPublish
    height: 1000
    width: 1400
    minimumHeight: height
    minimumWidth: width
    title: "Publish"

    content: Item {
        anchors.fill: parent

        Text {
            id : guideTxt
            text: "Preview your Pages on your computer before publishing on the Web"
            color: "#4D365D"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Nunito"
            font.weight: Font.DemiBold
            font.pixelSize: 16
            anchors{
                top: parent.top
                topMargin: 37
                left: parent.left
                leftMargin: 17
            }
        }

        ButtonText{
            id : btnPreview
            btnName: "Preview"
            height: 36
            width: 160
            anchors{
                top: parent.top
                right: parent.right
                topMargin: 28
                rightMargin: 15
            }
            onBtnClicked: {
                controller.generate_html()
            }
        }

        signal generated(var path);

        onGenerated: {
            console.log("[QML] Generated : " , path)
            webView.url = path
        }

        Component.onCompleted: {
            controller.generateDone.connect(generated)
        }

        Rectangle{
            id : webviewContainer
            anchors{
                top: btnPreview.bottom
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                margins: 10
            }
            WebEngineView {
                id : webView
                anchors.fill: parent
            }
        }
    }
}
