import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

Page {
    id: page
    allowedOrientations: Orientation.All
    property TraktEpisode episode

    onEpisodeChanged: {
        if (episode) {
            episode.load();
        }
    }

    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        opacity: .25

        CacheImage {
            source: page.isPortrait ? (episode.season.images.poster.medium || episode.season.show.images.poster.medium) : (episode.images.screenshot.medium || episode.season.show.images.fanart.medium)
        }

        Rectangle {
            anchors.fill: parent
            color: Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity)
        }
    }

    PageHeader {
        id: header
        title: episode.season.number + "x" + episode.number + ": " + episode.title
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
        }

        DetailsFlickablePage {
            view: view

            Turnable {
                id: overviewTurnable
                anchors {
                    fill: parent
                    leftMargin: Theme.paddingLarge
                    rightMargin: Theme.paddingLarge
                }
                page: page

                Column {
                    width: overviewTurnable.itemWidth
                    height: overviewTurnable.itemHeight

                    spacing: Theme.paddingMedium

                    Image {
                        width: parent.width
                        height: width / 16 * 9
                        fillMode: Image.PreserveAspectFit

                        CacheImage {
                            source: episode.images.screenshot.thumb
                        }
                    }

                    Label {
                        width: parent.width
                        text: Qt.formatDate(episode.firstAired)
                    }
                    Label {
                        text: qsTrId("item-rating").arg(Math.round(episode.rating * 10)).arg(episode.votes)
                    }
                }

                FlickableLabel {
                    width: overviewTurnable.itemWidth
                    height: overviewTurnable.itemHeight
                    font.pixelSize: Theme.fontSizeSmall

                    text: episode.overview
                }
            }
        }
    }
}
