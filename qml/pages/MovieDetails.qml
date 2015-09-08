import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

DetailsPage {
    id: page
    property alias movie: page.item

    onStatusChanged: {
        if (status === PageStatus.Active) {
            showCover("Poster", {item: movie});
        }
    }

    sourcePortrait: movie.images.poster.medium
    sourceLandscape: movie.images.fanart.medium

    pullDownMenu: PullDownMenu {
        enabled: trakt.authenticator.authorized
        visible: enabled

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

    DetailsFlickablePage {
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
        PeopleOverview {
            anchors.fill: parent
            people: trakt.people.people(movie.ids)
        }
    }
}
