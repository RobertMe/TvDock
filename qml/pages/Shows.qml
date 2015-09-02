import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

Page {
    id: page
    property string mode
    property alias model: showsGrid.model
    allowedOrientations: defaultAllowedOrientations

    SilicaGridView {
        id: showsGrid

        property int columnCount: Math.round(parent.width / 150)

        header: PageHeader {
            //: Header of TV shows listing, containing the mode name
            //% "TV Shows: %1"
            title: qsTrId("shows-header").arg(qsTrId("list-" + page.mode));
        }

        anchors.fill: parent
        cellWidth: parent.width / columnCount
        cellHeight: cellWidth * 1.5

        delegate: ShowItem {
            grid: showsGrid
        }
    }
}
