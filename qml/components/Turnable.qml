import QtQuick 2.0
import Sailfish.Silica 1.0
import "../Utils.js" as Utils

Grid {
    id: root
    property Page _page: Utils.findPage(root)

    columns: _page.isPortrait ? 1 : 2
    columnSpacing: Theme.paddingMedium
    rowSpacing: Theme.paddingMedium

    property int itemWidth: (width - (columnSpacing * (columns - 1))) / columns

    clip: true
}
