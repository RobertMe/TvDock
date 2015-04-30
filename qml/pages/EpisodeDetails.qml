import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

DetailsPage {
    id: page
    property TraktEpisode episode

    onEpisodeChanged: {
        if (episode) {
            episode.load();
        }
    }

    sourcePortrait: episode.season.images.poster.medium || episode.season.show.images.poster.medium
    sourceLandscape: episode.images.screenshot.medium || episode.season.show.images.fanart.medium

    title: episode.season.number + "x" + episode.number + ": " + episode.title


    DetailsFlickablePage {
        Turnable {
            id: overviewTurnable
            anchors {
                fill: parent
                leftMargin: Theme.paddingLarge
                rightMargin: Theme.paddingLarge
            }

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
