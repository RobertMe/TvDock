import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0

SilicaListView {
    id: root
    signal showAll()
    property alias sourceModel: limitedModel.sourceModel

    orientation: Qt.Horizontal
    layoutDirection: Qt.LeftToRight
    clip: true

    model: LimitedModel {
        id: limitedModel
        maxItems: 5
    }

    MenuItem {
        id: showAllLeft
        //% "Show all"
        text: qsTrId("menu-show-all")
        transform: Rotation { angle: -90; }
        x: (-parent.contentX) - height
        y: (parent.height - width) / 2 + width
        height: implicitHeight
        width: implicitWidth
    }

    MenuItem {
        id: showAllRight
        //% "Show all"
        text: qsTrId("menu-show-all")
        transform: Rotation { angle: 90; }
        x: (-parent.contentX) + parent.contentWidth + height
        y: (parent.height - width) / 2
        height: implicitHeight
        width: implicitWidth
    }

    boundsBehavior: Flickable.DragOverBounds

    onDraggingHorizontallyChanged: {
        if (!draggingHorizontally) {
            if (showAllLeft.x > 0 || width > showAllRight.x) {
                root.showAll()
            }
        }
    }
}
