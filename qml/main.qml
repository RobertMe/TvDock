import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow
{
    initialPage: trakt.authenticator.authorized ? mainMenu : authenticatePage

    Connections {
        target: trakt.authenticator
        onAuthorizedChanged: {
            pageStack.clear();
            pageStack.push(initialPage);
        }
    }

    Component {
        id: mainMenu
        MainMenu {
        }
    }

    Component {
        id: authenticatePage
        Authenticate {
        }
    }

    cover: Qt.resolvedUrl("cover/CoverPage.qml")
}
