import QtQuick 2.0

Item {
    id : root
    height: 36
    width: 93
    property int currentIdx: 8
    property var listValue : [8,9,10,11,12,13,14,15,16,20,24,32,36,40,48]
    property string title: "Text Size"
    property int offsetPopup: 17

    signal valueUpdated(var number_value)

    function getValue(){
        return listValue[currentIdx];
    }

    function updateValue(new_value){
        console.log("Value :" , new_value)
        currentIdx = listValue.indexOf(new_value);
        console.log("Index : ", currentIdx)
        if(currentIdx == -1)
            currentIdx = 8
    }

    onCurrentIdxChanged: valueUpdated(listValue[currentIdx])

    Text{
        id :header
        height: 16
        font.pixelSize: 16
        font.weight: Font.DemiBold
        width: parent.width
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
        text : title
        color: "#4D365D"
        font.family: "Nunito"
    }

    Rectangle{
        color: "white"
        radius: 10        
        anchors.right: parent.right
        height: parent.height
        width: 62

        Text{
            color: "#585D6C"
            height: 16
            font.family: "Nunito"
            font.pixelSize: 16
            anchors{
                left: parent.left
                right: btnArrDown.left
                margins: 13
                verticalCenter: parent.verticalCenter
            }
            text: listValue[currentIdx]
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

                //Scroll to Index
                listNumber.positionViewAtIndex(currentIdx, ListView.Center)
            }
        }

    }

    Rectangle{
        height: 175
        width: 58
        color:  "white"
        radius: 10
        visible: false
        id : dropListContainer
        clip: true
        anchors{
            left: parent.right
            verticalCenter: parent.verticalCenter
            leftMargin: offsetPopup
        }

        ListView{
            id : listNumber
            anchors{
                top: parent.top
                bottom: parent.bottom
                topMargin: 15
                bottomMargin: 15
            }

            width: parent.width
            model: listValue
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
                    verticalAlignment: Text.AlignVCenter
                    font.bold: currentIdx == index
                    text: listValue[index]
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
