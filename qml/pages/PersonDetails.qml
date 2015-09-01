import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

DetailsPage {
    id: page
    property TraktPerson person

    onPersonChanged: {
        if (person) {
            person.load();
        }
    }

    sourcePortrait: person.images.headshot.medium
    title: person.name

    DetailsFlickablePage {
        ItemDetails {
            anchors.fill: parent
            image: person.images.headshot.thumb
            overview: person.biography
            details: [
                Label {
                    width: parent.width
                    text: Qt.formatDate(person.birthday)
                },

                Label {
                    width: parent.width
                    text: person.birthplace
                    wrapMode: Text.WordWrap
                },

                Label {
                    width: parent.width
                    text: person.death
                    visible: !!person.death
                },

                Button {
                    width: parent.width
                    //: Homepage of a movie/show/...
                    //% "Homepage"
                    text: qsTrId("item-homepage")
                    visible: !!person.homepage

                    onClicked: Qt.openUrlExternally(person.homepage)
                }
            ]
        }
    }
}
