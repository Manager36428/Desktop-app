import QtQuick 2.0
import QtQml 2.0

ResizableItem {
    height: 200
    width: 200
    property string video_source: ""

    function getYouTubeVideoId(url) {
        const regExp = /^.*(youtu\.be\/|v\/|e\/|u\/\w+\/|embed\/|v=)([^#\&\?]*).*/;
        const match = url.match(regExp);

        if (match && match[2]) {
            return match[2];
        } else {
            console.error('Invalid YouTube URL');
            return "";
        }
    }

    function get_html(){
        let emb_link = getYouTubeVideoId(video_source)
        let html = `<iframe style="width: 100%; height: 100%" frameborder="0" allowfullscreen src="https://www.youtube.com/embed/${emb_link}"> </iframe>`
        return html
    }

    content: Item{
        anchors.fill: parent
        Image{
            id : video
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: "qrc:/assets/img_video-placeholder.jpg"        
        }

        MouseArea{
            anchors.fill: parent
            onClicked: video.stop()
        }
    }

    onItem_idChanged: {
        element_tag = "video_" + item_id
    }
}
