import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../Utils.js" as Utils

SilicaGridView {
    id: root
    signal showAll()
    property variant sourceModel
    property Page _page: Utils.findPage(root)
    property int rows: Math.round(height / 225)

    width: parent.width

    flow: Grid.TopToBottom
    layoutDirection: Qt.LeftToRight
    cellHeight: height / rows
    cellWidth: cellHeight / 1.5

    clip: true

    model: LimitedModel {
        id: limitedModel
        maxItems: Math.ceil(root.width / root.cellWidth) * root.rows
        sourceModel: root.sourceModel
    }

    BusyIndicator {
        size: BusyIndicatorSize.Medium
        anchors.centerIn: parent
        visible: !limitedModel.sourceModel.loaded && limitedModel.sourceModel.loading
        running: visible
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

        visible: !limitedModel.sourceModel.loading
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
