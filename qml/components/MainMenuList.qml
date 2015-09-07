import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../Utils.js" as Utils

Column {
    id: root
    property alias title: header.text
    property alias delegate: grid.delegate
    property alias grid: grid
    property string mode
    property string pageName
    property variant sourceModel

    function showAll() {
        pageStack.push(pageName, {model: sourceModel, mode: mode})
    }

    SectionHeader {
        id: header
        height: implicitHeight + Theme.paddingSmall * 2
        color: headerArea.pressed ? Theme.highlightColor: Theme.primaryColor

        MouseArea {
            id: headerArea
            anchors.fill: parent
            onClicked: showAll()
        }
    }

    SilicaGridView {
        id: grid
        property Page _page: Utils.findPage(root)
        property int rows: Math.round(height / 225)

        width: parent.width
        height: parent.height - y

        flow: Grid.TopToBottom
        layoutDirection: Qt.LeftToRight
        cellHeight: height / rows
        cellWidth: cellHeight / 1.5

        clip: true

        model: LimitedModel {
            id: limitedModel
            maxItems: Math.ceil(grid.width / grid.cellWidth) * grid.rows
            sourceModel: root.sourceModel
        }

        BusyIndicator {
            size: BusyIndicatorSize.Medium
            anchors.centerIn: parent
            visible: !limitedModel.sourceModel.loaded && limitedModel.sourceModel.loading
            running: visible
        }

        footer: Item {
            height: grid.height
            width: childrenRect.height
            Button {
                //% "Show all"
                text: qsTrId("menu-show-all")
                transform: Rotation { angle: 90; }
                x: height
                y: (grid.height - width) / 2

                onClicked: root.showAll();
            }
        }
    }
}
