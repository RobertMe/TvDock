import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0

CoverBackground {
    property QtObject item: coverData.item

    Image {
        anchors.fill: parent

        fillMode: Image.PreserveAspectCrop
        opacity: .5

        CacheImage {
            source: item.image.thumb
        }

        Rectangle {
            anchors.fill: parent
            color: Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity)
        }
    }
}
