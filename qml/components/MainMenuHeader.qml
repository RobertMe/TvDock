import QtQuick 2.0
import Sailfish.Silica 1.0

Label {
    id: root
    property int maxWidth
    property alias title: root.text

    width: Math.min(implicitWidth, maxWidth - 2*Theme.paddingLarge)
    height: implicitHeight
    truncationMode: TruncationMode.Fade
    color: Theme.highlightColor
    anchors {
        right: parent.right
        rightMargin: Theme.paddingLarge
    }
    font {
        pixelSize: Theme.fontSizeLarge
        family: Theme.fontFamilyHeading
    }
}
