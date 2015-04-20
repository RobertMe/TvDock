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

    VisualItemModel {
        id: itemModel

        Column {
            id: content
            height: view.cellHeight
            width: view.cellWidth
            spacing: Theme.paddingMedium

            Flipable {
                id: overviewFlipable
                page: page
                width: parent.width
                height: parent.height - y - Theme.paddingLarge

                Row {
                    id: row
                    width: overviewFlipable.itemWidth
                    height: overviewFlipable.itemHeight

                    spacing: Theme.paddingMedium

                    Image {
                        id: poster
                        width: Theme.itemSizeLarge * 2
                        height: width * 1.5

                        CacheImage {
                            source: show.images.poster.thumb
                        }
                    }

                    Column {
                        width: row.width - poster.width - row.spacing

                        Label {
                            width: parent.width
                            text: Qt.formatDate(show.firstAired)
                        }

                        Label {
                            width: parent.width
                            text: Qt.formatTime(show.runtime, "h:mm")
                        }

                        Label {
                            width: parent.width
                            //: Rating of an item, for example "80% (100 votes)"
                            //% "%1% (%2 votes)"
                            text: qsTrId("item-rating").arg(Math.round(show.rating * 10)).arg(show.votes)
                        }

                        Button {
                            width: parent.width
                            //: Homepage of a movie/show/...
                            //% "Homepage"
                            text: qsTrId("item-homepage")
                            visible: !!show.homepage

                            onClicked: Qt.openUrlExternally(show.homepage)
                        }

                        Button {
                            width: parent.width
                            //: Trailer of show/show/...
                            //% "Trailer"
                            text: qsTrId("item-trailer")
                            visible: !!show.trailer

                            onClicked: Qt.openUrlExternally(show.trailer)
                        }
                    }
                }

                FlickableLabel {
                    width: overviewFlipable.itemWidth
                    height: overviewFlipable.itemHeight
                    text: show.overview
                    font.pixelSize: Theme.fontSizeSmall
                }
            }
        }
        PeopleOverview {
            height: view.cellHeight
            width: view.cellWidth
            people: show.people
        }

        Column {
            height: view.cellHeight
            width: view.cellWidth
            Label {
                text: "Comments"
            }
        }
        Column {
            height: view.cellHeight
            width: view.cellWidth
            Label {
                text: "Related"
            }
        }
        Column {
            height: view.cellHeight
            width: view.cellWidth
            Label {
                text: "Watching"
            }
        }
    }

    SilicaGridView {
        id: view
        anchors {
            left: parent.left
            right: parent.right
            top: header.bottom
            bottom: parent.bottom
            leftMargin: Theme.paddingLarge
            rightMargin: Theme.paddingLarge
            topMargin: -Theme.paddingLarge
        }

        model: itemModel
        cellWidth: width //page.isPortrait ? width : width / 2
        cellHeight: height
        clip: true
        quickScrollEnabled: false

        snapMode: ListView.SnapOneItem
    }
}
