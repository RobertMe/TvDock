import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.tvdock 1.0

Page {
    id: page

    ListModel {
        id: menuItems

        ListElement {
            //: "Movies" entry in the main menu
            //% "Movies"
            title: QT_TRID_NOOP("menu-movies")
            pageName: "Movies.qml"
        }
    }

    SilicaListView {
        anchors.fill: parent
        header: PageHeader {
            title: "TVDock"
        }

        model: menuItems
        delegate: ListItem {
            height: Theme.itemSizeLarge
            Label {
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    right: parent.right
                    leftMargin: Theme.paddingLarge
                    rightMargin: Theme.paddingLarge
                }

                text: qsTrId(title)
                color: Theme.highlightColor
                truncationMode: TruncationMode.Fade
            }

            onClicked: pageStack.push(pageName)
        }
    }
}
