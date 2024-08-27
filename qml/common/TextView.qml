import QtQuick 2.0

Item {
    id: root
    height: 60
    width: 282
    property int currentIdx: 0

    signal valueUpdated(var size_value)

    function getTextAtIdx(idx) {
        let size = sizeList.get(idx).size;
        return size + " px";
    }

    function setIndexBySize(size) {
        for (var i = 0; i < sizeList.count; i++) {
            if (sizeList.get(i).size == size) {
                console.log("Update Index:", i);
                currentIdx = i;
            }
        }
    }

    onCurrentIdxChanged: valueUpdated(sizeList.get(currentIdx).size)

    ListModel {
        id: sizeList
        ListElement {
            size: 12
        }

        ListElement {
            size: 14
        }

        ListElement {
            size: 16
        }

        ListElement {
            size: 18
        }

        ListElement {
            size: 20
        }

        ListElement {
            size: 24
        }
    }

    Text {
        id: header
        height: 16
        font.pixelSize: 16
        font.weight: Font.DemiBold
        width: parent.width
        text: "Text Size"
        color: "#4D365D"
        font.family: "Nunito"
    }

    Rectangle {
        color: "white"
        radius: 10
        height: 36
        width: parent.width
        anchors.bottom: parent.bottom

        Text {
            color: "#585D6C"
            height: 16
            font.family: "Nunito"
            font.pixelSize: 16
            anchors {
                top: header.bottom
                topMargin: 8
                left: parent.left
                right: btnArrDown.left
                margins: 13
                verticalCenter: parent.verticalCenter
            }
            text: sizeList.get(currentIdx).size + " px"
        }

        Icon {
            id: btnArrDown
            source: "qrc:/assets/ic_arrow_down_circle.png"
            height: 20
            width: 20
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: 8
            }

            onBtnClicked: {
                console.log("Show Dropdownlist")
                dropListContainer.visible = !dropListContainer.visible
            }
        }
    }

    Rectangle {
        height: 175
        width: parent.width
        color: "white"
        radius: 10
        visible: false
        id: dropListContainer
        anchors {
            top: parent.bottom
            topMargin: 7
        }

        ListView {
            height: 242
            width: parent.width
            model: sizeList
            spacing: 10
            clip: true
            header: Item {
                height: 10
                width: parent.width
            }

            delegate: Item {
                height: 16
                width: parent.width

                Text {
                    color: "#585D6C"
                    height: 16
                    width: parent.width
                    font.family: "Nunito"
                    font.pixelSize: 16
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        right: parent.right
                        margins: 13
                    }
                    font.bold: currentIdx == index
                    text: sizeList.get(index).size + " px"

                    MouseArea {
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
