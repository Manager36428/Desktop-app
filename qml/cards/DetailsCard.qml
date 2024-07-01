import QtQuick 2.0
import "../common"
import "../components"

TitleCard {
    id : detailCard
    title: currentPage != undefined ? "Details" + " : " + currentPage.page_name : "Details"

    windowParent.minimumHeight: 515
    windowParent.minimumWidth: 330

    contentDock: ManagerContent{

    }

}
