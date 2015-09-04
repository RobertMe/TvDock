import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

Page {
    id: page
    property int type
    property string year

    PageHeader {
        id: header
        //% "Search options"
        title: qsTrId("header-search-options")
    }

    Column {
        anchors {top: header.bottom; left: parent.left; right: parent.right; leftMargin: Theme.paddingLarge; rightMargin: Theme.paddingLarge }

        SectionHeader {
            //% "Types"
            text: qsTrId("search-type")
        }

        TextSwitch {
            //% "Movie"
            text: qsTrId("search-type-movie")
            checked: type & TraktSearchModel.TypeMovie
            automaticCheck: false
            onClicked: {
                if (!checked) {
                    page.type |= TraktSearchModel.TypeMovie;
                } else {
                    page.type &= ~TraktSearchModel.TypeMovie;
                }
            }
        }

        TextSwitch {
            //% "Show"
            text: qsTrId("search-type-show")
            checked: type & TraktSearchModel.TypeShow
            automaticCheck: false
            onClicked: {
                if (!checked) {
                    page.type |= TraktSearchModel.TypeShow;
                } else {
                    page.type &= ~TraktSearchModel.TypeShow;
                }
            }
        }

        TextSwitch {
            //% "Episode"
            text: qsTrId("search-type-episode")
            checked: type & TraktSearchModel.TypeEpisode
            automaticCheck: false
            onClicked: {
                if (!checked) {
                    page.type |= TraktSearchModel.TypeEpisode;
                } else {
                    page.type &= ~TraktSearchModel.TypeEpisode;
                }
            }
        }

        TextSwitch {
            //% "Person"
            text: qsTrId("search-type-person")
            checked: type & TraktSearchModel.TypePerson
            automaticCheck: false
            onClicked: {
                if (!checked) {
                    page.type |= TraktSearchModel.TypePerson;
                } else {
                    page.type &= ~TraktSearchModel.TypePerson;
                }
            }
        }

        /*TextSwitch {
            //% "List"
            text: qsTrId("search-type-list")
            checked: type & TraktSearchModel.TypeList
            automaticCheck: false
            onClicked: {
                if (!checked) {
                    page.type |= TraktSearchModel.TypeList;
                } else {
                    page.type &= ~TraktSearchModel.TypeList;
                }
            }
        }*/
    }
}
