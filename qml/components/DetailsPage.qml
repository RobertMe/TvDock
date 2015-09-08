import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0

Page {
    id: root
    allowedOrientations: defaultAllowedOrientations

    property url sourcePortrait
    property url sourceLandscape
    default property alias contents: view.contents
    property variant item

    onItemChanged: {
        if (item) {
            item.load();
        }
    }

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

    BusyIndicator {
        size: BusyIndicatorSize.Large
        anchors.centerIn: parent
        running: item.loading
        visible: item.loading
    }

    Label {
        //% "Error loading '%1'"
        text: qsTrId("item-error").arg(item.title)
        font.pixelSize: Theme.fontSizeLarge
        color: Theme.highlightColor
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width - (Theme.paddingLarge * 2)
        x: Theme.paddingLarge
        wrapMode: Text.Wrap
        horizontalAlignment: lineCount === 1 ? Text.AlignHCenter : Text.AlignLeft
        visible: item.error
    }

    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        contentHeight: height

        PageHeader {
            id: header
            wrapMode: Text.Wrap
            title: item.title

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
            visible: item.loaded
        }
    }
}
