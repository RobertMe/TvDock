import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0

Page {
    id: root
    allowedOrientations: defaultAllowedOrientations

    property url sourcePortrait
    property url sourceLandscape
    property alias title: header.title
    default property alias contents: view.contents

    property PullDownMenu pullDownMenu

    onPullDownMenuChanged: {
        if (pullDownMenu) {
            pullDownMenu.parent = flickable;
        }
    }

    Image {
        anchors.fill: parent

        fillMode: Image.PreserveAspectCrop
        opacity: .25

        CacheImage {
            source: root.isPortrait ? root.sourcePortrait : root.sourceLandscape
        }

        Rectangle {
            anchors.fill: parent
            color: Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity)
        }
    }

    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        contentHeight: height

        PageHeader {
            id: header
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
            }
            y: header.height - (root.isPortrait ? Theme.paddingLarge : Theme.paddingMedium)
            height: flickable.height - y
        }
    }
}
