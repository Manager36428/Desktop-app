import QtQuick 2.0
import QtMultimedia 5.12
import QtQml 2.0

ResizableItem {
    height: 200
    width: 200
    property string video_source: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"

    content: Item{
        anchors.fill: parent
        Video{
            id : video
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: video_source
            Component.onCompleted: video.play()            
        }

        MouseArea{
            anchors.fill: parent
            onClicked: video.stop()
        }
    }

    Component.onDestruction: video.stop()
}
