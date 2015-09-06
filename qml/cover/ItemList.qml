import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0

CoverBackground {
    property variant items: coverData.items
    property string title: coverData.title

    SilicaGridView {
        id: grid
        property int columnCount: Math.round(width / 75)

        anchors.fill: parent
        cellWidth: width / columnCount
        cellHeight: cellWidth * 1.5
        opacity: .5

        model: items

        delegate: Image {
            width: grid.cellWidth
            height: grid.cellHeight

            fillMode: Image.PreserveAspectFit

            CacheImage {
                source: image.thumb
            }
        }

        Rectangle {
            anchors.fill: parent
            color: Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity)
        }
    }

    Label {
        anchors {left: parent.left; right: parent.right; bottom: parent.bottom; margins: Theme.paddingSmall}
        text: title
        fontSizeMode: Text.HorizontalFit
        minimumPixelSize: Theme.fontSizeSmall
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
    }
}
