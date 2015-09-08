import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

DetailsPage {
    id: page
    property alias person: page.item
    property QtObject movies: trakt.people.getMovies(person)
    property QtObject shows: trakt.people.getShows(person)

    onStatusChanged: {
        if (status === PageStatus.Active) {
            showCover("Person", {person: person});
        }
    }

    sourcePortrait: person.images.headshot.medium

    pullDownMenu: PullDownMenu {
        enabled: person.ids && person.ids.imdb
        visible: enabled

        MenuItem {
            //% "Show on IMDB"
            text: qsTrId("item-show-imdb")
            visible: person.ids && person.ids.imdb
            onClicked: Qt.openUrlExternally(trakt.imdbBaseUrl + "/name/" + person.ids.imdb)
        }
    }

    DetailsFlickablePage {
        ItemDetails {
            anchors.fill: parent
            image: person.images.headshot.thumb
            overview: person.biography
            details: [
                Label {
                    width: parent.width
                    text: Qt.formatDate(person.birthday)
                },

                Label {
                    width: parent.width
                    text: person.birthplace
                    wrapMode: Text.WordWrap
                },

                Label {
                    width: parent.width
                    text: person.death
                    visible: !!person.death
                },

                Button {
                    width: parent.width
                    //: Homepage of a movie/show/...
                    //% "Homepage"
                    text: qsTrId("item-homepage")
                    visible: !!person.homepage

                    onClicked: Qt.openUrlExternally(person.homepage)
                }
            ]
        }
    }

    DetailsFlickablePage {
        SectionHeader {
            id: moviesHeader
            text: qsTrId("header-movies")
            anchors {top: parent.top; left: parent.left; right: parent.right; rightMargin: Theme.paddingLarge; }
        }

        SilicaGridView {
            id: moviesGrid
            property int maxHeight: parent.height - y
            property int rowCount: Math.round(maxHeight / 225)

            anchors {top: moviesHeader.bottom; bottom: parent.bottom; left: parent.left; right: parent.right; }
            flow: Grid.TopToBottom
            layoutDirection: Qt.LeftToRight
            cellWidth: cellHeight / 1.5
            cellHeight: maxHeight / rowCount

            model: movies

            delegate: MovieItem {
                grid: moviesGrid
            }

            HorizontalScrollDecorator {}
        }

        BusyIndicator {
            size: BusyIndicatorSize.Large
            anchors.centerIn: parent
            visible: !moviesGrid.model.loaded && moviesGrid.model.loading
            running: visible
        }
    }

    DetailsFlickablePage {
        SectionHeader {
            id: showsHeader
            text: qsTrId("header-shows")
            anchors {top: parent.top; left: parent.left; right: parent.right; rightMargin: Theme.paddingLarge; }
        }

        SilicaGridView {
            id: showsGrid
            property int maxHeight: parent.height - y
            property int rowCount: Math.round(maxHeight / 225)

            anchors {top: showsHeader.bottom; bottom: parent.bottom; left: parent.left; right: parent.right; }
            flow: Grid.TopToBottom
            layoutDirection: Qt.LeftToRight
            cellWidth: cellHeight / 1.5
            cellHeight: maxHeight / rowCount

            model: shows

            delegate: ShowItem {
                grid: showsGrid
            }

            HorizontalScrollDecorator {}
        }

        BusyIndicator {
            size: BusyIndicatorSize.Large
            anchors.centerIn: parent
            visible: !showsGrid.model.loaded && showsGrid.model.loading
            running: visible
        }
    }
}
