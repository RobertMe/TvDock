import QtQuick 2.0
import Sailfish.Silica 1.0

SilicaGridView {
    id: root
    default property alias contents: pages.children

    model: VisualItemModel {
        id: pages
    }

    cellWidth: width //page.isPortrait ? width : width / 2
    cellHeight: height
    clip: true
    quickScrollEnabled: false

    snapMode: ListView.SnapOneItem
}
