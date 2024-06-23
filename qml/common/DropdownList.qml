import QtQuick 2.0

Item {
    id : root
    height: 60
    width: 282
    property int currentIdx: 0

    signal valueUpdated(var tag_value)

    function getTextAtIdx(idx){
        let tag = headingList.get(idx).tag;
        let text = headingList.get(idx).text
        return "<" + tag + ">" + text +"</" + tag + ">"
    }

    function setIndexByTag(tag){
        for(var i=0;i<headingList.count;i++){
            if(headingList.get(i).tag == tag){
                console.log("Update Index : ",i);
                currentIdx = i;
            }
        }
    }

    onCurrentIdxChanged: valueUpdated(headingList.get(currentIdx).tag)

    ListModel{
        id : headingList
        ListElement{
            text: "Heading 1"
            tag :"h1"
        }

        ListElement{
            text: "Heading 2"
            tag :"h2"
        }

        ListElement{
            text: "Heading 3"
            tag :"h3"
        }

        ListElement{
            text: "Heading 4"
            tag :"h4"
        }

        ListElement{
            text: "Heading 5"
            tag :"h5"
        }

        ListElement{
            text: "Heading 6"
            tag :"h6"
        }
    }

    Text{
        id :header
        height: 16
        font.pixelSize: 16
        font.weight: Font.DemiBold
        width: parent.width
        text : "Heading Type"
        color: "#4D365D"
        font.family: "Nunito"
    }

    Rectangle{
        color: "white"
        radius: 10
        height: 36
        width: parent.width
        anchors.bottom: parent.bottom
        Text{
            color: "#585D6C"
            height: 16
            font.family: "Nunito"
            font.pixelSize: 16
            anchors{
                top: header.bottom
                topMargin: 8
                left: parent.left
                right: btnArrDown.left
                margins: 13
                verticalCenter: parent.verticalCenter
            }
            text: headingList.get(currentIdx).text
        }

        Icon{
            id : btnArrDown
            source: "qrc:/assets/ic_arrow_down_circle.png"
            height: 20
            width: 20
            anchors{
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: 8
            }

            onBtnClicked:{
                console.log("Show Dropdownlist")
                dropListContainer.visible = !dropListContainer.visible
            }
        }

    }

    Rectangle{
        height: 175
        width: parent.width
        color:  "white"
        radius: 10
        visible: false
        id : dropListContainer
        anchors{
            top: parent.bottom
            topMargin: 7
        }

        ListView{
            height: 242
            width: parent.width
            model: headingList
            spacing : 10
            clip: true
            header: Item{
                height: 10
                width: parent.width
            }

            delegate: Item{
                height: 16
                width: parent.width

                Text{
                    color: "#585D6C"
                    height: 16
                    width: parent.width
                    font.family: "Nunito"
                    font.pixelSize: 16
                    anchors{
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        right: parent.right
                        margins: 13

                    }
                    font.bold: currentIdx == index
                    text: headingList.get(index).text
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            dropListContainer.visible = false
                            currentIdx = index
                        }
                    }
                }
            }
        }
    }
}
