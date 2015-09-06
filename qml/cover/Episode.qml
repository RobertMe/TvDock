import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0

CoverBackground {
    property QtObject episode: coverData.episode

    Image {
        width: parent.width
        height: width / (16/9)

        fillMode: Image.PreserveAspectCrop
        opacity: .5

        CacheImage {
            source: episode.images.screenshot.thumb
        }

        Rectangle {
            anchors.fill: parent
            color: Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity)
        }
    }

    Column {
        anchors {left: parent.left; right: parent.right; verticalCenter: parent.verticalCenter; margins: Theme.paddingSmall}

        Label {
            width: parent.width
            text: episode.season.show.title
            fontSizeMode: Text.HorizontalFit
            minimumPixelSize: Theme.fontSizeSmall
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        Label {
            width: parent.width
            text: episode.season.number + "x" + episode.number + ": " + episode.title
            fontSizeMode: Text.HorizontalFit
            minimumPixelSize: Theme.fontSizeSmall
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }
    }
}
