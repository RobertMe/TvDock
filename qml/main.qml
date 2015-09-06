import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow
{
    property variant coverData

    initialPage: trakt.authenticator.authorizing ? authenticatingComponent : mainMenuComponent

    function goToMain() {
        pageStack.clear();
        pageStack.push(mainMenuComponent);
    }

    function showCover(name, data) {
        var coverUrl = Qt.resolvedUrl("cover/" + name + ".qml");
        //when the app is started and the user authenticated, the MainMenu will be shown,
        //and initialy push the cover, while there is no active page (because of clear + push)
        //at this point the cover won't be updated/shown, but the cover property will contain
        //the new value so re-setting it won't work (change isn't emitted). So this means we
        //shouldn't update cover while there is no page set.
        if (pageStack.currentPage) {
            if (cover !== coverUrl) {
                cover = coverUrl;
            }
            coverData = data;
        }
    }

    Component {
        id: mainMenuComponent
        MainMenu {}
    }

    Component {
        id: authenticatingComponent
        Authenticating {}
    }

    cover: Qt.resolvedUrl("cover/Default.qml")
}
