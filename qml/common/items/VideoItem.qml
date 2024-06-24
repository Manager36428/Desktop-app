import QtQuick 2.0
import QtQml 2.0

ResizableItem {
    height: 200
    width: 200
    property string video_source: ""

    content: Item{
        anchors.fill: parent
        Image{
            id : video
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: "qrc:/assets/img_video-placeholder.jpg"
            Component.onCompleted: video.play()            
        }

        MouseArea{
            anchors.fill: parent
            onClicked: video.stop()
        }
    }

    Component.onDestruction: video.stop()
}
