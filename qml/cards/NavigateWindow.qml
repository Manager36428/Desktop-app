import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQml 2.12
import QtQml.Models 2.1
import "../components"
import "../common"

FramelessWindow {
    id: window
    width: 308
    height: 420
    minimumWidth: 308
    minimumHeight: 420
    onHeightChanged: console.log("Window Dock  H : ", height)
    onWidthChanged: console.log("Window Dock W: " , width)
    title: "Navigate"

    property bool resizeAtFirst: true

    onBtnCloseClicked: {
        controller.navi_mode = 2
        close()        
    }

    onBtnShirkClicked: {
        controller.navi_mode = 0
        close()
    }

    content : Item {
        id : rootItem
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        Item {
            id: _contentHolder
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: isDocked ? 0 : 8
            }

            Item{
                anchors.fill: parent
                id : itemRoot

                function syncReorderedPageNames()
                {
                    var after_drag_list = []
                    for(var i=0;i < naviList.count;i++)
                    {
                        var item = naviList.itemAtIndex(i);
                        after_drag_list.push(item.itemName)
                    }
                    console.log("syncReorderedPageNames : " , after_drag_list)
                    controller.sync_model(after_drag_list)
                }

                Component {
                    id: dragDelegate
                    MouseArea{
                        id : dragArea
                        property bool held: false
                        pressAndHoldInterval: 200
                        property alias itemName: content.btnName

                        anchors {
                            left: parent.left
                            right: parent.right
                        }
                        height: content.height
                        drag.target: held ? content : undefined
                        drag.axis: Drag.YAxis

                        onPressAndHold: held = true
                        onReleased: {
                            held = false
                            //Update Tail's visibility
                            tailRect.visible = (DelegateModel.itemsIndex !== (visualModel.count - 1))
                            itemRoot.syncReorderedPageNames()
                        }

                        onClicked: {
                            controller.current_page_idx = index
                        }

                        ButtonText{
                            id : content
                            btnName: modelData.page_name
                            isActive: index === controller.current_page_idx
                            anchors{
                                left: parent.left
                                right: parent.right
                                leftMargin: 15
                                rightMargin: 15
                            }
                            useMouseArea: false

                            Drag.active: dragArea.held
                            Drag.source: dragArea
                            Drag.hotSpot.x: width / 2
                            Drag.hotSpot.y: height / 2

                            states: State {
                                when: dragArea.held

                                ParentChange { target: content; parent: rootItem }
                                AnchorChanges {
                                    target: content
                                    anchors { horizontalCenter: undefined; verticalCenter: undefined }
                                }
                            }

                            Rectangle{
                                height: 14
                                width: 1
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: "#F1F3F8"
                                anchors.top: parent.bottom
                                anchors.topMargin: 0
                                z:-1
                                id : tailRect
                                visible: DelegateModel.itemsIndex !== (visualModel.count - 1)
                            }
                        }

                        DropArea {
                            anchors { fill: parent; margins: 10 }

                            onEntered: {
                                visualModel.items.move(
                                            drag.source.DelegateModel.itemsIndex,
                                            dragArea.DelegateModel.itemsIndex)
                            }
                        }

                        Component.onCompleted: {
                            //Update Tail's visibility
                            tailRect.visible = (DelegateModel.itemsIndex !== (visualModel.count - 1))
                        }
                    }
                }

                DelegateModel{
                    id : visualModel
                    model: controller.pages
                    delegate: dragDelegate
                }

                ListView{
                    id : naviList
                    clip: true
                    width: 278
                    model : visualModel
                    spacing: 14
                    snapMode: ListView.SnapToItem
                    anchors{
                        left: parent.left
                        right: parent.right
                        top: parent.top
                        topMargin: 44
                        bottom: parent.bottom
                        bottomMargin: 70
                    }
                    onCountChanged: {
                        console.log("Count Changed")
                        itemRoot.syncReorderedPageNames()
                    }

                    Component.onCompleted: {
                        itemRoot.syncReorderedPageNames()
                    }
                }

                ButtonText{
                    id :btnNewPage
                    icSrc: "qrc:/assets/ic_add.png"
                    btnName: "New Page"
                    anchors{
                        left: parent.left
                        right: parent.right
                        leftMargin: 15
                        rightMargin: 15
                        top: naviList.bottom
                        topMargin: 25
                    }

                    onBtnClicked: {
                        controller.add_page()
                    }

                }

            }
        }
    }
}

