import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0

Page {
    id: page
    allowedOrientations: Orientation.All
    property string mode: "popular"

    TraktMovies {
        id: movies
    }

    SilicaGridView {
        id: grid

        property int columnCount: Math.round(parent.width / 200)

        header: PageHeader {
            //: Header of movies listing, containing the mode name
            //% "Movies: %1"
            title: qsTrId("movies-header").arg(qsTrId("movies-" + page.mode));
        }

        PullDownMenu {
            MenuItem {
                //: List trending movies
                //% "Trending"
                text: qsTrId("movies-trending")
                onClicked: page.mode = "trending"
                visible: page.mode != "trending"
            }
            MenuItem {
                //: List popular movies
                //% "Popular"
                text: qsTrId("movies-popular")
                onClicked: page.mode = "popular"
                visible: page.mode != "popular"
            }
        }

        anchors.fill: parent
        model: movies[page.mode]()
        cellWidth: parent.width / columnCount
        cellHeight: cellWidth * 1.5

        delegate: ListItem {
            width: grid.cellWidth
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
