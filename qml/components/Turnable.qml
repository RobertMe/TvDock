import QtQuick 2.0
import Sailfish.Silica 1.0
import "../Utils.js" as Utils

SilicaGridView {
    id: root
    property Page _page: Utils.findPage(root)

    default property alias contents: model.children

    property alias itemWidth: root.cellWidth
    property alias itemHeight: root.cellHeight

    cellWidth: _page.isPortrait ? width : width / children.length
    cellHeight: _page.isPortrait ? height / children.length : height
    interactive: false

    clip: true

    model: VisualItemModel {
        id: model
    }
}
