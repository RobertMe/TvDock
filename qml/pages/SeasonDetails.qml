import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

DetailsPage {
    id: page
    property alias season: page.item
    property QtObject episodes: trakt.shows.getEpisodes(season)

    onStatusChanged: {
        if (status === PageStatus.Active) {
            showCover("Poster", {item: season});
        }
    }

    sourcePortrait: season.images.poster.medium || season.show.images.poster.medium
    sourceLandscape: season.show.images.fanart.medium

    pullDownMenu: PullDownMenu {
        enabled: season.show.ids && season.show.ids.imdb
        visible: enabled

        MenuItem {
            //% "Show on IMDB"
            text: qsTrId("item-show-imdb")
            visible: season.show.ids && season.show.ids.imdb
            onClicked: Qt.openUrlExternally(trakt.imdbBaseUrl + "/title/" + season.show.ids.imdb + "/episodes?season=" + season.number)
        }
    }

    DetailsFlickablePage {
        ItemDetails {
            anchors.fill: parent
            image: season.images.poster.thumb
            overview: season.overview
            details: [
                Label {
                    width: parent.width
                    text: season.episodeCount
                },
                Label {
                    width: parent.width
                    text: season.airedEpisodes
                },
                Label {
                    text: qsTrId("item-rating").arg(Math.round(season.rating * 10)).arg(season.votes)
                }
            ]
        }
    }

    DetailsFlickablePage {
        SectionHeader {
            id: episodesHeader
            //: "Episodes" heading for season details
            //% "Episodes"
            text: qsTrId("header-episodes")
            anchors {top: parent.top; left: parent.left; right: parent.right; rightMargin: Theme.paddingLarge; }
        }

        SilicaGridView {
            id: episodesView

            anchors {top: episodesHeader.bottom; bottom: parent.bottom; left: parent.left; right: parent.right; }

            layoutDirection: Qt.LeftToRight
            flow: Grid.TopToBottom

            cellWidth: (cellHeight - Theme.itemSizeExtraSmall) / 9 * 16
            cellHeight: height / Math.round(height / (200 + Theme.itemSizeExtraSmall))

            model: page.episodes

            delegate: ListItem {
                width: episodesView.cellWidth
                contentHeight: episodesView.cellHeight

                onClicked: pageStack.push("EpisodeDetails.qml", {episode: episodesView.model.at(index)})

                Column {
                    width: parent.width

                    Image {
                        width: parent.width
                        height: width/16*9
                        fillMode: Image.PreserveAspectFit

                        CacheImage {
                            source: images.screenshot.thumb
                        }
                    }

                    Label {
                        width: parent.width - (Theme.paddingMedium * 2)
                        x: Theme.paddingMedium
                        height: Theme.itemSizeExtraSmall
                        text: season.number + "x" + number + ": " + title
                        truncationMode: TruncationMode.Fade
                        verticalAlignment: Text.AlignVCenter
                        color: Theme.highlightColor
                    }
                }
            }

            HorizontalScrollDecorator {}
        }

        BusyIndicator {
            size: BusyIndicatorSize.Large
            anchors.centerIn: parent
            visible: !episodesView.model.loaded && episodesView.model.loading
            running: visible
        }
    }
}
