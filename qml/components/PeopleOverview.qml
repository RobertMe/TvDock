import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0

Item {
    id: root
    property QtObject people
    property int itemHeight: 195

    BusyIndicator {
        size: BusyIndicatorSize.Large
        anchors.centerIn: parent
        visible: !root.people.loaded && root.people.loading
        running: visible
    }

    SectionHeader {
        id: castHeader
        anchors.top: parent.top
        //: "Cast" heading of item details
        //% "Cast"
        text: qsTrId("header-cast")
        height: implicitHeight
    }

    SilicaListView {
        id: castListView
        width: parent.width
        height: root.itemHeight
        anchors.top: castHeader.bottom

        orientation: Qt.Horizontal
        layoutDirection: Qt.LeftToRight
        clip: true

        model: people.cast
        delegate: ListItem {
            width: root.itemHeight / 1.5
            contentHeight: root.itemHeight

            onClicked: pageStack.push("../pages/PersonDetails.qml", {person: castListView.model.at(index)})

            Image {
                width: root.itemHeight / 1.5
                height: root.itemHeight

                CacheImage {
                    source: images.headshot.thumb
                }
            }
        }

        HorizontalScrollDecorator {}
    }

    SectionHeader {
        id: crewHeader
        anchors.top: castListView.bottom
        //: "Crew" heading of item details
        //% "Crew"
        text: qsTrId("header-crew")
        height: implicitHeight
    }

    SilicaListView {
        id: crewListView
        width: parent.width
        height: root.itemHeight
        anchors.top: crewHeader.bottom

        orientation: Qt.Horizontal
        layoutDirection: Qt.LeftToRight
        clip: true

        model: people.crew
        delegate: ListItem {
            width: root.itemHeight / 1.5
            contentHeight: root.itemHeight

            onClicked: pageStack.push("../pages/PersonDetails.qml", {person: crewListView.model.at(index)})

            Image {
                width: root.itemHeight / 1.5
                height: root.itemHeight

                CacheImage {
                    source: images.headshot.thumb
                }
            }
        }

        HorizontalScrollDecorator {}
    }
}
