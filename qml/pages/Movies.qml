import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

Page {
    id: page
    property string mode
    property alias model: moviesGrid.model
    allowedOrientations: defaultAllowedOrientations

    onStatusChanged: {
        if (status === PageStatus.Active) {
            showCover("ItemList", {items: moviesGrid.model, title: qsTrId("list-" + page.mode) + "\n" + qsTrId("header-movies")});
        }
    }

    BusyIndicator {
        size: BusyIndicatorSize.Large
        anchors.centerIn: parent
        visible: !page.model.loaded && page.model.loading
        running: visible
    }

    SilicaGridView {
        id: moviesGrid

        property int columnCount: Math.round(parent.width / 150)

        header: PageHeader {
            //: Header of movies listing, containing the mode name
            //% "Movies: %1"
            title: qsTrId("movies-header").arg(qsTrId("list-" + page.mode))
        }

        anchors.fill: parent
        cellWidth: parent.width / columnCount
        cellHeight: cellWidth * 1.5

        delegate: MovieItem {
            grid: moviesGrid
        }
    }
}
