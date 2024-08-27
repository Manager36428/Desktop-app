import QtQuick 2.0
import QtQml 2.0

ResizableItem {
    height: 200
    width: 356 // 16:9 aspect ratio (200 * 16 / 9)
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

    function get_html() {
        let emb_link = getYouTubeVideoId(video_source);

        let html = `
        <style>
            .grid-container {
                display: grid;
                place-items: center;
                width: 100%;
                height: 100%;
                background-color: transparent;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }
            .video-frame {
                width: 100%;
                height: 100%;
                border: none;
                grid-area: 1 / 1;
                object-fit: cover;
            }
            /* Remove hover zoom effect */
        </style>
        <div class="grid-container">
            <iframe class="video-frame" src="https://www.youtube.com/embed/${emb_link}" allowfullscreen></iframe>
        </div>`;
        return html;
    }

    content: Item {
        anchors.fill: parent
        Image {
            id: video
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: "qrc:/assets/img_video-placeholder.jpg"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: video.stop()
        }
    }

    onItem_idChanged: {
        element_tag = "video_" + item_id
    }
}
