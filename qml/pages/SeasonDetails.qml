import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

Page {
    id: page
    allowedOrientations: Orientation.All
    property TraktSeason season

    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        opacity: .25

        CacheImage {
            source: page.isPortrait ? (season.images.poster.medium || season.show.images.poster.medium) : season.show.images.fanart.medium
        }

        Rectangle {
            anchors.fill: parent
            color: Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity)
        }
    }

    PageHeader {
        id: header
        //: Title of the season details page
        //% "Season %1"
        title: qsTrId("season-title").arg(season.number)
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

            ItemDetails {
                anchors {
                    fill: parent
                    leftMargin: Theme.paddingLarge
                    rightMargin: Theme.paddingLarge
                }
                page: page
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
            view: view

            SilicaGridView {
                id: episodesView

                anchors.fill: parent

                layoutDirection: Qt.LeftToRight
                flow: Grid.TopToBottom

                cellWidth: page.isPortrait ? 350 : (cellHeight - Theme.itemSizeExtraSmall) / 9 * 16
                cellHeight: page.isPortrait ? cellWidth/16*9 + Theme.itemSizeExtraSmall : height / 2

                model: trakt.shows.getEpisodes(page.season)

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
                            width: parent.width
                            height: Theme.itemSizeExtraSmall
                            text: season.number + "x" + number + ": " + title
                            truncationMode: TruncationMode.Fade
                            verticalAlignment: Text.AlignVCenter
                            color: Theme.highlightColor
                        }
                    }
                }
            }
        }
    }
}
