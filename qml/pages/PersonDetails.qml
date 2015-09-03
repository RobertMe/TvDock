import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

DetailsPage {
    id: page
    property TraktPerson person
    property QtObject movies: trakt.people.getMovies(person)
    property QtObject shows: trakt.people.getShows(person)

    onPersonChanged: {
        if (person) {
            person.load();
        }
    }

    sourcePortrait: person.images.headshot.medium
    loading: !person.loaded
    title: person.name

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
        SilicaGridView {
            id: moviesGrid
            property int rowCount: Math.round(height / 225)

            anchors.fill: parent
            flow: Grid.TopToBottom
            layoutDirection: Qt.LeftToRight
            cellWidth: cellHeight / 1.5
            cellHeight: parent.height / rowCount

            model: movies

            delegate: MovieItem {
                grid: moviesGrid
            }

            HorizontalScrollDecorator {}
        }
    }

    DetailsFlickablePage {
        SilicaGridView {
            id: showsGrid
            property int rowCount: Math.round(height / 225)

            anchors.fill: parent
            flow: Grid.TopToBottom
            layoutDirection: Qt.LeftToRight
            cellWidth: cellHeight / 1.5
            cellHeight: parent.height / rowCount

            model: shows

            delegate: ShowItem {
                grid: showsGrid
            }

            HorizontalScrollDecorator {}
        }
    }
}
