import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0

CoverBackground {
    property QtObject person: coverData.person

    Image {
        anchors.fill: parent

        fillMode: Image.PreserveAspectCrop
        opacity: .5

        CacheImage {
            source: person.images.headshot.thumb
        }

        Rectangle {
            anchors.fill: parent
            color: Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity)
        }
    }

    Label {
        anchors {left: parent.left; right: parent.right; bottom: parent.bottom; margins: Theme.paddingSmall}
        text: person.name
        fontSizeMode: Text.HorizontalFit
        minimumPixelSize: Theme.fontSizeSmall
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
    }
}
