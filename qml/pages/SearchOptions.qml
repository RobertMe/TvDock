import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0
import "../components"

Page {
    id: page
    allowedOrientations: defaultAllowedOrientations
    property int type
    property string year

    PageHeader {
        id: header
        //% "Search options"
        title: qsTrId("header-search-options")
    }

    Turnable {
        id: turnable

        anchors {top: header.bottom; left: parent.left; right: parent.right; leftMargin: Theme.paddingLarge; rightMargin: Theme.paddingLarge }

        Column {
            width: turnable.itemWidth
            height: childrenRect.height

            Label {
                //% "Types"
                text: qsTrId("search-label-type")
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

        Column {
            width: turnable.itemWidth
            height: childrenRect.height

            TextField {
                width: parent.width
                //% "Year"
                placeholderText: qsTrId("search-placeholder-year")
                //% "Year"
                label: qsTrId("search-label-year")
                inputMethodHints: Qt.ImhDigitsOnly

                onTextChanged: page.year = text
            }
        }
    }
}
