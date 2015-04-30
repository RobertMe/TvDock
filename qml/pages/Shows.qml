import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0

Page {
    id: page
    property string mode
    property alias model: grid.model

    SilicaGridView {
        id: grid

        property int columnCount: Math.round(parent.width / 150)

        header: PageHeader {
            //: Header of TV shows listing, containing the mode name
            //% "TV Shows: %1"
            title: qsTrId("shows-header").arg(qsTrId("list-" + page.mode));
        }

        anchors.fill: parent
        cellWidth: parent.width / columnCount
        cellHeight: cellWidth * 1.5

        delegate: ListItem {
            width: grid.cellWidth
            contentHeight: grid.cellHeight

            onClicked: pageStack.push("ShowDetails.qml", {show: grid.model.at(index)})

            Image {
                width: grid.cellWidth
                height: grid.cellHeight
                fillMode: Image.PreserveAspectFit

                CacheImage {
                    source: images.poster.thumb
                }
            }
        }
    }
}
