import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0

Item {
    id: root

    property alias details: detailsColumn.children
    property Page page
    property alias image: cachePoster.source
    property alias overview: overviewLabel.text

    Turnable {
        id: overviewTurnable

        page: root.page
        anchors.fill: parent

        Row {
            id: row
            width: overviewTurnable.itemWidth
            height: overviewTurnable.itemHeight

            spacing: Theme.paddingMedium

            Image {
                id: poster
                width: Theme.itemSizeLarge * 2
                height: width * 1.5

                CacheImage {
                    id: cachePoster
                }
            }

            Column {
                id: detailsColumn
                width: row.width - poster.width - row.spacing
            }
        }

        FlickableLabel {
            id: overviewLabel
            width: overviewTurnable.itemWidth
            height: overviewTurnable.itemHeight
            font.pixelSize: Theme.fontSizeSmall
        }
    }
}
