import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

Page {
    id: page
    allowedOrientations: Orientation.All
    property TraktShow show

    onShowChanged: {
        if (show) {
            show.load();
        }
    }

    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        opacity: .25

        CacheImage {
            source: page.isPortrait ? show.images.poster.medium : show.images.fanart.medium
        }

        Rectangle {
            anchors.fill: parent
            color: Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity)
        }
    }

    PageHeader {
        id: header
        title: show.title
        wrapMode: Text.Wrap

        MouseArea {
            anchors.fill: parent
            onClicked: view.scrollToTop()
        }
    }

    DetailsFlickable {
        id: view
        anchors {
            left: parent.left
            right: parent.right
            top: header.bottom
            bottom: parent.bottom
            topMargin: -Theme.paddingLarge
        }

        DetailsFlickablePage {
            view: view

            ItemDetails {
                anchors {
                    fill: parent
                    leftMargin: Theme.paddingLarge
                    rightMargin: Theme.paddingLarge
                }
                page: page
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
            view: view

            Column {
                height: view.cellHeight
                width: view.cellWidth

                SectionHeader {
                    //: "Seasons" heading for show details
                    //% "Seasons"
                    text: qsTrId("show-seasons")
                    height: implicitHeight
                }

                SilicaListView {
                    id: seasonsView
                    width: parent.width
                    height: 300
                    model: trakt.shows.getSeasons(show)

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
                    }
                }
            }
        }

        DetailsFlickablePage {
            view: view

            PeopleOverview {
                anchors.fill: parent
                people: trakt.people.people(show.ids)
            }
        }
    }
}
