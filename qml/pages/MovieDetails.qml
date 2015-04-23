import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

Page {
    id: page
    allowedOrientations: Orientation.All
    property TraktMovie movie

    onMovieChanged: {
        if (movie) {
            movie.load();
        }
    }

    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        opacity: .25

        CacheImage {
            source: page.isPortrait ? movie.images.poster.medium : movie.images.fanart.medium
        }

        Rectangle {
            anchors.fill: parent
            color: Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity)
        }
    }

    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        contentHeight: height

        PullDownMenu {
            MenuItem {
                //: Start checkin process for movie or episode
                //% "Check in"
                text: qsTrId("checkin-start")
                onClicked: {
                    var checkin = trakt.createCheckin(movie.ids);
                    if (checkin) {
                        pageStack.push("CheckInDialog.qml", {checkin: checkin});
                    }
                }
            }
        }

        PageHeader {
            id: header
            title: movie.title
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
            }
            y: header.height - Theme.paddingLarge
            height: flickable.height - y

            DetailsFlickablePage {
                view: view
                Column {
                    anchors {
                        fill: parent
                        leftMargin: Theme.paddingLarge
                        rightMargin: Theme.paddingLarge
                    }
                    spacing: Theme.paddingMedium

                    Label {
                        width: Math.min(implicitWidth, parent.width)
                        height: contentHeight
                        text: movie.tagline
                        wrapMode: Text.Wrap
                        anchors.right: parent.right
                        color: Theme.highlightColor
                        font.family: Theme.fontFamilyHeading
                    }

                    ItemDetails {
                        width: parent.width
                        height: parent.height - y - Theme.paddingLarge
                        page: page
                        image: movie.images.poster.thumb
                        overview: movie.overview
                        details: [
                            Label {
                                width: parent.width
                                text: Qt.formatDate(movie.released)
                            },

                            Label {
                                width: parent.width
                                text: Qt.formatTime(movie.runtime, "h:mm")
                            },

                            Label {
                                width: parent.width
                                //: Rating of an item, for example "80% (100 votes)"
                                //% "%1% (%2 votes)"
                                text: qsTrId("item-rating").arg(Math.round(movie.rating * 10)).arg(movie.votes)
                            },

                            Button {
                                width: parent.width
                                //: Homepage of a movie/show/...
                                //% "Homepage"
                                text: qsTrId("item-homepage")
                                visible: !!movie.homepage

                                onClicked: Qt.openUrlExternally(movie.homepage)
                            },

                            Button {
                                width: parent.width
                                //: Trailer of movie/show/...
                                //% "Trailer"
                                text: qsTrId("item-trailer")
                                visible: !!movie.trailer

                                onClicked: Qt.openUrlExternally(movie.trailer)
                            }
                        ]
                    }
                }
            }

            DetailsFlickablePage {
                view: view

                PeopleOverview {
                    anchors.fill: parent
                    people: movie.people
                }
            }
        }
    }
}
