import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow
{
    initialPage: trakt.authenticator.authorizing ? authenticatingComponent : mainMenuComponent

    function goToMain() {
        pageStack.clear();
        pageStack.push(mainMenuComponent);
    }

    Component {
        id: mainMenuComponent
        MainMenu {}
    }

    Component {
        id: authenticatingComponent
        Authenticating {}
    }

    cover: Qt.resolvedUrl("cover/CoverPage.qml")
}
