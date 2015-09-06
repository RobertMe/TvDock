import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

DetailsPage {
    id: page
    property TraktShow show
    property QtObject seasons: trakt.shows.getSeasons(show)

    onShowChanged: {
        if (show) {
            show.load();
        }
    }

    onStatusChanged: {
        if (status === PageStatus.Active) {
            showCover("Poster", {item: show});
        }
    }

    sourcePortrait: show.images.poster.medium
    sourceLandscape: show.images.fanart.medium
    loading: !show.loaded
    title: show.title

    DetailsFlickablePage {
        ItemDetails {
            anchors.fill: parent
            image: show.images.poster.thumb
            overview: show.overview
            details: [
                Label {
                    width: parent.width
                    text: Qt.formatDate(show.firstAired)
                },

                Label {
                    width: parent.width
                    text: Qt.formatTime(show.runtime, "h:mm")
                },

                Label {
                    width: parent.width
                    //: Rating of an item, for example "80% (100 votes)"
                    //% "%1% (%2 votes)"
                    text: qsTrId("item-rating").arg(Math.round(show.rating * 10)).arg(show.votes)
                },

                Button {
                    width: parent.width
                    //: Homepage of a movie/show/...
                    //% "Homepage"
                    text: qsTrId("item-homepage")
                    visible: !!show.homepage

                    onClicked: Qt.openUrlExternally(show.homepage)
                },

                Button {
                    width: parent.width
                    //: Trailer of show/show/...
                    //% "Trailer"
                    text: qsTrId("item-trailer")
                    visible: !!show.trailer

                    onClicked: Qt.openUrlExternally(show.trailer)
                }
            ]
        }
    }

    DetailsFlickablePage {
        Column {
            anchors.fill: parent

            SectionHeader {
                //: "Seasons" heading for show details
                //% "Seasons"
                text: qsTrId("header-seasons")
                height: implicitHeight
            }

            SilicaListView {
                id: seasonsView
                width: parent.width
                height: 300
                model: page.seasons

                orientation: Qt.Horizontal
                layoutDirection: Qt.LeftToRight
                clip: true

                delegate: ListItem {
                    contentHeight: 300
                    width: 200

                    Image {
                        height: 300
                        width: 200
                        CacheImage {
                            source: images.poster.thumb
                        }
                    }

                    onClicked: pageStack.push("SeasonDetails.qml", {season: seasonsView.model.at(index)})
                }

                HorizontalScrollDecorator {}
            }
        }

        BusyIndicator {
            size: BusyIndicatorSize.Large
            anchors.centerIn: parent
            visible: !seasonsView.model.loaded && seasonsView.model.loading
            running: visible
        }
    }

    DetailsFlickablePage {
        PeopleOverview {
            anchors.fill: parent
            people: trakt.people.people(show.ids)
        }
    }
}
