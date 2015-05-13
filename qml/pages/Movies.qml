import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0

Page {
    id: page
    property string mode
    property alias model: grid.model
    allowedOrientations: defaultAllowedOrientations

    SilicaGridView {
        id: grid

        property int columnCount: Math.round(parent.width / 150)

        header: PageHeader {
            //: Header of movies listing, containing the mode name
            //% "Movies: %1"
            title: qsTrId("movies-header").arg(qsTrId("list-" + page.mode));
        }

        anchors.fill: parent
        cellWidth: parent.width / columnCount
        cellHeight: cellWidth * 1.5

        delegate: ListItem {
            width: grid.cellWidth
            contentHeight: grid.cellHeight

            onClicked: pageStack.push("MovieDetails.qml", {movie: grid.model.at(index)})

            Image {
                width: grid.cellWidth
                height: grid.cellHeight
                fillMode: Image.PreserveAspectFit

                CacheImage {
                    source: images.poster.thumb
                }
            }
        }
    }
}
