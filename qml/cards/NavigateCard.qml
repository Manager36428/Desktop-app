import QtQuick 2.9
import QtQml 2.0
import QtQml.Models 2.1
import "../common"

TitleCardSeparatedItems{
    title: "Navigate"
    heightDock: 323
    widthDock: 300
    windowParent.minimumHeight: 323
    windowParent.minimumWidth: 300
    id : root


    contentDock: Item{
        anchors.fill: parent
        id : itemRoot

        property var currentPage: controller.current_page
        onCurrentPageChanged: itemRoot.syncReorderedPageNames()

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

                        ParentChange { target: content; parent: root }
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
