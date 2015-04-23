import QtQuick 2.0
import Sailfish.Silica 1.0

SilicaGridView {
    id: root
    property Page page

    default property alias contents: model.children

    property alias itemWidth: root.cellWidth
    property alias itemHeight: root.cellHeight

    cellWidth: page.isPortrait ? width : width / children.length
    cellHeight: page.isPortrait ? height / children.length : height
    interactive: false

    clip: true

    model: VisualItemModel {
        id: model
    }
}
