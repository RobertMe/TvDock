import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0

Column {
    id: root
    property QtObject people
    property int itemHeight: 195

    SectionHeader {
        //: "Cast" heading of item details
        //% "Cast"
        text: qsTrId("item-cast")
        height: implicitHeight
    }

    SilicaListView {
        id: castListView
        width: parent.width
        height: root.itemHeight

        orientation: Qt.Horizontal
        layoutDirection: Qt.LeftToRight
        clip: true

        model: people.cast
        delegate: ListItem {
            width: root.itemHeight / 1.5
            contentHeight: root.itemHeight

            Image {
                width: root.itemHeight / 1.5
                height: root.itemHeight

                CacheImage {
                    source: images.headshot.thumb
                }
            }
        }
    }

    SectionHeader {
        //: "Crew" heading of item details
        //% "Crew"
        text: qsTrId("item-crew")
        height: implicitHeight
    }

    SilicaListView {
        id: crewListView
        width: parent.width
        height: root.itemHeight

        orientation: Qt.Horizontal
        layoutDirection: Qt.LeftToRight
        clip: true

        model: people.crew
        delegate: ListItem {
            width: root.itemHeight / 1.5
            contentHeight: root.itemHeight

            Image {
                width: root.itemHeight / 1.5
                height: root.itemHeight

                CacheImage {
                    source: images.headshot.thumb
                }
            }
        }
    }
}
