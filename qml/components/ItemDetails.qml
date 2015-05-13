import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../Utils.js" as Utils


Item {
    id: root

    property alias details: detailsColumn.children
    property alias image: cachePoster.source
    property alias overview: overviewLabel.text
    property Page _page: Utils.findPage(root)

    anchors {
        leftMargin: Theme.paddingLarge
        rightMargin: Theme.paddingLarge
        bottomMargin: Theme.paddingLarge
    }

    Turnable {
        id: overviewTurnable
        anchors.fill: parent

        Row {
            id: row
            width: overviewTurnable.itemWidth
            height: childrenRect.height

            spacing: Theme.paddingMedium

            Image {
                id: poster
                width: Theme.itemSizeLarge * 2
                height: width * 1.5
                fillMode: Image.PreserveAspectFit

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
            height: overviewTurnable.columns === 1 ? overviewTurnable.height - row.height : overviewTurnable.height
            font.pixelSize: Theme.fontSizeSmall
        }
    }
}
