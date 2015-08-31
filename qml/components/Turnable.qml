import QtQuick 2.0
import Sailfish.Silica 1.0
import "../Utils.js" as Utils

Grid {
    id: root
    property Page _page: Utils.findPage(root)
    property int spacing: Theme.paddingMedium

    columns: _page.isPortrait ? 1 : 2
    rows: Math.ceil(children.length / columns)
    columnSpacing: spacing
    rowSpacing: spacing

    property int itemWidth: (width - (columnSpacing * (columns - 1))) / columns
    property int itemHeight: (height - (rowSpacing * (rows - 1))) / rows

    clip: true
}
